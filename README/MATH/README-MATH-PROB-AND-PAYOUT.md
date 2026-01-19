## Probability and Payout Mechanics

Two key phases in prediction market trading:

1. **During trading**: Buyers and sellers determine prices through their actions
2. **At resolution**: Final probability determines how payouts distribute

We use two mathematical frameworks:
- **WPAM** (Weighted Probability Adjustment Model) for probability updates
- **DBPM** (Divergence-Based Payout Model) for fair payouts

---

### WPAM: Probability Updates

```math
P_{new} = \frac{P_{initial} \times I_{initial} + A_{YES}}{I_{initial} + A_{YES} + A_{NO}}
```

- P_initial: Starting probability (usually 0.5)
- I_initial: Initial market investment (stabilizer)
- A_YES/A_NO: Cumulative bet amounts

Larger initial investments create more stable markets that require bigger bets to move.

---

### DBPM: Payout Distribution

Simply dividing winnings by bet size doesn't reward those who spotted market inefficiencies. DBPM rewards bets that diverged from the final outcome.

#### Step 1: Split the Pool

```math
S_{YES} = S \cdot R
S_{NO} = S \cdot (1 - R)
```

Where R is the resolution probability and S is the total pool.

#### Step 2: Calculate Reward Factors

For each bet:
```math
d_i = |R - p_i|
C_i = d_i \times b_i
```

Where d_i rewards bets placed when probability differed most from the final result.

#### Step 3: Normalize to Available Capital

```math
F = \min(1, \frac{S}{C})
```

Scales payouts down if calculated amounts exceed available funds. Never scales up to prevent unintended windfalls.

#### Step 4: Distribute

Apply normalization factor to each participant's course payout.

---

For implementation details, search the codebase for `WPAM` and `DBPM`.
