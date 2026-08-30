class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.2/orion_v0.8.2_darwin_arm64.tar.gz"
      sha256 "fbb3d327b57a1d15ac604a8022febf0dc887d4b0c780f80ba070d679064362fb"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.2/orion_v0.8.2_darwin_amd64.tar.gz"
      sha256 "21a55fadfdf3daf6ffbc875a35cd7c01ee546a19d978a4ef3f991da5fb2e012b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.2/orion_v0.8.2_linux_arm64.tar.gz"
      sha256 "fbe88636068445739ebb012b1f3141425278f6836c298779217b0ecceb3c1a73"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.2/orion_v0.8.2_linux_amd64.tar.gz"
      sha256 "75be1aec795579718a54c062190f6a0dd8cea7c88ff1f6cd95846d68282d6c36"
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
