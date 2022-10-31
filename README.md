# Andrew's Terraform Code Examples

Documenting solutions to interesting Terraform problems.

## Requirements

Just terraform, though consider installing [asdf-vm](https://asdf-vm.com/) if you want to be sure you're using the same version I used.

# Examples

* [Dynamic Templatefile Rendering](./dynamic-template-output/README.md)
  * Keeping `templatefile()` function calls and the files themselves DRY — avoids writing variables twice, as input and output.
* [Traversing Nested Maps](traversing-nested-maps)
  * Illustrating how to navigate nested map structures to facilitate iterative resource creation.
* [Normalizing Input Files](normalize-input-file)
  * Using the external data source to pass a file through a linter before consuming it to avoid unnecessary destroy/recreate cycles.`
