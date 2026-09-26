# MAJEED SMART AI V1

## Cloud architecture

Flutter APK -> HTTPS -> FastAPI -> Angel One SmartAPI -> live NIFTY/BANKNIFTY feed

The first cloud milestone is PAPER MODE only. No real-order endpoint is included.

## Backend

Backend files are under `backend/`.

- `backend/main.py` - FastAPI API
- `backend/angel_one.py` - Angel One session and WebSocket feed
- `backend/requirements.txt` - Python dependencies
- `backend/render.yaml` - Render deployment definition
- `backend/.env.example` - secret names only

## Security

Broker credentials must be stored only in the cloud provider's secret/environment-variable store. Never commit API keys, PINs, TOTP secrets, JWTs, refresh tokens, or feed tokens to GitHub.

Render supports encrypted environment-variable management, and its documentation recommends keeping secret credentials out of source control. A continuously running market feed should use a non-sleeping service because Render's free web services can spin down after inactivity.

## API

- GET `/`
- GET `/api/health`
- GET `/api/market/status`
- GET `/api/market/indices`
- GET `/api/signal`

## Deployment

Connect this repository to a Render Web Service and use the included `render.yaml`, then add the four Angel One secrets in the Render Environment settings.

After deployment, test the health endpoint first. Then test `/api/market/indices`. The Flutter app will be connected to this backend only after the backend feed is verified.

Real order execution remains disabled in this milestone.