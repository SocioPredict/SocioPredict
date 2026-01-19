## Logging Guide

The custom logger in `backend/logger/simplelogging.go` provides consistent INFO, WARN, and ERROR output including source file and line numbers.

### Output Format

```
YYYY/MM/DD HH:MM:SS LEVEL file.go:line - Context - Function: Message
```

### Viewing Logs (Docker)

```bash
docker logs -f sociopredict-backend-container
```

### Usage

```go
import "sociopredict/logger"

logger.LogInfo("ChangePassword", "ChangePassword", "Handler called")
logger.LogWarn("ChangePassword", "ValidateInput", "Weak password attempt")
logger.LogError("ChangePassword", "UpdateDatabase", err)
```

### Message Format

`Context - Function: Message`

- **Context**: Feature area (ChangePassword, BuyPosition, ResolveMarket)
- **Function**: Specific operation (DecodeRequest, ValidateInput, UpdateDB)
- **Message**: Brief, clear description

### Security

Never log passwords, tokens, or full request bodies.

### Example Output

```
2025/10/06 11:36:13 INFO changepassword.go:25 - ChangePassword - ChangePassword: Handler called
2025/10/06 11:36:13 ERROR changepassword.go:54 - ChangePassword - ValidateInput: New password required
```
