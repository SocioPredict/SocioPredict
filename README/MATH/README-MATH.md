## Prediction Market Mathematics

For background reading, see the [Wikipedia article on prediction markets](https://en.wikipedia.org/wiki/Prediction_market).

### Why Market Mechanisms Matter

Prediction markets let people trade contracts on future outcomes. Unlike stock exchanges with institutional market makers providing liquidity, prediction platforms need automated mechanisms to ensure trades execute smoothly.

Think of it this way: if you're selling a lamp on a classifieds site, waiting a few days for a buyer is fine. But financial instruments need immediate execution, or traders go elsewhere.

SocioPredict uses mathematical market mechanisms built into the software rather than relying on external market makers or bots.

### Understanding the Platform Economics

Imagine a small community where instead of fixed prices, everything trades through predictions. Participants can borrow credits and bet on outcomes. When results come in, the pool redistributes to those who predicted correctly.

This creates:
- **Winners and losers** based on prediction accuracy
- **Need for debt management** and credit limits
- **Potential inflation** if too many credits enter circulation
- **Trust requirements** - participants must believe the system is fair

### Probability Updates: Weighted Probability Adjustment Model (WPAM)

WPAM calculates how each bet moves the market probability:

```
P_new = (P_initial × I_initial + A_YES) / (I_initial + A_YES + A_NO)

Where:
- P_new = updated probability
- P_initial = starting probability (typically 0.5)
- I_initial = initial market investment (e.g., 10 points)
- A_YES = total amount bet on YES
- A_NO = total amount bet on NO
```

The initial investment acts as a stabilizer - larger initial investments mean bets need to be bigger to move the market significantly.

#### Example Calculations

Starting with I_initial=10, P_initial=0.50:

1. **20-point NO bet**: P = 5/30 ≈ 0.167
2. **10-point YES bet**: P = 15/20 = 0.75
3. **20-point NO bet after #2**: P = 5/30 ≈ 0.167

### Alternative: Constant Product Market Maker (CPMM)

Used in crypto exchanges like Uniswap, CPMM maintains a constant ratio:

```
k = x × y
```

Liquidity providers earn fees for keeping the market liquid. While CPMM doesn't directly calculate probabilities, it influences trader behavior and indirectly affects perceived odds.

### Payout Calculations

See [detailed payout formulas](/README/MATH/README-MATH-PROB-AND-PAYOUT.md) for how winnings distribute after market resolution.
