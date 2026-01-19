# SocioPredict Market Seeding Tools

Utilities for populating your SocioPredict instance with sample prediction markets.

## What's Included

- `example_markets.sql` - Ten ready-to-use market definitions
- `populate_markets.sh` - Shell script for database population
- `seed_markets.go` - Go-based seeding program

## Sample Markets Cover

1. Tech predictions (AI releases)
2. Sports outcomes
3. Political forecasts
4. Cryptocurrency prices
5. Entertainment news
6. Scientific breakthroughs
7. Climate events
8. Space exploration
9. Stock performance
10. Gaming releases

## How to Use

### Shell Script (Easiest)

```bash
cd /path/to/sociopredict
./scripts/populate_markets.sh

# Just check connection
./scripts/populate_markets.sh --check-only
```

### Go Program

```bash
cd /path/to/sociopredict
./scripts/seed_markets_go.sh
```

### Direct SQL

```bash
psql -h localhost -U user -d devdb -f scripts/example_markets.sql
```

## Before You Start

1. Database must be running
2. Tables must exist (run the main app first)
3. Admin user must be created
4. Environment configured via `.env`

### Environment Setup

Copy `.env.example` to `.env` and fill in:

```bash
DB_HOST=localhost
DB_PORT=5432
POSTGRES_USER=user
POSTGRES_PASSWORD=yourpassword
POSTGRES_DATABASE=devdb
ADMIN_PASSWORD=youradminpassword
```

## Troubleshooting

- **Can't connect?** Check if Postgres is running and credentials are correct
- **Missing tables?** Start the main application to run migrations
- **No admin user?** Launch the app with ADMIN_PASSWORD set
- **Permission denied?** Run `chmod +x populate_markets.sh`

Run `./scripts/populate_markets.sh --help` for more options.
