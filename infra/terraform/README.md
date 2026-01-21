# Terraform beheer in deze repo

Deze repo gebruikt Terraform voor platform- en data governance lagen. Databricks Bundles blijven verantwoordelijk voor pipelines, jobs en deployment.

## Wat Terraform beheert
- Unity Catalog: catalogs, schemas en managed volumes (data + checkpoints)
- Secrets: secret scopes en secrets (tokens/keys) voor gebruik door jobs/pipelines
- Identiteiten: gebruikers, groepen en service principals (via SCIM), inclusief rechten op UC-objecten
- Toegangsbeheer: grants op catalog, schema, tables/volumes

## Wat níet door Terraform wordt beheerd
- Pipelines, jobs, notebooks en code-artifacts — deze worden beheerd via Databricks Bundles in `pipelines/bundle/...`
- Wil je pipelines/jobs toch via Terraform beheren, verwijder ze dan uit de bundle YAML om drift te voorkomen.

## Structuur
- `infra/terraform/modules`: herbruikbare modules (bijv. `unity_catalog`)
- `infra/terraform/environments/dev|prod`: per-omgeving providers, variabelen en backend/state

## Outputs voor Bundles
- UC-waarden (catalog, schema) en volume-paden (bijv. `/Volumes/<catalog>/<schema>/<volume>`) die als omgevingsvariabelen in bundle YAML gebruikt worden.

## Workflow (kort)
1. Voer Terraform `init/plan/apply` uit in de gewenste omgeving.
2. Lees Terraform outputs (JSON) en zet overeenkomstige env vars.
3. Deploy de Databricks Bundle met die waarden (`databricks bundle deploy --target <env>`).

## Richtlijnen
- Eén bron van waarheid per resource (TF of Bundles) om drift te vermijden.
- Parametriseer namen/policies per omgeving (dev/prod).
- Centraliseer grants/ACLs in Terraform (`databricks_grants`).
