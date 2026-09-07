class Dun < Formula
  desc "Local-only git trailer standard for AI-attribution provenance"
  homepage "https://github.com/navjyotnishant/whodunit"
  version "0.6.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.0/dun_v0.6.0_darwin_arm64.tar.gz"
      sha256 "408b513d3e9e862268b8f1adc88a6c8eaeaaa6fa1b1ed4e29f066755d9a125f0"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.0/dun_v0.6.0_darwin_amd64.tar.gz"
      sha256 "4dd7462f908ea2956af7245edef87190d16872b7e132f39eacac25301bf01eb6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.0/dun_v0.6.0_linux_arm64.tar.gz"
      sha256 "835f8b80d1415af78681a5d36a3d86e081fe9ec2119281b8e080d15caeb68992"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.0/dun_v0.6.0_linux_amd64.tar.gz"
      sha256 "15c41a5710a91e5e5b649e082c687a797929f1903341ba17357671713d448543"
    end
  end

  def install
    # The archive contains a plain `dun` (NAV-101). Before v0.3.0 it held
    # the versioned filename, which is why this used to rename per
    # platform - four lines that all resolve to the same thing now, and
    # that would each fail with "no such file" against a current archive.
    bin.install "dun"
  end

  # Hooks carry the version that wrote them, so a change to the hook
  # script's own shape does not reach a repository just because the binary
  # was upgraded (NAV-76). dun repairs a repository on the next command run
  # there, but a repository nobody visits stays stale indefinitely - and
  # stale hooks attribute less while looking like they are working.
  #
  # An earlier version of this formula claimed Homebrew has no post-install
  # hook. It does: post_install runs on install and on upgrade.
  #
  # The failure is swallowed deliberately. A repository that has moved, or
  # whose hooks directory is not writable, must not fail the upgrade -
  # ending up with stale hooks is a far better outcome than ending up with
  # no new binary. `dun repos update` prints what it did either way.
  def post_install
    system bin/"dun", "repos", "update"
  rescue StandardError
    opoo "could not refresh git hooks; run `dun repos update` when convenient"
  end

  test do
    assert_match "dun", shell_output("#{bin}/dun --help")
  end
end
