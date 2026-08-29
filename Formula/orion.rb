class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.9/orion_v0.7.9_darwin_arm64.tar.gz"
      sha256 "a89f891915859f6d73b7c5be1242839a7c05ad75b3cdb39f9c1a4235833bf583"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.9/orion_v0.7.9_darwin_amd64.tar.gz"
      sha256 "d5bb3c7c6e252e735019577fa832aca0c5b73dddf35f0fdc4c78ca6a0f4c64ec"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.9/orion_v0.7.9_linux_arm64.tar.gz"
      sha256 "be56e5be2dadb1e8a042a10d6c8461036affc7bcf0be5eec8dd401557475b4fe"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.9/orion_v0.7.9_linux_amd64.tar.gz"
      sha256 "9702f4f0e0967e7454c00f6339b2791e612d6af57f910167a62b2365a0e52b0d"
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
