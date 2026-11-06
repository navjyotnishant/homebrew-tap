class Dun < Formula
  desc "Local-only git trailer standard for AI-attribution provenance"
  homepage "https://github.com/navjyotnishant/whodunit"
  version "0.8.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.8.0/dun_v0.8.0_darwin_arm64.tar.gz"
      sha256 "056ae5d704d92b91a67f74d33d3c5f46628388fdda9de196d4747a10d398a571"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.8.0/dun_v0.8.0_darwin_amd64.tar.gz"
      sha256 "b556a3b562bb84a6bd419956e00b4c720e52c6d1a9e2636638df082655f06020"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.8.0/dun_v0.8.0_linux_arm64.tar.gz"
      sha256 "11f952c27e01667113a174c022c685e6ce6604eebfb31b9e6e9bc47093f372dd"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.8.0/dun_v0.8.0_linux_amd64.tar.gz"
      sha256 "e97bb9dcbf683e2f193ee09d8facb3cdf708ee69d7bff9afdadb83fd1b138e30"
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
