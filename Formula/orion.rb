class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.0/orion_v0.4.0_darwin_arm64.tar.gz"
      sha256 "aa2d5ccde6182e539df679d11709d29cd66bd93674469e11ce25435502c802c9"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.0/orion_v0.4.0_darwin_amd64.tar.gz"
      sha256 "be0b36c1abb7cbf8e5394c89923088ad2d628dc03974a406209b97846fdb9d34"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.0/orion_v0.4.0_linux_arm64.tar.gz"
      sha256 "f3f6b44ffc84544ba5c0a376557ea73d413818cdd63b58830f354aba28144d54"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.0/orion_v0.4.0_linux_amd64.tar.gz"
      sha256 "e5774645a6794e8c3433d5bef4576a7c37d9ef12c74bbb0cf00f2cd4ae9f2280"
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
