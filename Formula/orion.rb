class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.2.0/orion_v0.2.0_darwin_arm64.tar.gz"
      sha256 "dace11fe778eb815b46fae99811533783f20b2f25d94a9093b2e5c5a00fcaff4"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.2.0/orion_v0.2.0_darwin_amd64.tar.gz"
      sha256 "36424e02b0a3cab96d8d101815dff8751fefda9790dc68fa599b9e6604f47d60"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.2.0/orion_v0.2.0_linux_arm64.tar.gz"
      sha256 "531d70082843ba40e41f41e2e7cc2460ccc195d45bc1cf0eaabb2518245e5bb3"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.2.0/orion_v0.2.0_linux_amd64.tar.gz"
      sha256 "5a06268233bc4e1514df0e2632290334a862691049aed9a9417e3897be1e2084"
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
