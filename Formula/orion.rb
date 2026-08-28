class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.8/orion_v0.7.8_darwin_arm64.tar.gz"
      sha256 "0ef3529b59312430c2ee59e2782979908e7f29a4735259f4d638340df9787e1c"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.8/orion_v0.7.8_darwin_amd64.tar.gz"
      sha256 "766f774aa696a390f78ec441dc1dbb3bfcae4bcabc174803e8d56aa1267afaa4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.8/orion_v0.7.8_linux_arm64.tar.gz"
      sha256 "ecff90e68ae3e78e3139d9776607afa3f11db02656a6d2eb3dafafd4c311b1b4"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.8/orion_v0.7.8_linux_amd64.tar.gz"
      sha256 "8dc85aed28967a1db9a0d24237a7256c8f43eb45a7449eae268f5b0952c920a9"
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
