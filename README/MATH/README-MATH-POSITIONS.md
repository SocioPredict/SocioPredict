## Position Types in the Codebase

Two position types exist to separate core math from presentation logic:

### DBPMMarketPosition

**Purpose**: Internal calculations

**Used for**: Core pipeline output, payout resolution

**Fields**: Username, YesSharesOwned, NoSharesOwned

### MarketPosition

**Purpose**: API responses

**Used for**: Frontend display, enriched data

**Fields**: All DBPMMarketPosition fields plus calculated Value for display

### Data Flow

```
Raw Bets/Market
    ↓
Core Math Functions (Aggregate, Normalize)
    ↓
[]DBPMMarketPosition (internal output)
    ↓
[]MarketPosition (enriched with Value)
    ↓
API Response
```

Keeping these separate lets the core math stay pure and testable while the API layer handles presentation concerns.
