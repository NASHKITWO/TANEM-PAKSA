# Tanem Paksa

Tanem Paksa is a pixel farming game for the browser and Android, built with Flutter and Flame. Players buy seeds, plant, harvest, and sell crops, play alongside other farmers and the Pak Tani AI assistant, and can record their farm on Ethereum Sepolia after signing in with Privy.

## Founder

Tanem Paksa is founded and developed by **Muhammad Ikhsan**, Teknik Informatika, Universitas Pamulang.

- Email: ican3192@gmail.com
- Instagram: [@ikhsan2.1](https://instagram.com/ikhsan2.1)
- GitHub: [NASHKITWO](https://github.com/NASHKITWO)

## Features

- Farming loop: buy land, buy seeds (potato, onion, strawberry, beet), plant, wait, harvest, sell.
- Daily quests, XP and levels, achievements, and unlockable farmer outfits visible to other players.
- Multiplayer presence and chat over Socket.IO, plus Pak Tani AI, which plants and harvests on request (Groq LLM with a rule-based fallback).
- Privy login with email, Google, or an existing wallet. An embedded Sepolia wallet is created for new players, and guest progress is carried over once (capped).
- Server-validated economy: prices, grow time, and inventory are checked on the server before any transaction is sent.
- On-chain records on Sepolia: land as ERC-721, seeds and crops as ERC-1155, and the TANI ERC-20 token. Game Coin can be swapped to TANI or Sepolia ETH, within daily limits.
- In-game status strip (account, Sepolia, server, multiplayer, AI) and a transaction history that links to Etherscan.

## Architecture

```
Flutter web / APK ──► Vercel (contracts/)
   │                    ├─ static: landing page, /main/ game, /masuk/ Privy login
   │                    └─ api/[...path].js: /auth/privy, /player, /game-actions, /health
   │                         │
   │                         ├─ Neon Postgres: sessions, player state, rate limits,
   │                         │  idempotency keys, daily limits, audit log
   │                         └─ backend signer ──► Sepolia contracts
   │
   └─────────────────► srv (always on): Socket.IO multiplayer + Pak Tani AI

## Repository layout

- `taniin_flutter/` — Flutter app (game, HUD, state, Privy session handling, Android host).
- `contracts/lib/` — backend: economy rules, Privy sessions, player service, chain executor, multiplayer.
- `contracts/api/` — single Vercel function that routes every API path.
- `contracts/masuk/` — Privy login page (React, bundled with esbuild at deploy time).
- `contracts/public/` — landing page and static assets; the Flutter web build goes to `public/main/`.
- `contracts/contracts/` — Solidity contracts and Hardhat config.
- `docs/` — product plans and the design and implementation plan for this release.

## Running locally

Requirements: Node.js 20+, Flutter stable, and (for Android) JDK 17 with the Android SDK.

```bash
cp .env.example .env        # fill in DATABASE_URL, PRIVY_*, DEPLOYER_PRIVATE_KEY
cd contracts
npm install
npx hardhat test            # backend and contract tests (uses in-memory Postgres)
npm run game-api            # API + multiplayer on http://127.0.0.1:8787
```

Flutter web against the local server:

```bash
cd taniin_flutter
flutter run -d chrome \
  --dart-define=TANIIN_GAME_API_URL=http://127.0.0.1:8787 \
  --dart-define=TANIIN_MULTIPLAYER_URL=http://127.0.0.1:8787
```

## License

MIT. See `LICENSE`.
