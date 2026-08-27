class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.5.0/orion_v0.5.0_darwin_arm64.tar.gz"
      sha256 "10fa22819231593263787f81cad0a11f0b157ad940f3957449da02a55f629d8f"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.5.0/orion_v0.5.0_darwin_amd64.tar.gz"
      sha256 "b111ae0b06e0073dee30bab17c46dd778ebf757f099749bf09712196e56baba2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.5.0/orion_v0.5.0_linux_arm64.tar.gz"
      sha256 "a22b148f3833ff641d5cab5cdd3ec4a9b4bfde955a8fc9850a1de4d91658ca82"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.5.0/orion_v0.5.0_linux_amd64.tar.gz"
      sha256 "3d698b0c06464911605453b54e1fc433dc214e5b747a3e9613da1179ef7630af"
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
