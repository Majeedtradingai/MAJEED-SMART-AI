import logging
import threading
import time
from datetime import datetime, timezone
from typing import Any

import pyotp
from SmartApi.smartConnect import SmartConnect
from SmartApi.smartWebSocketV2 import SmartWebSocketV2

logger = logging.getLogger("majeed.angel")
NIFTY_TOKEN = "99926000"
BANKNIFTY_TOKEN = "99926009"

class AngelOneMarketService:
    """Angel One session + SmartAPI WebSocket market feed.

    Credentials are read only from server environment variables.
    No broker secret is returned by this service.
    """
    def __init__(self, settings: Any) -> None:
        self.settings = settings
        self.api = None
        self.ws = None
        self._thread: threading.Thread | None = None
        self._lock = threading.Lock()
        self._prices: dict[str, dict[str, Any]] = {}
        self.connected = False
        self.last_error: str | None = None

    def start(self) -> None:
        if self._thread and self._thread.is_alive():
            return
        self._thread = threading.Thread(target=self._run, daemon=True, name="angel-feed")
        self._thread.start()

    def _run(self) -> None:
        while True:
            try:
                self._connect()
                return
            except Exception as exc:
                self.connected = False
                self.last_error = str(exc)
                logger.exception("Angel One feed connection failed")
                time.sleep(15)

    def _connect(self) -> None:
        required = [self.settings.angel_api_key, self.settings.angel_client_code, self.settings.angel_pin, self.settings.angel_totp_secret]
        if not all(required):
            raise RuntimeError("Angel One secrets are not configured in the cloud service.")

        self.api = SmartConnect(self.settings.angel_api_key)
        totp = pyotp.TOTP(self.settings.angel_totp_secret).now()
        login = self.api.generateSession(self.settings.angel_client_code, self.settings.angel_pin, totp)
        if not login.get("status"):
            raise RuntimeError(login.get("message", "Angel One login failed"))

        auth_token = login["data"]["jwtToken"]
        feed_token = login["data"]["feedToken"]
        self.ws = SmartWebSocketV2(auth_token, self.settings.angel_api_key, self.settings.angel_client_code, feed_token, max_retry_attempt=5, retry_strategy=1, retry_delay=5, retry_multiplier=2, retry_duration=5)
        self.ws.on_open = self._on_open
        self.ws.on_data = self._on_data
        self.ws.on_error = self._on_error
        self.ws.on_close = self._on_close
        self.ws.on_control_message = self._on_control
        self.ws.connect()

    def _on_open(self, wsapp) -> None:
        self.connected = True
        self.last_error = None
        self.ws.subscribe("majeed01", 1, [{"exchangeType": 1, "tokens": [NIFTY_TOKEN, BANKNIFTY_TOKEN]}])
        logger.info("Angel One WebSocket connected")

    def _on_data(self, wsapp, message: dict[str, Any]) -> None:
        token = str(message.get("token", ""))
        price_raw = message.get("last_traded_price")
        if token not in (NIFTY_TOKEN, BANKNIFTY_TOKEN) or price_raw is None:
            return
        price = float(price_raw) / 100.0
        symbol = "NIFTY" if token == NIFTY_TOKEN else "BANKNIFTY"
        with self._lock:
            self._prices[symbol] = {"symbol": symbol, "ltp": price, "token": token, "timestamp": datetime.now(timezone.utc).isoformat(), "market_status": "LIVE"}

    def _on_error(self, wsapp, error) -> None:
        self.connected = False
        self.last_error = str(error)
        logger.error("Angel One WebSocket error: %s", error)

    def _on_close(self, wsapp) -> None:
        self.connected = False
        logger.warning("Angel One WebSocket closed")

    def _on_control(self, wsapp, message) -> None:
        logger.debug("Angel One control message: %s", message)

    def snapshot(self) -> dict[str, Any]:
        with self._lock:
            prices = dict(self._prices)
        return {"provider": "angel_one", "connected": self.connected, "last_error": self.last_error, "timestamp": datetime.now(timezone.utc).isoformat(), "prices": prices}
