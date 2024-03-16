# Database migrations with GitHub actions

## Setup

To use this repository you will need:
- A GCP account
- gcloud CLI 
- Terraform
- Docker

1. [Provision infrastructure](./cloud/README.md)
2. Test connection to database
   ```bash
   # start Cloud SQL proxy in one terminal
   ./proxy.sh
   # start psql connection in another
   ./psql.sh
   ```
3. To configure the GitHub action set the following secrets in GitHub
   1. `DATABASE_CONNECTION_NAME`
      ```bash
      terraform -chdir=cloud output connection_name
      ```
   2. `DATABASE_PASSWORD`
      ```bash
      terraform -chdir=cloud output password
      ```   
   3. `GCP_CREDENTIALS_DEPLOY`
      ```bash
      terraform -chdir=cloud output github_action_private_key
      ```
### Testing migrations locally

1. Test migrations locally using Docker compose:
   ```bash
   docker compose up
   ```

2. Tidy up containers (deleting all data)
   ```bash
   docker compose down
   ```
