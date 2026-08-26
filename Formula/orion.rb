class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.2/orion_v0.4.2_darwin_arm64.tar.gz"
      sha256 "7d7c2e22bd66917af6a7c1e178531d806041d563dab2d63db9f15d490abc80d4"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.2/orion_v0.4.2_darwin_amd64.tar.gz"
      sha256 "f85f0f699a07abe9cb9ae1fc37115ffe78d029e457c3ed6143a8e78eb4911636"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.2/orion_v0.4.2_linux_arm64.tar.gz"
      sha256 "6cf943c422ef82e608de4242897ce0f5680e2277adfb2e5a45363011bccc1d44"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.4.2/orion_v0.4.2_linux_amd64.tar.gz"
      sha256 "e23b28e4b4cc4b4c5eca54da365a2d1f205a57a57967a9819b9bda5c18946387"
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
