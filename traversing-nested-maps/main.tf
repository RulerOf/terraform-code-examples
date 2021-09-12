locals {
  subscriptions = {
    "MyFirstSubscription" = {
      "VirtualNetworks" = {
        "vNet1" = {
          "address_space" = [
            "10.0.0.0/24",
            "192.168.0.0/24",
          ]
        }
        "vNet2" = {
          "address_space" = [
            "10.10.0.0/24",
            "192.168.1.0/24",
          ]
        }
      }
    }
    "MySecondSubcription" = {
      "VirtualNetworks" = {
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
    }
  }
}
