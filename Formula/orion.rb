class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.0/orion_v0.3.0_darwin_arm64.tar.gz"
      sha256 "4001c19e2424d71e560b8b541c17fa2249aca192a329189d28d2d01dde1f4ce0"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.0/orion_v0.3.0_darwin_amd64.tar.gz"
      sha256 "ad103d8b0360f60a83e282ea7331c31dbccd37beb694a475d9fc17ca9dcfd566"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.0/orion_v0.3.0_linux_arm64.tar.gz"
      sha256 "7e95b4735fcdcacb2d3f0aca8ae9cb25759ca44bd42bb85b0f2a0eec677d8d53"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.0/orion_v0.3.0_linux_amd64.tar.gz"
      sha256 "59a65c39ba920341b63c436baad0c680026b55b801ae74f9ec675c93600be7db"
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
