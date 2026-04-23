# Portfolio Tracker
## Overview
Portfolio Tracker is a Flutter app that allows users to track their stock portfolio performance. Users can add stocks, view their portfolio value, and see performance charts.
## Guide 1 Summary
- Set up Flutter project and installed GoRouter.
- Created color palette and typography definitions.
- Created empty screens for Login, Home, Add Stock, and Chart.
- Configured GoRouter for basic navigation between screens.
## Guide 2 Summary
- Implemented authentication state management using Riverpod.
- Created AuthState enum to represent authentication states.
- Created AuthNotifier to manage authentication state and provide login/logout methods.
- Created RouterNotifier to handle route redirection based on authentication state.
- Updated router to use RouterNotifier for redirection, app with routerProvider and main with ProviderScope.
- Updated Login Page with login button that calls AuthNotifier login method and Home Page with logout button
## Guide 3 Summary
- Added Freezed models for stock, m1 candle, and portfolio state.
- Added MarketTimeframe enum (m1, m5, m15, m30, h1).
- Added fake market tick engine and 60-tick candle close.
- Added local persistence for market and portfolio state.
- Added portfolio `totalEquity` and `unrealizedPnL` support.
- Fixed Home page to show true Equity and Unrealized PnL values.
- Added reset portfolio and reset market actions.
## Guide 4 Summary
- Added Position Freezed entity with cost and PnL getters.
- Added trading exceptions for cash, quantity, and position validation.
- Updated PortfolioState to carry a positions map and corrected totalEquity formula.
- Updated PortfolioNotifier with buy and withdraw methods and a live market listener for unrealized PnL.
- Added PositionTile widget and a position list section on Home.
- Built Add Stock page with search, select, and buy flow.
- Built Withdraw bottom sheet with quantity validation.
- Verified live PnL updates every 1 second and full persistence across app restart.
## Guide 5 Summary
- Added CandleAggregator service that groups m1 candles into m5, m15, m30, and h1 buckets using timeframe multiplier.
- Added aggregatedCandlesProvider (Provider.family) that watches marketProvider and exposes live aggregated candles by symbol + timeframe.
- Added CandlestickPainter with 5-line grid, right-axis price labels, padded price range, and green/red bodies and wicks.
- Added CandlestickChart wrapper with LayoutBuilder, RepaintBoundary, and a friendly empty state.
- Added TimeframeSelector chip bar for m1, m5, m15, m30, h1.
- Upgraded ChartPage into a ConsumerStatefulWidget that accepts a symbol path parameter, reads live price from marketProvider, and lets the user switch timeframes with local state.
- Updated router to use /chart/:symbol path parameter.
- Wired Home market list tiles to push to /chart/:symbol on tap.
- Verified timeframe switching, live candle updates, candle close, and persistence across app restart.
## Guide 6 Summary
- Added shared animation widgets under core/widgets/animations: PriceFlash, AnimatedNumberText, AnimatedPnlText, LivePulse.
- Added green/red flash behind stock prices on every tick and smooth number tweening in StockTile.
- Replaced static PnL and equity text in PortfolioSummaryCard and PositionTile with AnimatedNumberText + AnimatedPnlText for smooth value tween and color fade on sign flip.
- Added PositionListEntry wrapper + AnimatedSize + AnimatedSwitcher so new positions slide in and removed positions fade out.
- Added AnimatedContainer + AnimatedDefaultTextStyle to TimeframeSelector for smooth chip color and weight transitions.
- Wrapped CandlestickChart in AnimatedSwitcher keyed by timeframe for a clean 250ms crossfade on timeframe switch.
- Added LivePulse dot next to the price in the chart header for a breathing live indicator.
- Verified flash does not stack on 1-second ticks and crossfade does not run on candle close.