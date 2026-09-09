class Dun < Formula
  desc "Local-only git trailer standard for AI-attribution provenance"
  homepage "https://github.com/navjyotnishant/whodunit"
  version "0.6.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.1/dun_v0.6.1_darwin_arm64.tar.gz"
      sha256 "aed5e72866a3b11ac1c17407d1ab900c238414ef156cdd1fddfb94048cbe4c88"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.1/dun_v0.6.1_darwin_amd64.tar.gz"
      sha256 "683f06c96e023f72affe8d563e53d6c73d76ed91919fd5527f220f3c673d4fbd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.1/dun_v0.6.1_linux_arm64.tar.gz"
      sha256 "4a7dcbbbc15187bf3c81977867b9f24c1edd961065dd4d134955c7ba385e34a9"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.6.1/dun_v0.6.1_linux_amd64.tar.gz"
      sha256 "9331dc5fd35ea320b66515ac4d19252ac57f5aa2bced57d1875ebe1dcca1d69b"
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
