class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.9.1/orion_v0.9.1_darwin_arm64.tar.gz"
      sha256 "05c514f3445ca3a6ef7a34561dc56736f07bc255357b9c0f0a14a688501cb1d5"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.9.1/orion_v0.9.1_darwin_amd64.tar.gz"
      sha256 "0d504f5f57dcf7082e7bbe48f66e96d868fd780cb3777504e201a5a0e186f674"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.9.1/orion_v0.9.1_linux_arm64.tar.gz"
      sha256 "0409404c5db8a262270b38509756ba09ecfe89824c5915f3e6904fb582e2eb94"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.9.1/orion_v0.9.1_linux_amd64.tar.gz"
      sha256 "cb9b649611d4c6f30c0bac8da2795829d34382472f1d0edb6e7b3919fe98ac3a"
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
