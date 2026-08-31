class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.8/orion_v0.8.8_darwin_arm64.tar.gz"
      sha256 "f5d51a686c690b48077b122b4dbcd4c3dbcf559bf8f243ec73071bfff3bcb0c2"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.8/orion_v0.8.8_darwin_amd64.tar.gz"
      sha256 "fa91083b6cce6a46bd3378004d9f055f271adc77cb62c2d9645f85ef9b26a591"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.8/orion_v0.8.8_linux_arm64.tar.gz"
      sha256 "a9596297d34dbb16faeae97338800a1925c13e7adb505d9fb6f17f2e60b57518"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.8/orion_v0.8.8_linux_amd64.tar.gz"
      sha256 "5633d279a4f4d39dc39c8ae63995b6a9daa89cd1db763d426f7d25016f3de61e"
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
