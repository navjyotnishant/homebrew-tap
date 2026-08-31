class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.5/orion_v0.8.5_darwin_arm64.tar.gz"
      sha256 "bdaee52baa094fd24dc70f7cc88a7961ae28deb1473eb915179c95d8f158386b"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.5/orion_v0.8.5_darwin_amd64.tar.gz"
      sha256 "6e62342665ab076d395cf658b7830b0b8781743a9ac8a5af458f9e6529878192"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.5/orion_v0.8.5_linux_arm64.tar.gz"
      sha256 "c8caaa77ffa42347524b40f83bee5ac3a596fcbf5d486dab63b37fef4a26455d"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.5/orion_v0.8.5_linux_amd64.tar.gz"
      sha256 "7c523b74685a9a1dbd05d70bb9826bbb0940da039992fdc75e5ab873caa6e3ce"
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
