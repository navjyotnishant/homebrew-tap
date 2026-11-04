class Dun < Formula
  desc "Local-only git trailer standard for AI-attribution provenance"
  homepage "https://github.com/navjyotnishant/whodunit"
  version "0.7.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.7.0/dun_v0.7.0_darwin_arm64.tar.gz"
      sha256 "0f5d028d81cf8246463ade4cfb4a3bca6fa917e99c49c6e0770c4da2d0e88e40"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.7.0/dun_v0.7.0_darwin_amd64.tar.gz"
      sha256 "f0f9d700e40c75a0ee00118cf868dba619f7181f08c0d10adee8b605a3c458ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.7.0/dun_v0.7.0_linux_arm64.tar.gz"
      sha256 "ddc35ef7e9d10a63d2ca0b44824c2b6899cbfe2d9b0157c24d46591fd99ddc11"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.7.0/dun_v0.7.0_linux_amd64.tar.gz"
      sha256 "bb3ac20b3b66df05b23e1f995d8ab3bf63ef420013ea8e2b649a52ba7ff0d25b"
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
