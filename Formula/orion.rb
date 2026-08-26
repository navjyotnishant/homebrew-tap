class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.3/orion_v0.3.3_darwin_arm64.tar.gz"
      sha256 "2e4bd293bf6385419e11c1b111f2780a2483389dcd4a2755ba3a747fdcee3b81"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.3/orion_v0.3.3_darwin_amd64.tar.gz"
      sha256 "0b6c3e99fdf8fb684d2b068b8b72ef41ecabbc152e326f9df9d065a1aaf41412"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.3/orion_v0.3.3_linux_arm64.tar.gz"
      sha256 "c71e9d50f600537889af50035bf94821356349d6f6a5ad28dad39bc0a62436b4"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.3/orion_v0.3.3_linux_amd64.tar.gz"
      sha256 "96227cf7230ebd98bfc24330858d6e0edbb6290c4eac96842b7ed3224307b011"
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
