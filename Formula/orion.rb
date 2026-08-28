class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.1/orion_v0.7.1_darwin_arm64.tar.gz"
      sha256 "0eb338009542a1e2e8ef910b7f541c53e9fd8d45f7524aa566faf2dc35d88595"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.1/orion_v0.7.1_darwin_amd64.tar.gz"
      sha256 "bf5495ac087b78ba78fe35f9053343a6175a38934a31ea5b578c7b7aec65df4f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.1/orion_v0.7.1_linux_arm64.tar.gz"
      sha256 "4975c7c2934685e4b6866c5b4e170bce8cf0384b55c9e39e5e8df711f72a9680"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.1/orion_v0.7.1_linux_amd64.tar.gz"
      sha256 "ea6a9a000cb9fe298a9e2a1ac8545e36c4a8c0a12e32e36114a0d4baec55c81e"
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
