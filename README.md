# Portfolio Tracker

[![Flutter CI](https://github.com/dalayhoailinh/portfolio_tracker/actions/workflows/ci.yml/badge.svg)](https://github.com/dalayhoailinh/portfolio_tracker/actions/workflows/ci.yml)

A Flutter mini-trading app with fake real-time market data, buy/withdraw flow, live PnL, multi-timeframe candlestick chart, and full local persistence. Built across one week as the Q1 Week 12 checkpoint of the 2026 roadmap.

**Live demo:** https://portfoliotracker-dusky.vercel.app


## Overview

Five fake stocks tick once per second. The user starts with $10,000 cash and can buy or withdraw any quantity at the current price. Every minute, one m1 candle is closed and persisted locally. The chart supports m1 / m5 / m15 / m30 / h1 timeframes rendered by a hand-built `CustomPainter`. Everything animates smoothly and survives an app restart.

## Architecture

\`\`\`
lib/
├── app/
│   ├── app.dart           # MaterialApp.router + ProviderScope
│   └── router.dart        # GoRouter with auth guard and chart deep link
├── core/
│   ├── constants/         # AppColors, AppTextStyles, AnimationConstants
│   └── widgets/
│       └── animations/    # PriceFlash, AnimatedNumberText, AnimatedPnlText, LivePulse
└── features/
    ├── auth/              # AuthState enum, AuthNotifier, RouterNotifier, LoginPage
    ├── market/            # Stock/candle models, tick engine, aggregator, CustomPainter chart
    └── portfolio/         # Position entity, trading exceptions, buy/withdraw flows, Home page
\`\`\`

## Rust engine (Q2 Tháng 4 checkpoint)

Native indicator math now runs in Rust via `flutter_rust_bridge` v2.

```
presentation   ChartPage → smaOverlayProvider → CandlestickPainter
domain         IIndicatorEngine (pure Dart contract)
data           RustIndicatorEngine → lib/src/rust (generated) → rust/src/api
               DartIndicatorEngine (web fallback + benchmark baseline)
```

- The bridge is hidden behind `IIndicatorEngine`. Exactly one file imports
  generated bindings. UI and domain are FFI-free.
- On web (Vercel) the app falls back to the Dart engine — no WASM build yet.
- Per-tick scalar math (P&L, %change) stays in Dart **on purpose**: each
  bridge call pays a fixed overhead, so only batch math earns its ticket
  to Rust. Measured, not assumed:

| Scenario (release, Windows desktop)        | Dart     | Rust      |
|--------------------------------------------|----------|-----------|
| SMA-20, 10,000 prices                      | 71 us    | 632 us    |
| SMA-20, 100,000 prices                     | 4343 us  | 10344 us  |
| 1,000 calls × 50 prices (same total work)  | 531 us   | 88712 us  |
| 1 call × 50,000 prices (same total work)   | 983 us   | 3781 us   |

Rule learned: **batch, not per-call** — move math across the bridge only
when computation cost ≫ bridge overhead.

## Real market data (Q2 Tháng 5 - EODHD)

Historical daily OHLCV now comes from the EODHD REST API.

```
presentation   RealChartPage → dailyCandlesProvider → CandlestickChart
domain         IMarketDataSource (pure Dart contract)
               MarketDataException family (NetworkException, ApiKeyException, ...)
data           EodhdDataSource → http.get → EODHD
               EodCandleDto.fromJson → MinuteCandle (anti-corruption mapping)
```

- The HTTP API is hidden behind `IMarketDataSource`. UI and domain are
  HTTP-free and JSON-free; swapping EODHD for Alpaca = one new class.
- Every network/HTTP failure is translated into a typed domain error; the
  UI shows a friendly message + Retry, never a raw stack trace.
- The `http.Client` is injected, so the data source is unit-tested with a
  fake client — no network needed.
- API key is passed via `--dart-define=EODHD_API_KEY=...`; the committed
  default is EODHD's public `demo` token. Never commit a real key.

Run with a real key:
`flutter run -d windows --dart-define=EODHD_API_KEY=your_key`

## Real-time market data (Q2 Tháng 5 — Alpaca WebSocket)

Live prices now stream from Alpaca's crypto WebSocket (24/7).

```
presentation   LivePricesPage → livePricesProvider (StreamProvider) → PriceFlash
domain         ILivePriceSource (pure Dart contract, returns Stream<LiveTick>)
               LiveStreamException (in the MarketDataException family)
data           AlpacaPriceStream → WebSocket (handshake: auth → subscribe)
               AlpacaFrameParser.parseTrades → LiveTick (anti-corruption mapping)
               TextSocket abstraction → injectable → testable with a fake socket
```

- The WebSocket is hidden behind `ILivePriceSource`. UI and domain are
  socket-free and JSON-free; swapping Alpaca for another feed = one new class.
- A one-shot REST fetch is a `Future`; a live feed is a `Stream`. Same wall.
- Connection/auth/drop failures are translated into a typed `LiveStreamException`;
  the UI shows a friendly message + Retry, never a raw error.
- `autoDispose` + the controller's `onCancel` close the socket when the page is
  gone — no leaked connection (the free tier allows only one).
- The socket is injected (`TextSocket`), so the stream is unit-tested with a
  fake — no network needed.
- Keys are passed via `--dart-define`; nothing secret is committed.

Run with live data:
`flutter run -d windows --dart-define=ALPACA_KEY=your_key --dart-define=ALPACA_SECRET=your_secret`

## Features

| Guide | Feature |
|-------|---------|
| 1     | Project setup, routing, theme, empty screens |
| 2     | Auth flow with Riverpod + GoRouter redirect |
| 3     | Fake tick engine, m1 candle storage, portfolio base state, reset actions |
| 4     | Add Stock search/select/buy, withdraw sheet, live PnL recompute |
| 5     | m1→m5/m15/m30/h1 aggregation, CustomPainter candlestick, timeframe chips |
| 6     | Price flash, number tweens, position list slide-in/out, chart crossfade, live pulse |
| 7     | Unit + widget tests, GitHub Actions CI, Vercel deploy, documentation |

## Tech stack

- Flutter 3.35 + Dart 3.11
- Riverpod for state management
- GoRouter for navigation and auth redirect
- Freezed + json_serializable for immutable entities
- SharedPreferences for local persistence
- CustomPaint for chart rendering
- Mockito + fake_async + flutter_test for the test suite
- GitHub Actions for CI
- Vercel for web hosting

## Local setup

\`\`\`bash
git clone https://github.com/dalayhoailinh/portfolio_tracker.git
cd portfolio_tracker
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
\`\`\`

## Running tests

\`\`\`bash
flutter test
flutter test --coverage
\`\`\`

## Build web

\`\`\`bash
flutter build web --release --wasm --no-tree-shake-icons
\`\`\`

The output lands in `build/web/`. Any static host will serve it.

## Guide summaries

### Guide 1 - Project setup
- Flutter project, GoRouter, AppColors / AppTextStyles, empty screens, base navigation.

### Guide 2 - Authentication
- AuthState enum, AuthNotifier, RouterNotifier, auth-aware redirect, demo login/logout flow.

### Guide 3 - Market engine and persistence
- Freezed Stock / MinuteCandle, MarketTimeframe enum, 1-second tick engine, 60-tick candle close, local storage for market and portfolio state, reset actions.

### Guide 4 - Trading flow
- Position entity with cost / PnL getters, trading exceptions, buy and withdraw with validation, PortfolioNotifier listening to MarketNotifier for live unrealized PnL, Add Stock page, Withdraw bottom sheet.

### Guide 5 - Chart pipeline
- CandleAggregator for m1 → higher timeframes, aggregatedCandlesProvider.family, CustomPainter candlestick with grid and right-axis price labels, TimeframeSelector chips, live-updating ChartPage.

### Guide 6 - Realtime animation and polish
- Shared animation widgets (PriceFlash, AnimatedNumberText, AnimatedPnlText, LivePulse), flash on tick, number tweens, position slide-in/out, timeframe chip transitions, chart crossfade.

### Guide 7 - Tests, CI, and web deploy
- 20+ unit and widget tests for entities, aggregator, trading flow, and Add Stock / Withdraw UIs.
- GitHub Actions workflow: analyze → test → web build.
- Vercel deployment with SPA rewrites for GoRouter deep links.
- Finalized README with architecture, features, local setup, and guide summaries.