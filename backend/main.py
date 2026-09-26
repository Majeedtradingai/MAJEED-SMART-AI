import os
from contextlib import asynccontextmanager
from typing import Any

from fastapi import Depends, FastAPI, Header, HTTPException

from angel_one import AngelOneMarketService

class Settings:
    angel_api_key = os.getenv("ANGEL_API_KEY", "")
    angel_client_code = os.getenv("ANGEL_CLIENT_CODE", "")
    angel_pin = os.getenv("ANGEL_PIN", "")
    angel_totp_secret = os.getenv("ANGEL_TOTP_SECRET", "")
    backend_api_token = os.getenv("BACKEND_API_TOKEN", "")

settings = Settings()
market = AngelOneMarketService(settings)

def require_app_token(x_app_token: str | None = Header(default=None)) -> None:
    if settings.backend_api_token and x_app_token != settings.backend_api_token:
        raise HTTPException(status_code=401, detail="Invalid app token")

@asynccontextmanager
async def lifespan(app: FastAPI):
    market.start()
    yield

app = FastAPI(title="MAJEED SMART AI Backend", version="1.0.0", description="Cloud FastAPI backend for MAJEED SMART AI market data.", lifespan=lifespan)

@app.get("/")
def root() -> dict[str, str]:
    return {"app": "MAJEED SMART AI", "service": "cloud-backend", "mode": "PAPER", "status": "ok"}

@app.get("/api/health")
def health(_: Any = Depends(require_app_token)) -> dict[str, Any]:
    snapshot = market.snapshot()
    return {"status": "ok", "angel_one_connected": snapshot["connected"], "timestamp": snapshot["timestamp"], "last_error": snapshot["last_error"]}

@app.get("/api/market/status")
def market_status(_: Any = Depends(require_app_token)) -> dict[str, Any]:
    snapshot = market.snapshot()
    return {"provider": snapshot["provider"], "connected": snapshot["connected"], "market_status": "LIVE" if snapshot["connected"] else "OFFLINE", "timestamp": snapshot["timestamp"], "last_error": snapshot["last_error"]}

@app.get("/api/market/indices")
def market_indices(_: Any = Depends(require_app_token)) -> dict[str, Any]:
    snapshot = market.snapshot()
    return {"provider": snapshot["provider"], "connected": snapshot["connected"], "timestamp": snapshot["timestamp"], "indices": snapshot["prices"]}

@app.get("/api/signal")
def signal_placeholder(_: Any = Depends(require_app_token)) -> dict[str, Any]:
    return {"mode": "PAPER", "status": "NOT_READY", "message": "Signal engine will be connected after live market feed validation."}
