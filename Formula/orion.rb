class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.0/orion_v0.7.0_darwin_arm64.tar.gz"
      sha256 "b11006401ca175a761824e37193c0451b5373627585176db790a319c7ee55210"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.0/orion_v0.7.0_darwin_amd64.tar.gz"
      sha256 "faff635c6f99996e4c7ca3a67a7130e8885ed68e467364782618f52e486e5456"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.0/orion_v0.7.0_linux_arm64.tar.gz"
      sha256 "87c9145f0544e76101bed0cc0c8e5694537ef7691817b7e0f8514c4c6ff77b9e"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.0/orion_v0.7.0_linux_amd64.tar.gz"
      sha256 "26e2cc6454d1f0519bfd5a6c2f60ee99d2425cef4c9f50f3f91a09f185e0bb5f"
    end
  end

  def install
    # The archive holds a plain `orion`. Keep it that way: a versioned
    # filename inside the archive makes this line fail with "no such file"
    # on every upgrade, which is the bug the whodunit formula carries a
    # comment about.
    bin.install "orion"
  end

  # Homebrew has no post-install hook, so a formula cannot fetch Orion's
  # runtime dependency on its own. Named here because Orion is useless
  # without nj-agents: review, secret scanning, test verification, PR
  # authoring and PM decomposition are all delegated to it and have no
  # fallback.
  def caveats
    <<~CAVEATS
      Orion delegates review, security, testing and PR authoring to nj-agents,
      which is a hard dependency with no fallback. Check and fetch it with:

          orion doctor --fix

      nj-agents ships independently of Orion, so pull its improvements with:

          orion njagents update
    CAVEATS
  end

  test do
    assert_match "orion", shell_output("#{bin}/orion version")
  end
end
