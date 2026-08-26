class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.1/orion_v0.3.1_darwin_arm64.tar.gz"
      sha256 "9bd077227fefb64811e465634b766de5b635db97596f98fbee239940170af099"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.1/orion_v0.3.1_darwin_amd64.tar.gz"
      sha256 "23041385c5382602cbbc36936409112fbf935252b3771f0b25f66fa7e555acb9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.1/orion_v0.3.1_linux_arm64.tar.gz"
      sha256 "947a8629c93c7189985f32a305454cbbfb6fdd404da5eb1e63d02a5ea4f15359"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.3.1/orion_v0.3.1_linux_amd64.tar.gz"
      sha256 "3325a0a7146cdaec52c4d4671d35c4cc8af30265c4ff719fb71254a9b0591367"
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
