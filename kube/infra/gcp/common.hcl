locals {

  # Load DB Mappings for cloud and PGMAN 
  db_mapping = { 
    "analysis" = "analysis"
    "keycloak" = "general"
    "ingest"   = "general"
    "core"     = "general"
    "backup"   = "backup"
  }

  # This is so the Backups API knows what to backup
  db_mapping_backups = {
    "analysis" = "analysis"
    "keycloak" = "general"
    "ingest"   = "general"
    "core"     = "general"
  }
}
