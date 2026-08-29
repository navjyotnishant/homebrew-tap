class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.0/orion_v0.8.0_darwin_arm64.tar.gz"
      sha256 "22c8d3a3390ede108813538dc68d489d167f131a8ed2a88e175cfe661a31b6d0"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.0/orion_v0.8.0_darwin_amd64.tar.gz"
      sha256 "471f3eb017a3811ad73fa69267acdad6d13ab2f656058ef7f91ce2b1f3bde4be"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.0/orion_v0.8.0_linux_arm64.tar.gz"
      sha256 "61e0b694ae6af1ba9803ec6c93eb69a6fdd60ecf6282323ad552884564891867"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.0/orion_v0.8.0_linux_amd64.tar.gz"
      sha256 "a6a3f4453882f04a2d2a097f190c78b711e5a3134f5804648d0f65ac98917b79"
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
