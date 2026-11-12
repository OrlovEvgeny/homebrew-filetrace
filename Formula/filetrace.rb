class Filetrace < Formula
  desc "See which files a machine sends over the network, and where they go"
  homepage "https://github.com/OrlovEvgeny/filetrace"
  version "26.11.5.6"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.5.6-stable/filetrace-26.11.5.6-darwin-arm64.tar.gz"
      sha256 "12e88f99bd968af392be478538362b18d1ebfea9b4aee2c2ca29212ba7b4f654"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.5.6-stable/filetrace-26.11.5.6-darwin-amd64.tar.gz"
      sha256 "486b27243612673c305029f62d41908880f1ffe39428c2e2f66a0dfa70eefefe"
    end
  end

  on_linux do
    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.5.6-stable/filetrace-26.11.5.6-linux-arm64.tar.gz"
      sha256 "71c325514d0a5cd188e75e4dda101dc756ba984159a6cd332a3dd8014082aef7"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.5.6-stable/filetrace-26.11.5.6-linux-amd64.tar.gz"
      sha256 "552d739be8f688530d5a519550a48545b451a2fa5ce8ecc731226a14f7dbdec1"
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
