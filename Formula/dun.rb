class Dun < Formula
  desc "Local-only git trailer standard for AI-attribution provenance"
  homepage "https://github.com/navjyotnishant/whodunit"
  version "0.6.2"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.2/dun_v0.6.2_darwin_arm64.tar.gz"
      sha256 "eba36ad2386edbb6e770810f4937379727cab685ab323b785a9ccc8ecadde6ac"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.2/dun_v0.6.2_darwin_amd64.tar.gz"
      sha256 "c8eddc13948cbcd21a55ad27433df61c1ff20dbcc7b4c03aa99d5b32d916e2c9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.2/dun_v0.6.2_linux_arm64.tar.gz"
      sha256 "a6e79b6b74daae00411a5a8dc5f8ac8111dc0dd1234ff3fe24054fdf3d3d102b"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.2/dun_v0.6.2_linux_amd64.tar.gz"
      sha256 "4fa863891a1fbe87ab929c850c674a1d1064312de32de7d1651722071010217d"
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
