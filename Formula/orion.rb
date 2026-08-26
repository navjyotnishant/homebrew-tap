class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.1.0/orion_v0.1.0_darwin_arm64.tar.gz"
      sha256 "dc77ea4d95c68b3e64700a31a7a1d83129cdd36affcf5b589b8b71274f9e8708"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.1.0/orion_v0.1.0_darwin_amd64.tar.gz"
      sha256 "159c6a570c833268c19df63c844c3d5e7f1d745158abd28d83e296dddea01d1e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.1.0/orion_v0.1.0_linux_arm64.tar.gz"
      sha256 "48bc1319cd27ad8d0bc1b4848145997dc40cccb39d324a907b672faa6b4fafb3"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.1.0/orion_v0.1.0_linux_amd64.tar.gz"
      sha256 "f4043578a43fc69d22eca49461d809fde7e22ac831cdd5652a235f4b68a91447"
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
