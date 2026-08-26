class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.3/orion_v0.4.3_darwin_arm64.tar.gz"
      sha256 "8ba8facb5ac1178ab9de1557f07614fe41d53ec4ced3a4bb6931e250c4dd18e9"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.3/orion_v0.4.3_darwin_amd64.tar.gz"
      sha256 "e6e8f598cdb444c406c9e7c1b4037495c360945c9db0c2d349ab9f6d3728cca6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.3/orion_v0.4.3_linux_arm64.tar.gz"
      sha256 "327aa79a150f2f44e05dfc72e2d56e63f4d50a15880fb734d936fb74683b73ab"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.3/orion_v0.4.3_linux_amd64.tar.gz"
      sha256 "e46dbdd350437f48879401bde3add443701ce1f941d060eb95404dff031fa00b"
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
