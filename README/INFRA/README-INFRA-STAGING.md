# Staging Deployment

How SocioPredict automatically deploys to staging environments.

---

## How It Works

Staging deployment uses GitHub Actions combined with Ansible:

- **Playbook Repository**: [YOUR_USERNAME/ansible_playbooks](https://github.com/YOUR_USERNAME/ansible_playbooks/tree/main)
- **Trigger**: Merging a PR into `main`

---

## Deployment Flow

1. PR merged to `sociopredict@main`
2. `.github/workflows/deploy-to-staging.yml` fires
3. Sends `deploy-to-staging` event to ansible_playbooks repo
4. Ansible workflow:
   - Stops running containers
   - Removes old images
   - Pulls latest code
   - Builds new images
   - Starts fresh containers

---

## For Developers

- **No SSH required** - just merge to main
- **Manual deploys available** via ansible_playbooks Actions tab

---

## Environment Variables

Key settings from `.env.example`:

| Variable | Purpose |
|----------|--------|
| `BACKEND_IMAGE_NAME` | Backend Docker image name |
| `FRONTEND_IMAGE_NAME` | Frontend Docker image name |
| `BACKEND_CONTAINER_NAME` | Backend container name |
| `FRONTEND_CONTAINER_NAME` | Frontend container name |
| `DOMAIN_URL` | Staging domain |
| `ADMIN_PASSWORD` | Admin credentials (persists across deploys) |

---

## Workflow Configuration

```yaml
name: Deploy To Staging
on:
  pull_request:
    branches: [main]
    types: [closed]

jobs:
  deploy:
    name: Deploy SocioPredict to Staging
    if: github.event.pull_request.merged == true
    uses: YOUR_USERNAME/ansible_playbooks/.github/workflows/deploy_staging.yml@main
```

Only triggers on merged PRs, keeping the pipeline clean.

---

## Manual Deployment

1. Go to ansible_playbooks repository
2. Open Actions tab
3. Select deploy_staging workflow
4. Click Run workflow

---

## Summary

✅ Merge to main = automatic staging deployment  
✅ Ansible handles container lifecycle  
✅ Persistent configuration across deploys  
✅ Manual trigger available when needed
