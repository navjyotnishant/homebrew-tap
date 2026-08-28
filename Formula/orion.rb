class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.5/orion_v0.7.5_darwin_arm64.tar.gz"
      sha256 "26e664efdd069b26f94e208471de9ada47f946de7dd68553057c721acbdb17f5"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.5/orion_v0.7.5_darwin_amd64.tar.gz"
      sha256 "77b4d13a34c965b5fd9a23ca9e034120ea7f739eab944d655994ad390af67ce0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.5/orion_v0.7.5_linux_arm64.tar.gz"
      sha256 "376da6c70c0635bebe2d696454d60f99953484e5a6efa409d42167fc586c27e9"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.5/orion_v0.7.5_linux_amd64.tar.gz"
      sha256 "f6969ce478bc18324583028501466e9e650f10deed302bdd147ecef313e05a95"
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
