output "rendered" {
  value = templatefile("${path.module}/user-data.sh.tmpl",
  {
    ENV_VARS = {
      var1 = "test1"
      var2 = "test2"
    }
  })
}