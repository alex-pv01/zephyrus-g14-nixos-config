{ ... }:

{
  # Compressed swap in RAM. With 15 GiB total and zstd averaging ~3x, 50%
  # of RAM as zram buys roughly 20 GiB of effective capacity without ever
  # touching the nvme. Gets priority 5, so the kernel fills it before
  # falling back to the on-disk swap partition (priority -1).
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  boot.kernel.sysctl = {
    # Swapping to RAM is cheap, so bias heavily towards it. The usual
    # "lower swappiness is better" advice assumes swap means disk.
    "vm.swappiness" = 180;

    # zram is random-access; reading adjacent pages on fault is wasted work.
    "vm.page-cluster" = 0;

    # Reclaim earlier and more smoothly, so allocation stalls are less likely
    # under the memory pressure this machine actually sees.
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
  };
}
