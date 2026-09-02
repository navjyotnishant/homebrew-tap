class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.10/orion_v0.8.10_darwin_arm64.tar.gz"
      sha256 "ccbfaa37833a3f4227eb48a6d5f77accce839ff904af0408374c6f5157c3397f"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.10/orion_v0.8.10_darwin_amd64.tar.gz"
      sha256 "4f557f6f248926cc62927c23b2eec6a6ffbd9e5dd8a7d2f995553af35588411f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.10/orion_v0.8.10_linux_arm64.tar.gz"
      sha256 "bae38c94e8394cf201cd27cc5830d7176ce8aeaaee81e487143133cdd2d45a4a"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.10/orion_v0.8.10_linux_amd64.tar.gz"
      sha256 "3ab71011ed3488327b65cda61ce1c43e488d78f3795fcae68bfb9c554add9f5d"
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
