class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.11.0/orion_v0.11.0_darwin_arm64.tar.gz"
      sha256 "ab90876836a1bd3d0b37ff75b78a01b3a9173fd3822cc46b5b36958c7dfa1c26"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.11.0/orion_v0.11.0_darwin_amd64.tar.gz"
      sha256 "0da930cba14a583d9fd1b0f1bd660bde47f59ec9f157d0dccc75a9fcedbb1b85"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.11.0/orion_v0.11.0_linux_arm64.tar.gz"
      sha256 "d42fea4c24de3ee3d12a57a33d4aa5fd63b2810a1a5e87e72cc9a77f49ed0f82"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.11.0/orion_v0.11.0_linux_amd64.tar.gz"
      sha256 "6e5e033ee594307853a5f5e18c603b644dd33588b47d7a96c8089028640f5430"
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
