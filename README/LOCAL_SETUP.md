## Getting Started Locally

Learn more about the project at [SocioPredict](https://github.com/YOUR_USERNAME/sociopredict)

### Platform Compatibility

Tested on Ubuntu (up to 23.10 LTS) and macOS. Windows users should use WSL2 - see [Microsoft's WSL guide](https://learn.microsoft.com/en-us/windows/wsl/install). WSL1 hasn't been tested.

### Local Installation

#### macOS Notes

- Install `gettext` via Homebrew: `brew install gettext`
- Create data directories manually:

```bash
mkdir -p data/postgres data/certbot
chown -R $(whoami):staff data
```

- Recent macOS versions may have extended attribute issues with Docker volumes. See [Apple's discussion](https://developer.apple.com/forums/thread/723397).

#### Setup Steps

1. **Get the code**: `git clone https://github.com/YOUR_USERNAME/sociopredict.git`
2. **Install Docker**: Follow [Docker's guide](https://docs.docker.com/get-docker/). WSL2 users see [Docker Desktop for WSL2](https://docs.docker.com/desktop/wsl/)
3. **Install Docker Compose**: See [compose installation](https://docs.docker.com/compose/install/). Use `docker compose` (not the deprecated `docker-compose`)
4. **Create environment file**: Make a `.env` in the project root
5. **Run installer**: `./SocioPredict install`
6. **Choose Development** mode and rebuild when prompted
7. **Start services**: `./SocioPredict up`
8. **Access the app** at `localhost`

#### Default Login

- Username: `admin`
- Password: `password`

After logging in, create a regular user account, then use that for trading. Initial balances are set in `setup.yaml` (configure before installation).

### Stopping Services

```bash
cd sociopredict
./SocioPredict down
```

Your data persists between restarts.

### Debugging

#### Database Access

```bash
docker exec -it -e PGPASSWORD=password sociopredict-postgres-container psql -U user -d sociopredict_db
```

#### Reset Database

```bash
./SocioPredict down
rm -rf ./data/postgres/*
./SocioPredict up
```

#### Container Logs

```bash
docker compose -p scripts logs | grep backend
docker compose -p scripts logs | grep frontend
docker compose -p scripts logs | grep nginx
docker compose -p scripts logs | grep postgres
```

### Database Backup

#### Create Backup

```bash
docker exec sociopredict-postgres-container sh -c 'pg_dump -U user -F c sociopredict_db' > backup.dump 2> error.log
```

#### Restore Backup

```bash
docker exec -it sociopredict-postgres-container psql -U user -c "DROP DATABASE sociopredict_db;"
docker exec -it sociopredict-postgres-container psql -U user -c "CREATE DATABASE sociopredict_db;"
cat backup.dump | docker exec -i sociopredict-postgres-container pg_restore --no-owner -U user -d sociopredict_db
```

### Web Deployment

See [Deployment Guide](/README/STAGE_SETUP.md) for production setup instructions.
