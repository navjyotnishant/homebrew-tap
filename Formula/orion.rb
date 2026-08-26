class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.2/orion_v0.3.2_darwin_arm64.tar.gz"
      sha256 "9a57a15ae3d460a8c712ff409bc052952d2836cb07d4236d20b8fa04262af256"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.2/orion_v0.3.2_darwin_amd64.tar.gz"
      sha256 "51af52d680c3616fb7e71d9ac32cc07e829d8d8418c9116a377e9f9f9aef1855"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.2/orion_v0.3.2_linux_arm64.tar.gz"
      sha256 "c3cccbaf34fde6a0b9cac058d0d341a8936a5e3ccd124063f593fcd9767bd646"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.2/orion_v0.3.2_linux_amd64.tar.gz"
      sha256 "789fe193a6be42cc042810fe53d12b829c9ad8e93dfc90b732dcccfd448ef006"
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
