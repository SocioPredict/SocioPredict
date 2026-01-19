# DevOps & Automation Guide

How SocioPredict handles continuous integration, testing, and deployment through GitHub Actions.

---

## Pipeline Overview

The backend uses GitHub Actions for automated testing and quality checks on every pull request.

### Design Goals

- **Repeatability**: Every PR goes through identical validation
- **Safety**: Merges blocked until checks pass
- **Flexibility**: Support multiple Go versions without manual updates
- **Stability**: Consistent job names that don't break branch protection

---

## Pipeline Structure

Defined in **`.github/workflows/backend.yml`**:

### Job 1: `prepare-matrix`

Dynamically builds the Go version test matrix by reading `.github/go-versions` or falling back to `backend/go.mod`.

### Job 2: `smoke`

Quick sanity check - verifies the backend compiles and starts. Catches obvious issues early before running the full suite.

### Job 3: `unit_matrix`

Runs the complete test suite for each Go version defined by the matrix. Uses:
- `actions/setup-go@v5`
- Dependency caching
- Parallel execution

### Job 4: `unit`

Aggregator job that produces a single pass/fail status for branch protection, regardless of how many Go versions were tested.

---

## Version Matrix System

Test against any Go versions by editing `.github/go-versions`:

```
# Test current module version only
file:backend/go.mod

# Test specific versions
1.25.x
1.26.x

# Or both
file:backend/go.mod
1.25.x
1.26.x
```

No workflow YAML edits or branch protection changes needed.

---

## Branch Protection

Configure required checks in **Settings → Branches → main**:

1. Add `Backend / unit (pull_request)` as required
2. Remove any version-specific checks like `unit (1.23.x)`
3. Save

The `unit` aggregator provides a stable check name that survives Go version bumps.

---

## Advantages

- **No broken protection rules** when Go versions change
- **Easy version management** via a single file
- **Cached builds** for faster CI runs
- **Single status** for reviewers instead of multiple scattered results
- **Extensible** - same pattern works for lint, security scans, etc.

---

## Key Files

| File | Purpose |
|------|---------|
| `.github/workflows/backend.yml` | CI pipeline definition |
| `.github/go-versions` | Go versions to test |
| `backend/go.mod` | Default Go version fallback |

---

## Future Plans

- Apply dynamic matrix to smoke tests
- Add linting and build verification stages
- Container image builds and deployments
- Frontend workflow integration
