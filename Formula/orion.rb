class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.7/orion_v0.8.7_darwin_arm64.tar.gz"
      sha256 "7c34ada9dfdc02b6ae761ea54e7b670fafbe83fd6087849e4e37bb8d7e319d45"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.7/orion_v0.8.7_darwin_amd64.tar.gz"
      sha256 "0038b90a63367ff1f030a19fbbb0e39c041f2ffdf05ca1c5a70857d27eab57ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.7/orion_v0.8.7_linux_arm64.tar.gz"
      sha256 "38d681c0c6255c7bc109570188646b4b2a0a4c82b8efdefee1563bf465925f81"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.7/orion_v0.8.7_linux_amd64.tar.gz"
      sha256 "473494cc3a1d8516a481c90e2e4c7f0f8e2a734dfd962e8bac27679528bd94c4"
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
