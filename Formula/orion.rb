class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.4/orion_v0.7.4_darwin_arm64.tar.gz"
      sha256 "d73c6499273a3d2d3048012138daa2a6086f6f5b064c2adcd4f61efaccddfc6b"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.4/orion_v0.7.4_darwin_amd64.tar.gz"
      sha256 "c0b1fe6caa0a3bb1bb75df746cbf0fb051c52cd2a847656f90fe292c1feb4550"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.4/orion_v0.7.4_linux_arm64.tar.gz"
      sha256 "cfe8db9e18bcb8723590606220b76bb146ed8a9363468a8251da89eb8fc531de"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.4/orion_v0.7.4_linux_amd64.tar.gz"
      sha256 "fae1f0b44c142e50489e9bcc0355c336142583be60e02d2e43424a5093a76c00"
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
