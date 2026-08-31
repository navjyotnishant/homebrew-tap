class Orion < Formula
  desc "AI-native SDLC orchestrator: idea to reviewed pull request"
  homepage "https://github.com/NjAIAgents/orion-releases"
  license "Apache-2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.4/orion_v0.8.4_darwin_arm64.tar.gz"
      sha256 "57cafe13b98eb1b9f97883778e56eddb8bada9586ff68e80c9c27db89242c4b3"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.4/orion_v0.8.4_darwin_amd64.tar.gz"
      sha256 "eea5d8470862e7742f9d28a0bf07020409a76a202e2010cce2a98df950519017"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.4/orion_v0.8.4_linux_arm64.tar.gz"
      sha256 "bbd0d75cdcad8ecb54a4c6e940148a380e31cc314450edcd9314aa427f67e986"
    else
      url "https://github.com/NjAIAgents/orion-releases/releases/download/v0.8.4/orion_v0.8.4_linux_amd64.tar.gz"
      sha256 "64fa344ccef0b5765a8d70c70f20a67d38ad7b924556f7fc7f2e980d6ba01f9b"
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
