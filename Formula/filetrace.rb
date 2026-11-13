class Filetrace < Formula
  desc "See which files a machine sends over the network, and where they go"
  homepage "https://github.com/OrlovEvgeny/filetrace"
  version "26.11.9.33"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.9.33-stable/filetrace-26.11.9.33-darwin-arm64.tar.gz"
      sha256 "d958a226784cef937c9fb19fc056dbdfdb873a9aa138a32acfc05bddfe98e19d"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.9.33-stable/filetrace-26.11.9.33-darwin-amd64.tar.gz"
      sha256 "12da2fa80a0e1b8dbf1ee99cc0165e26c9f850f5ac709acdb0af945cbfe3c5b2"
    end
  end

  on_linux do
    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.9.33-stable/filetrace-26.11.9.33-linux-arm64.tar.gz"
      sha256 "4cafd432e4a5e921e9e345196a9cb8f4a0e8af2be25a90752f2d0389d196844f"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.9.33-stable/filetrace-26.11.9.33-linux-amd64.tar.gz"
      sha256 "a70331ba23e4b50a8b5ca8b51a6b7360b11ac61fc6bf0be58a2c5b5159dabb6f"
    end
  end

  def install
    bin.install "bin/filetrace", "bin/filetrace-agent"
    doc.install Dir["share/doc/filetrace/*"]
  end

  def caveats
    on_macos do
      <<~EOS
        macOS has no collection backend yet: the command reports diagnostics
        there, and collection needs Linux.
      EOS
    end
    on_linux do
      <<~EOS
        The agent needs root and is not registered as a service here. For a
        service that starts at boot, install the deb, rpm or apk package:
          https://github.com/OrlovEvgeny/filetrace#install
      EOS
    end
  end

  test do
    assert_match "Filetrace #{version}", shell_output("#{bin}/filetrace version")
  end
end
