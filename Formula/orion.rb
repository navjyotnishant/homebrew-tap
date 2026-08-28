class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.2/orion_v0.7.2_darwin_arm64.tar.gz"
      sha256 "c68ad602328294a0b5eeceb088558ec3e5d56ec853675bad249199b36fb8fe19"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.2/orion_v0.7.2_darwin_amd64.tar.gz"
      sha256 "fe69def913e83f458d79cf5e714e0bb7c3d9babd96e4e21b6210a93ca365e723"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.2/orion_v0.7.2_linux_arm64.tar.gz"
      sha256 "896eb57b02a1aa4a930fc6c7daa1a6dbf3a5f4783879d1d8b5072a0bada56cbd"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.2/orion_v0.7.2_linux_amd64.tar.gz"
      sha256 "62f867ed59dee8e1b89e08b44aa79d28ee354c2f14f8f8065939b7ab98ecb1ee"
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
