class Dun < Formula
  desc "Local-only git trailer standard for AI-attribution provenance"
  homepage "https://github.com/navjyotnishant/whodunit"
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.3.0/dun_v0.3.0_darwin_arm64.tar.gz"
      sha256 "5435ff7c3da9a1288e811cbe9a8ba3b437a081e93c57250181e9acb36456aced"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.3.0/dun_v0.3.0_darwin_amd64.tar.gz"
      sha256 "f6636fb43f93c1361ac8eef06a4807d6597bd32e5eb5f9300d88895bdeddcb92"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.3.0/dun_v0.3.0_linux_arm64.tar.gz"
      sha256 "65f132a47d0f5aac791655e4715a8201cb62682e8de3768fd23afd0d836951a7"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.3.0/dun_v0.3.0_linux_amd64.tar.gz"
      sha256 "ff31f102d813cd80001c5a8efe4254ee34720ae54b5865032f3f63c14111684c"
    end
  end

  def install
    # The archive contains a plain `dun` (NAV-101). Before v0.3.0 it held
    # the versioned filename, which is why this used to rename per
    # platform — four lines that all resolve to the same thing now, and
    # that would each fail with "no such file" against a current archive.
    bin.install "dun"
  end

  # Named here because Homebrew has no post-install hook — a formula has
  # install and test blocks and nothing that runs arbitrary code on
  # upgrade, so an upgrade cannot fix a repository's hooks on its own
  # (NAV-76, criterion 16).
  #
  # dun repairs a stale repository automatically on the next command run
  # there, so this is the belt-and-braces path for someone who would
  # rather fix all of them at once than wait to visit each.
  def caveats
    <<~EOS
      Hooks installed in a repository before this upgrade may be out of date.
      They are repaired automatically the next time you run dun there, or
      bring every instrumented repository up to date at once:

          dun repos update
    EOS
  end

  test do
    assert_match "dun", shell_output("#{bin}/dun --help")
  end
end
