class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.6.0/orion_v0.6.0_darwin_arm64.tar.gz"
      sha256 "69f5f9e6431df3499370ec8aaed15c9df869a4b23e72b31453489977b6418ade"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.6.0/orion_v0.6.0_darwin_amd64.tar.gz"
      sha256 "0b4f33b13573642b8dd576b09c0d8ff8fbd23cf5d0e3ac34b5bb3ee1509cdf80"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.6.0/orion_v0.6.0_linux_arm64.tar.gz"
      sha256 "7a32434cb1db03711d2f25964ec52111d9a8df3c05cd16d29422109c5702b98a"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.6.0/orion_v0.6.0_linux_amd64.tar.gz"
      sha256 "7c899578d3aecfc63e00ff238e498990e8ddcc48559475e5313089ec7818acb8"
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
