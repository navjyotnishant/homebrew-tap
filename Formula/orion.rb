class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.10.0/orion_v0.10.0_darwin_arm64.tar.gz"
      sha256 "e577843acb1f144e538d9a3a150964f50c8b7871a6494222808abce705b961d5"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.10.0/orion_v0.10.0_darwin_amd64.tar.gz"
      sha256 "c6e8794b025385165ba0ed2b6c94271a64bae6d8a87c38ae82e6c89b69955270"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.10.0/orion_v0.10.0_linux_arm64.tar.gz"
      sha256 "67096a0bef15dc23200b47f71599006c06145523dd2a2cbcb4f0bd54d4833725"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.10.0/orion_v0.10.0_linux_amd64.tar.gz"
      sha256 "65eb39111f87b74d67b6e75d86cdd16844a0aee742b4c976fdeb09406b16652d"
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
