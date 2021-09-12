# Traversing Nested Maps

Terraform [used to use splat expressions](https://www.terraform.io/docs/language/expressions/splat.html#splat-expressions-with-maps) for this stuff (and I wish they still worked), but now this is all done with [`for` expressions](https://www.terraform.io/docs/language/expressions/for.html).

Using [your example code as a guide](https://github.com/RulerOf/terraform-code-examples/traversing-nested-maps/main.tf), it's pretty straightforward to select the structure of the map where the `address_space` lists are the first element down, like this:

    > local.subscriptions.MySecondSubcription.VirtualNetworks
    {
      "vNet1" = {
        "address_space" = [
          "10.20.0.0/24",
          "192.168.3.0/24",
        ]
      }
      "vNet2" = {
        "address_space" = [
          "10.30.0.0/24",
          "192.168.4.0/24",
        ]
      }
    }

Now, using the `for` expression, we can cherry pick the `address_space` into a list by iterating over that level of the map like this:

    > [ for net in local.subscriptions.MySecondSubcription.VirtualNetworks : net.address_space ]
    [
      [
        "10.20.0.0/24",
        "192.168.3.0/24",
      ],
      [
        "10.30.0.0/24",
        "192.168.4.0/24",
      ],
    ]

If the subdivided lists aren't helpful, you can [`flatten()`](https://www.terraform.io/docs/language/functions/flatten.html) the output:

    > flatten([ for net in local.subscriptions.MySecondSubcription.VirtualNetworks : net.address_space ])
    [
      "10.20.0.0/24",
      "192.168.3.0/24",
      "10.30.0.0/24",
      "192.168.4.0/24",
    ]

### Credits

Inspired by the question in [this Reddit thread](https://www.reddit.com/r/Terraform/comments/pms32s/deeply_nested_maps_help/).
