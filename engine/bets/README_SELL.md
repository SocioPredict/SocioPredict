## Share Selling Flow

How the system processes sell requests:

```
User submits Sell Request (marketID, outcome, creditAmount)
│
├── Process all bets chronologically
│   │
│   ├── BUY bets (Amount > 0):
│   │   ├── Update user position (shares, value)
│   │   └── Update total market volume
│   │
│   └── SELL bets (Amount < 0):
│       ├── Look up current position
│       ├── Calculate value per share
│       ├── Compute shares sold and actual credits
│       └── Track any dust (rounding differences)
│
└── Output:
    ├── Final market volume including dust
    ├── Updated user balance
    └── New negative bet recorded
```

### Dust Calculation

`GetMarketVolume` must compute market dust statelessly by:
1. Tracking user positions through buy history
2. For each sell, calculating value/share at that moment
3. Comparing requested vs actual credits
4. Accumulating the difference as dust

Dust represents rounding losses that get absorbed into market liquidity.
