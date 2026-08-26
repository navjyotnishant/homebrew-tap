class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.4/orion_v0.4.4_darwin_arm64.tar.gz"
      sha256 "76b5a06b774d3e83cf765548469276281d047b35e598c8b228cc99cd9cc331b0"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.4/orion_v0.4.4_darwin_amd64.tar.gz"
      sha256 "cff143e6a3847e38ca10b5d97013539be73d2c30efd204af7d6845a202b2c813"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.4/orion_v0.4.4_linux_arm64.tar.gz"
      sha256 "4d44bc46acecbbbe9a719fa91f6d8394311e1c2bf3f623c53d485c722bbaf8d4"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.4/orion_v0.4.4_linux_amd64.tar.gz"
      sha256 "9fd24d28d4541ec9da8dd6c211c044de740b6b3b9af34063f5fc134b350bb301"
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
