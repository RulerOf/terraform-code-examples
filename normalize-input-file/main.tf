data "external" "format_sql" {
  program = ["bash", "sqlfluff-wrapper.sh"]
  query = {
    sql     = file("unformatted.sql")
    dialect = "ansi"
  }
}

output "formatted_sql" {
  value = data.external.format_sql.result.formatted_sql
}
