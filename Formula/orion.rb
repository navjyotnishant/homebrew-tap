class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.11/orion_v0.8.11_darwin_arm64.tar.gz"
      sha256 "d5e1c179252992612408495f0595ce53326f74e43bd34e3f24e53e0e0f9041a8"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.11/orion_v0.8.11_darwin_amd64.tar.gz"
      sha256 "9eb878d21bdd82b44c02328d37d8646b198631f3e758fd67ec272134d92aab80"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.11/orion_v0.8.11_linux_arm64.tar.gz"
      sha256 "1cba8e54c43a21f7ea051a92f25e095cde56e22809edab6c36aece0a57cd0892"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.11/orion_v0.8.11_linux_amd64.tar.gz"
      sha256 "4263c1c0c678caed0581a148a9ba366e2a6b3062a109e928420d3da49efa254c"
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
