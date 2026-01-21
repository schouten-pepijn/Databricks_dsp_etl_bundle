#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
ENV_FILE="${ROOT_DIR}/.env"
DEV_DIR="${ROOT_DIR}/infra/terraform/environments/dev"

if [[ ! -f "${ENV_FILE}" ]]; then
  echo "Missing .env file at ${ENV_FILE}. Copy .env.example and fill values." >&2
  exit 1
fi

# shellcheck disable=SC1090
source "${ENV_FILE}"

if [[ -z "${DATABRICKS_HOST:-}" || -z "${DATABRICKS_TOKEN:-}" ]]; then
  echo "DATABRICKS_HOST or DATABRICKS_TOKEN not set in .env" >&2
  exit 1
fi

# Map to Terraform variable environment names
export TF_VAR_databricks_host="${DATABRICKS_HOST}"
export TF_VAR_databricks_token="${DATABRICKS_TOKEN}"

pushd "${DEV_DIR}" >/dev/null
terraform init -input=false

if [[ "${1:-}" == "apply" ]]; then
  terraform apply -auto-approve
else
  terraform plan
fi
popd >/dev/null
