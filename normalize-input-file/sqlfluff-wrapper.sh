#!/bin/bash -e

# Extract arguments from the input into shell variables.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "SQL=\(.sql) DIALECT=\(.dialect)"')"

# Placeholder for whatever data-fetching logic your script implements
FORMATTED_SQL="$(echo $SQL | sqlfluff fix - --dialect $DIALECT)"

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg formatted_sql "$FORMATTED_SQL" '{"formatted_sql":$formatted_sql}'