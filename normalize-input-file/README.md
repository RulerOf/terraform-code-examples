# Formatting SQL in Terraform

[This question](https://www.reddit.com/r/Terraform/comments/xvm6xc/terraform_pre_commit_hooks/) came up on reddit where a user wanted to use git commit hooks to format SQL code that terraform was consuming so that it would be consistent regardless of whitespace changes. My opinion was that the SQL code should be normalized by Terraform, not by git hooks, so I created this repo to illustrate the idea.

----

[unformatted.sql](unformatted.sql) shows a SQL query with terrible formatting, making it nearly unreadable.

```sql
SELECT  country.country_name_eng, SUM(CASE WHEN call.id IS NOT NULL THEN 1 ELSE 0 END) AS calls, AVG(ISNULL(DATEDIFF(SECOND, call.start_time, call.end_time),0)) AS avg_difference FROM country  LEFT JOIN city ON city.country_id = country.id LEFT JOIN customer ON city.id = customer.city_id LEFT JOIN call ON call.customer_id = customer.id GROUP BY  country.id, country.country_name_eng HAVING AVG(ISNULL(DATEDIFF(SECOND, call.start_time, call.end_time),0)) > (SELECT AVG(DATEDIFF(SECOND, call.start_time, call.end_time)) FROM call) ORDER BY calls DESC, country.id ASC;
```

Using the [external_data data source](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/data_source) in Terraform, and a [small wrapper script](sqlfluff-wrapper.sh), we pipe the data to jq -> shell -> [SQLFluff](https://github.com/sqlfluff/sqlfluff) to make it readable, as shown here:

```
╭─ ~/Projects/personal/terraform/sqlformat main ?
╰─❯ terraform apply

Changes to Outputs:
  + formatted_sql = <<-EOT
        SELECT
            country.country_name_eng,
            SUM(CASE WHEN call.id IS NOT NULL THEN 1 ELSE 0 END) AS calls,
            AVG(
                ISNULL(DATEDIFF(second, call.start_time, call.end_time), 0)
            ) AS avg_difference
        FROM
            country
        LEFT JOIN
            city ON city.country_id = country.id
        LEFT JOIN
            customer ON city.id = customer.city_id
        LEFT JOIN
            call ON call.customer_id = customer.id
        GROUP BY
            country.id, country.country_name_eng
        HAVING
            AVG(
                ISNULL(DATEDIFF(second, call.start_time, call.end_time), 0)
            ) > (SELECT AVG(DATEDIFF(second, call.start_time, call.end_time)) FROM call)
        ORDER BY calls DESC, country.id ASC;
    EOT
```

# Requires

* jq
* sqlfluff
* bash shell
