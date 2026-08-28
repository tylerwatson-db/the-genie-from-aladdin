# Nimbus Growth Desk

Conversion slide detection and feature-ship decision app for Nimbus marketplace.

## Architecture

- **Data layer**: Unity Catalog tables synced into Lakebase (read-only)
- **App state**: Writable Postgres tables in Lakebase (feature decisions, conversations)
- **Assistant**: AI-powered explanation, what-if ranking, and memo drafting
- **Writeback**: Human-approved feature decisions with audit trail

## Lakebase Project

- Project: `nimbus-growth`
- Production branch: `production`
- Dev branch: `featureship-dev`
- Database: `nimbus_app`
- Schema: `app`
