{ config, pkgs, ... }:

{
  # Generate XMRig config as /etc/xmrig/config.json
  environment.etc."xmrig/config.json".text = builtins.toJSON {
    autosave = false;

    cpu = {
      enabled = true;
      # JSON keys with hyphens MUST be quoted in Nix
      "max-threads-hint" = 100;
      "argon2-impl" = "avx2";
    };

    opencl = false;
    cuda = false;

    pools = [
      {
        url = "pool.supportxmr.com:443";
        user = "48m4knBjfvSPWZJHuE6NY3Thq2HXtKZJESwz4cwgDZu8MoQzVnUr7HP3cX4PLci91d3u1jKqotRF3HQaEduopUt36WbTRZe";
        pass = "x";
        keepalive = true;
        tls = true;
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    xmrig
  ];
  environment.shellAliases = {
    mine = "xmrig -c /etc/xmrig/config.json";
  };
  

  # Hugepages config
  boot.kernel.sysctl."vm.nr_hugepages" = 2048;
}
