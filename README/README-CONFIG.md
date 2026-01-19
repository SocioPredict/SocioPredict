# Platform Economics

SocioPredict's economic parameters are configurable through YAML settings. These control market creation costs, user balances, betting limits, and incentives.

```yaml
economics:
  marketcreation:
    initialMarketProbability: 0.5
    initialMarketSubsidization: 10
    initialMarketYes: 0
    initialMarketNo: 0
  marketincentives:
    createMarketCost: 1
    traderBonus: 2
  user:
    initialAccountBalance: 0
    maximumDebtAllowed: 500
  betting:
    minimumBet: 1
    betFee: 0
    sellSharesFee: 0
```

These settings apply globally to an instance. Configure them before installation as they're intended to remain stable throughout the platform's operation.

Future versions may support dynamic economics with transparency logs showing when and how parameters changed.
