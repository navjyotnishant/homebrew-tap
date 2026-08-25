class Dun < Formula
  desc "Local-only git trailer standard for AI-attribution provenance"
  homepage "https://github.com/navjyotnishant/whodunit"
  version "0.4.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.4.0/dun_v0.4.0_darwin_arm64.tar.gz"
      sha256 "aed5eb54742a94d241af7de0c0181e94296d84db71b0a50ee4fa59947dfd531a"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.4.0/dun_v0.4.0_darwin_amd64.tar.gz"
      sha256 "a9700f98eeb6eda986d7cea7ded337691a552e7080ee070110bfdb655fb0ca27"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.4.0/dun_v0.4.0_linux_arm64.tar.gz"
      sha256 "1234f4a0f97b0d14b8d3d18741421b971422af665e2c7dcb237b05325beff128"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.4.0/dun_v0.4.0_linux_amd64.tar.gz"
      sha256 "da32ff14fc40562aa7b1ca63944a25c4bb58809b1bc1dec4b67d216a0a019f69"
    end
  end

  def install
    # The archive contains a plain `dun` (NAV-101). Before v0.3.0 it held
    # the versioned filename, which is why this used to rename per
    # platform - four lines that all resolve to the same thing now, and
    # that would each fail with "no such file" against a current archive.
    bin.install "dun"
  end

  # Named here because Homebrew has no post-install hook - a formula has
  # install and test blocks and nothing that runs arbitrary code on
  # upgrade, so an upgrade cannot fix a repository's hooks on its own
  # (NAV-76, criterion 16).
  #
  # dun repairs a stale repository automatically on the next command run
  # there, so this is the belt-and-braces path for someone who would
  # rather fix all of them at once than wait to visit each.
  def caveats
    <<~CAVEATS
      Hooks installed in a repository before this upgrade may be out of date.
      They are repaired automatically the next time you run dun there, or
      bring every instrumented repository up to date at once:

          dun repos update
    CAVEATS
  end

  test do
    assert_match "dun", shell_output("#{bin}/dun --help")
  end
end
