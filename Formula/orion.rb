class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.9/orion_v0.8.9_darwin_arm64.tar.gz"
      sha256 "ccfc23409541e18c96bd37efbc5692ee62ffb848d62353b48b0f423b3a9fde14"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.9/orion_v0.8.9_darwin_amd64.tar.gz"
      sha256 "3a4f94c6e69380293502fedcffb54a0a89fd69b06057d1e26e93e7d22d57e627"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.9/orion_v0.8.9_linux_arm64.tar.gz"
      sha256 "3fd31f2aa429e6d2a8c2775d598bed9bc5cdbcfe713abe52d36efd91aff1b80a"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.9/orion_v0.8.9_linux_amd64.tar.gz"
      sha256 "e7650ea3884331874dbaef4d5ca2fb49a86fd76d40d98cdea57ced9a645e51f5"
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
