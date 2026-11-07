class Dun < Formula
  desc "Local-only git trailer standard for AI-attribution provenance"
  homepage "https://github.com/navjyotnishant/whodunit"
  version "0.8.1"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.8.1/dun_v0.8.1_darwin_arm64.tar.gz"
      sha256 "cb3857ad92e37da61ba74b861da1f0696b4ec62095a74ce5692c5b64ca49a227"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.8.1/dun_v0.8.1_darwin_amd64.tar.gz"
      sha256 "09b240ae9258eaf0f43dae8916bd4acc2634daf0efcbac6923027080be03c0cb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.8.1/dun_v0.8.1_linux_arm64.tar.gz"
      sha256 "832a7ee61afcb4f6479280c8b40c4d892918efa691b798d9962cf79c6b3c4ba5"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.8.1/dun_v0.8.1_linux_amd64.tar.gz"
      sha256 "b3e21ef0b519659fb2ae819150e5d51baafd499704b3073337aa08eb98085488"
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
