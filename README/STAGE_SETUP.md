## Deploying SocioPredict

This guide walks through deploying [SocioPredict](https://github.com/YOUR_USERNAME/sociopredict) on a cloud server. We use Digital Ocean as an example, but similar VPS providers work too.

### Get a Domain

Purchase a domain from any registrar like [Namecheap](https://www.namecheap.com/).

### Server Setup

SocioPredict runs efficiently on modest hardware. Set up a [Digital Ocean](https://www.digitalocean.com/) Droplet with Docker using their [one-click installer](https://marketplace.digitalocean.com/apps/docker) or follow the [detailed tutorial](https://www.digitalocean.com/community/tutorials/how-to-use-the-docker-1-click-install-on-digitalocean).

### SSH Access

Generate a dedicated key:

```bash
ssh-keygen
# Name it id_ed25519-do
```

Connect:

```bash
ssh -i ~/.ssh/id_ed25519-do root@YOUR_IP_ADDRESS
```

#### Key Recovery

If you lose access, use Digital Ocean's console to add your new public key to `~/.ssh/authorized_keys`.

### Initial Server Setup

```bash
sudo apt update && sudo apt upgrade
sudo reboot
```

### Verify Docker

```bash
sudo systemctl status docker
sudo docker run hello-world
docker version
docker compose version
```

### DNS Configuration

1. Point your domain to Digital Ocean's nameservers
2. Add the domain in [Digital Ocean's networking panel](https://cloud.digitalocean.com/networking/domains)
3. Create A records for both `@` and `www` pointing to your Droplet
4. Wait up to 48 hours for propagation

Check status at https://www.whatsmydns.net/ or using `dig yourdomain.com`

### Firewall

Allow ports 80 (HTTP) and 443 (HTTPS) through your firewall.

### Install SocioPredict

```bash
cd /home
git clone https://github.com/YOUR_USERNAME/sociopredict.git
cd sociopredict
./SocioPredict install
```

Choose option `2` for production mode and follow the prompts for:
- Domain name
- SSL certificate email
- Database credentials
- Admin password

Then launch:

```bash
./SocioPredict up
```

### First Login

Sign in as admin, create a regular user account (admins can't trade), then use that account to create markets.

Default economics: 0 starting credits, 500 credit debt limit. Adjust in `setup.yaml` before installation.

### Server Management

#### View Logs

```bash
docker compose -p scripts logs | grep backend
```

#### Database Console

```bash
docker exec -it -e PGPASSWORD=${POSTGRES_PASSWORD} sociopredict-postgres-container psql -U ${POSTGRES_USER} -d sociopredict_db
```

### Home Server Alternative

You can also self-host on a home Linux server:

1. Set up Docker and Docker Compose on Ubuntu or similar
2. Get a domain (free options available at https://desec.io/)
3. Configure port forwarding for 80 and 443 to your server
4. Follow the standard installation steps

Port 80 is only needed during SSL certificate generation.
