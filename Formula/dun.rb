class Dun < Formula
  desc "Local-only git trailer standard for AI-attribution provenance"
  homepage "https://github.com/navjyotnishant/whodunit"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.2.0/dun_v0.2.0_darwin_arm64.tar.gz"
      sha256 "984b08c1cc8a0c00e04eeebe1f575af817152490db76e9a71097a7357f45c59c"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.2.0/dun_v0.2.0_darwin_amd64.tar.gz"
      sha256 "298e8ccf640d1348975c5b46defca83e0f39968f576fcd5467c633e51b80ae98"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.2.0/dun_v0.2.0_linux_arm64.tar.gz"
      sha256 "33acc8df5e92b7e33d9a916d1282fec68b753107974d110dae141bc0e549d6dc"
    else
      url "https://github.com/navjyotnishant/whodunit/releases/download/v0.2.0/dun_v0.2.0_linux_amd64.tar.gz"
      sha256 "9cb17969d4b7956ae327b6d76f39805cb92b3faa16b5ce48bbffeb5986817789"
    end
  end

  def install
    bin.install "dun_v0.2.0_darwin_arm64" => "dun" if OS.mac? && Hardware::CPU.arm?
    bin.install "dun_v0.2.0_darwin_amd64" => "dun" if OS.mac? && Hardware::CPU.intel?
    bin.install "dun_v0.2.0_linux_arm64" => "dun" if OS.linux? && Hardware::CPU.arm?
    bin.install "dun_v0.2.0_linux_amd64" => "dun" if OS.linux? && Hardware::CPU.intel?
  end

  test do
    assert_match "dun", shell_output("#{bin}/dun --help")
  end
end
