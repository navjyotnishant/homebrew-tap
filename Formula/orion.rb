class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.3/orion_v0.8.3_darwin_arm64.tar.gz"
      sha256 "4e92c7a4f529a2c37b6a565430263648f9c7c8870d8dadb6ac7c3261e2f1e76e"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.3/orion_v0.8.3_darwin_amd64.tar.gz"
      sha256 "c22f9afd0fc380a19977d9d252f1210969e782011f761b1e8afffb5a97939db5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.3/orion_v0.8.3_linux_arm64.tar.gz"
      sha256 "47d4bb2ea5c95067ca9438fb87b512ef3c8d4c4a24e6418a9b5bd4832a6f2230"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.3/orion_v0.8.3_linux_amd64.tar.gz"
      sha256 "f20d8ad6e7517515cb9026725beaeb1c942a66dd45c916b359247719e1fd60ad"
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
