class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.6/orion_v0.7.6_darwin_arm64.tar.gz"
      sha256 "e53b5852a030ebe336314ab9dbba396e72ce7be4572f160904302d15e60f27ad"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.6/orion_v0.7.6_darwin_amd64.tar.gz"
      sha256 "ce6cc927f472451ef6db8181c9d6c9f0e49d81b94abc9aded2ccd1ce4fb179f3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.6/orion_v0.7.6_linux_arm64.tar.gz"
      sha256 "6263f64f7f31db8f98e7a1f4ee917016cd61db950a88f11fc2511ff2192cea34"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.7.6/orion_v0.7.6_linux_amd64.tar.gz"
      sha256 "4539deec77f6bfb62cafd11fad7ad30ef7da06608f31061074aecf8ef278a127"
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
