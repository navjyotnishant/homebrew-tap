class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.12.0/orion_v0.12.0_darwin_arm64.tar.gz"
      sha256 "51234e797afb6123d452f0193b78af9757a5bd1bee2045bcd75dd859aecb540f"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.12.0/orion_v0.12.0_darwin_amd64.tar.gz"
      sha256 "5ec4d83dd254ba382635db19109168a662ab606875df75f4a579bed529e28003"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.12.0/orion_v0.12.0_linux_arm64.tar.gz"
      sha256 "a70e757dad4740979fdf12d57234b99e73c041f835238a9a15824b083b179062"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.12.0/orion_v0.12.0_linux_amd64.tar.gz"
      sha256 "7ee1406f09ffcf85ad4849d572f85507b85386440ad5008197f5404b511fbce2"
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
