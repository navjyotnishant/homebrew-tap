class Dun < Formula
  desc "Local-only git trailer standard for AI-attribution provenance"
  homepage "https://github.com/navjyotnishant/whodunit"
  version "0.3.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.3.1/dun_v0.3.1_darwin_arm64.tar.gz"
      sha256 "5be2394dae8e04b4e9e3f5987dc2a007f7269971de27d79c280a3ca027a511f5"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.3.1/dun_v0.3.1_darwin_amd64.tar.gz"
      sha256 "df607a6cefa154d4722f2f7f70a4fd2ce576f87f9c92848c766415b8647d9ee0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.3.1/dun_v0.3.1_linux_arm64.tar.gz"
      sha256 "be23ec00ee3ddfefb774eaa32027f802a8643ac6664a3825ed4530c22d245f50"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.3.1/dun_v0.3.1_linux_amd64.tar.gz"
      sha256 "802772f6504bf1a586fdc0ff7a63bd4c3cc675fdc1e901b74bd30136a3a3142e"
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
