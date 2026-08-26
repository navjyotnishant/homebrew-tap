class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.1/orion_v0.4.1_darwin_arm64.tar.gz"
      sha256 "2546df98dce668f008af967c10e7b35a707ca718b0b73b085c4268391f42bff0"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.1/orion_v0.4.1_darwin_amd64.tar.gz"
      sha256 "c41c5dd275e323ecb7b97893c7e847a3877dac3e9c93dd0392b2359fb94ac1b1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.1/orion_v0.4.1_linux_arm64.tar.gz"
      sha256 "37d25616e1c4beeb085e0a50150f100fa275ef34e1bcdce94d0c93bfc3b71fed"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.1/orion_v0.4.1_linux_amd64.tar.gz"
      sha256 "0fd7c95dbdeb349d61d79bc98a73528157db131af3939db4a6742b586eaeb1f3"
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
