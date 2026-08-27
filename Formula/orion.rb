class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.5.1/orion_v0.5.1_darwin_arm64.tar.gz"
      sha256 "87b93e5d586ef6624e78696b01b63b5d1a7dec4b4d81ce65a8000406993e72ca"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.5.1/orion_v0.5.1_darwin_amd64.tar.gz"
      sha256 "b6e90194ebaa38dd0e078cdedd91e1a01146ad8c5abd07271bafbfdc192aaab2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.5.1/orion_v0.5.1_linux_arm64.tar.gz"
      sha256 "94ae2301fc8a5239ab23b4768e31cedebd5050995cf610354843a052e99ab36c"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.5.1/orion_v0.5.1_linux_amd64.tar.gz"
      sha256 "4706b33e62fe9ddccb343f1d33f6e09c2aef92ee8d6b5c7eb00cf4b30ec83056"
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
