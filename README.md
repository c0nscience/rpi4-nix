```shell
curl -L "http://tinyurl.com/rpi4-nix-cfg" > /etc/nixos/configuration.nix && \ 
curl -L "http://tinyurl.com/rpi4-nix-hw-cfg" > /etc/nixos/hardware-configuration.nix && \ 
curl -L "http://tinyurl.com/rpi4-nix-flake" > /etc/nixos/flake.nix && \ 
curl -L "https://github.com/c0nscience.keys" > /etc/nixos/ssh/authorized_keys
```
