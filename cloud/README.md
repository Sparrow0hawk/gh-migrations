# Cloud setup

1. Setup a project using the [`create-project.sh`](./create-project.sh). This requires you to pass 
    in a billing account which you can identity with the following command:
    ```bash
    gcloud billing accounts list
    ./create-project.sh XXX-XXX-XXX-XXX
    ```
2. Plan terraform
   ```bash
   terraform plan
   ```
3. Apply terraform
   ```bash
   terraform apply
   ```
