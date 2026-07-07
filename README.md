# DevOps Assessment Setup
## How to run Database tasks
1. Start database: `docker compose up -d`
2. Run backup: `bash scripts/backup.sh`
3. Run restore: `bash scripts/restore.sh`
## How to validate Terraform
1. `cd envs/dev/`
2. `terraform init`
3. `terraform validate`
