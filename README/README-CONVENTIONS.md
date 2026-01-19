# Development Standards

Coding guidelines that keep SocioPredict maintainable and secure.

Conventions are documented throughout the codebase with unique IDs. Search for "Convention" to find them all.

## Architecture

The codebase separates backend and frontend to enable focused contributions:

- **Backend**: Go - chosen for performance and wide adoption
- **Frontend**: React - chosen for ecosystem maturity

## Backend Guidelines

### Follow Go Standards First

Adhere to official Go conventions. When in doubt, refer to Go documentation.

### Stateless Design

Minimize state. Bets record to a ledger; derived values calculate fresh each time. Balances may cache but should verify against recalculation.

### Integer Transactions

All financial operations start as integers. Fractional amounts appear only through documented mathematical transformations.

### Public vs Private Data

Use specific structs for API responses to prevent accidental data leaks:

```go
type PublicUserType struct {
    Username              string  `json:"username"`
    DisplayName           string  `json:"displayname"`
    UserType              string  `json:"usertype"`
    AccountBalance        float64 `json:"accountBalance"`
    // ... only fields safe for public consumption
}
```

Never return raw database models in API responses.

### Server-Side Time Validation

Never trust client-side time for business rules. Users can manipulate browser time, so all time-based validation happens server-side.

### Handler Definition

A "handler" specifically means an HTTP request handler per Go's `net/http` package. Reserve the term for API endpoints, not general functions.

### Connection Pooling

Establish database connections once and pass them down:

```go
db := util.GetDB()
// Pass db to subsequent functions
```

Avoid calling `GetDB()` repeatedly in nested functions.

### Higher-Order Functions

Use them when:
- Injecting dependencies into handlers
- Creating reusable, configurable behavior
- Improving testability
- Separating configuration from execution

Avoid when they add complexity without benefit.

### 32-Bit Compatibility (CONV-32BIT-001)

When converting uint64 to uint, validate the value fits:

```go
if valueUint64 > uint64(^uint(0)) {
    return errors.New("value exceeds platform limits")
}
valueUint := uint(valueUint64)
```

This prevents overflow on 32-bit systems and addresses security scanner warnings.
