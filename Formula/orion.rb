class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.7/orion_v0.7.7_darwin_arm64.tar.gz"
      sha256 "9fa317f928bacff4b5f57b24e48a3acb6e44205bdb0ee4992b6197f663a40c53"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.7/orion_v0.7.7_darwin_amd64.tar.gz"
      sha256 "264e67a0b8525f8efa777e9a553e036d8c44e81411e71c5144696ed94c0f9d55"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.7/orion_v0.7.7_linux_arm64.tar.gz"
      sha256 "d3c9b33e7c4d91a55dba5746c644092edb7bcaab0aa40b04172ea3365372f93d"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.7/orion_v0.7.7_linux_amd64.tar.gz"
      sha256 "43c6a0fbeddebba7ff0e06dad231b70d31234aee5c8012b30f7d1364ea6ffd56"
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
