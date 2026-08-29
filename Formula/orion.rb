class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.10/orion_v0.7.10_darwin_arm64.tar.gz"
      sha256 "c473e10edb80b22e75237f7862265ef8b26a308e7d023facf7e0878a3e09ed8a"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.10/orion_v0.7.10_darwin_amd64.tar.gz"
      sha256 "70c41351980d095245c648f28be1beb21d43b60c8c71c6e9ef0dad7d9d228ad5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.10/orion_v0.7.10_linux_arm64.tar.gz"
      sha256 "a8acf42ce0872f36131a94b0e43c0dec0e1dcdd87bf55969125040acd73b2679"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.10/orion_v0.7.10_linux_amd64.tar.gz"
      sha256 "e0878784145775104d81531d625ae4e20d20cc5c161b3e583d09f4de7b676d44"
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
