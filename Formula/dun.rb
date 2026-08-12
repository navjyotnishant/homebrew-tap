class Dun < Formula
  desc "Local-only git trailer standard for AI-attribution provenance"
  homepage "https://github.com/navjyotnishant/whodunit"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.1.0/dun_v0.1.0_darwin_arm64.tar.gz"
      sha256 "3a3d143bb3e42ece2481437019948ea628d529d1f70ec3f077de348ffeb13939"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.1.0/dun_v0.1.0_darwin_amd64.tar.gz"
      sha256 "37e1786bc6b2a19d7a3421f1e1b0d67606d0e5777bc6b3ae9d9efb1e07ded0db"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.1.0/dun_v0.1.0_linux_arm64.tar.gz"
      sha256 "e79a8a6b18e47209bc5eb966e0d20b16ce25865b75769335406f975cefccec92"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.1.0/dun_v0.1.0_linux_amd64.tar.gz"
      sha256 "82724ff2e52e8d074c90a5bf1521826ea53d130beeccd4c840a6f070b1eac1b3"
    end
  end

  def install
    bin.install "dun_v0.1.0_darwin_arm64" => "dun" if OS.mac? && Hardware::CPU.arm?
    bin.install "dun_v0.1.0_darwin_amd64" => "dun" if OS.mac? && Hardware::CPU.intel?
    bin.install "dun_v0.1.0_linux_arm64" => "dun" if OS.linux? && Hardware::CPU.arm?
    bin.install "dun_v0.1.0_linux_amd64" => "dun" if OS.linux? && Hardware::CPU.intel?
  end

  test do
    assert_match "dun", shell_output("#{bin}/dun --help")
  end
end
