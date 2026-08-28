class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.3/orion_v0.7.3_darwin_arm64.tar.gz"
      sha256 "b1d903588b7dc093d20dc77ce090c61c85857a5407fd11e1dd2e977f9d4c4227"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.3/orion_v0.7.3_darwin_amd64.tar.gz"
      sha256 "55e31c41a2ded5be944fbf4c7deedbe2c38b4ba2a06328117a0ce23de4755d0d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.3/orion_v0.7.3_linux_arm64.tar.gz"
      sha256 "9849416dc88eda23cb75ea9f55a372013323a801655f2fbba8bec863e7a4bb2d"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.3/orion_v0.7.3_linux_amd64.tar.gz"
      sha256 "7cd9a73cee530a050975402a46bf4da34f55c6fc1412cd32f32f3aa65bc41135"
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
