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