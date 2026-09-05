class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.9.0/orion_v0.9.0_darwin_arm64.tar.gz"
      sha256 "849614c28e3718d4709f6a88eb08cefbd587dcbf3ade91be4e25bdfabbb059c0"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.9.0/orion_v0.9.0_darwin_amd64.tar.gz"
      sha256 "88f97ad1d3b051535548950610984f4e75d286e3c48eef9da2e5c5a137621a8a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.9.0/orion_v0.9.0_linux_arm64.tar.gz"
      sha256 "2a20423581ab16be50cdf0b9e4a833dbf76c82b37bbef2bbe9b548ff311e0659"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.9.0/orion_v0.9.0_linux_amd64.tar.gz"
      sha256 "968242b20f6ef3f6e09bc38b64502b0ca8bceadc787f11e18eabfc4d046f8494"
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
