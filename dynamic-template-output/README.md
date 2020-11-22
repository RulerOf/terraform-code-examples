# Dynamic Templatefile Rendering

The [`templatefile()`](https://www.terraform.io/docs/configuration/functions/templatefile.html) function is very useful, but using it as-written in the documentation samples encourages very repetitive coding practices. For example, you might be supplying instance user_data from a rendered script like this:

```hcl
resource "aws_instance" "my_server" {
  user_data = templatefile("${path.module}/files/user-data.sh.tmpl",
    {
      VAR_1 = "my first variable"
      VAR_2 = "my second variable"
    }
  )
}
```

Then, over in the actual template, you have to re-write all of the inputs you supplied to the `templatefile()` function like this:

```shell
#!/bin/bash

echo ${VAR_1}
echo ${VAR_2}
```

## DRYing Templates Out

Instead, you can use a [string template directive](https://www.terraform.io/docs/configuration/expressions.html#string-templates) in the template file, combined with a map input to the `templatefile()` function to DRY this out.

To see this in action, review [main.tf](./main.tf), and see how it passes the `ENV_VARS = {}` map into the function. The `for` directive inside of [user-data.sh.tmpl](./user-data.sh.tmpl) unwraps that map, renders each line into an `export`, and the resulting script sets all of variables in the shell.

### Discussion

Relates back to [this reddit thread](https://www.reddit.com/r/Terraform/comments/jy05en/terraform_variables_in_bash_scripting/gd0dfhv/)