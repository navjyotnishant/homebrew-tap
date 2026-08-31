class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.6/orion_v0.8.6_darwin_arm64.tar.gz"
      sha256 "0e08ffad8dcfc163b20060bfcc563dd50e6d9e6384a93e3858b500e5e1507fda"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.6/orion_v0.8.6_darwin_amd64.tar.gz"
      sha256 "c02c0d7a6ed10ed3f8a60277228a122abf158a0e8f40b575c1404e944d817bb1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.6/orion_v0.8.6_linux_arm64.tar.gz"
      sha256 "a475f313353d47ee8fc1bee160edad198058473ae10e9e424e981bba4c636602"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.6/orion_v0.8.6_linux_amd64.tar.gz"
      sha256 "d0174761e2fbbb8b6a5ff922f412273cb905e5beef0a717c06d4704be0af4803"
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
