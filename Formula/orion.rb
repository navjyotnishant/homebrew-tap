class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.1/orion_v0.8.1_darwin_arm64.tar.gz"
      sha256 "68dcc5db57955f4a33e59ee9cbcabd8650168adb71df5a863e4d6a077ee3140f"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.1/orion_v0.8.1_darwin_amd64.tar.gz"
      sha256 "b32d29a01fb5b11ce0e67c8ef4a2da9094f4a3a51339c7b7f3b6785cf4951b86"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.1/orion_v0.8.1_linux_arm64.tar.gz"
      sha256 "8ba1bd392a174b91478b9e85e97d6c27bff6d4fec0b8d0aa247f01b4f88d4af8"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.1/orion_v0.8.1_linux_amd64.tar.gz"
      sha256 "21432de927184d6cc75d95d9d32a9b6d2bcc6aea4bbfc38732591d2d4850c9f3"
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
