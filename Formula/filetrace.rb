class Filetrace < Formula
  desc "See which files a machine sends over the network, and where they go"
  homepage "https://github.com/OrlovEvgeny/filetrace"
  version "26.11.11.177"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.11.177-stable/filetrace-26.11.11.177-darwin-arm64.tar.gz"
      sha256 "dead5e7c14636963950ecb77b401c645485674f87eba497bfbb16def3b281dcd"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.11.177-stable/filetrace-26.11.11.177-darwin-amd64.tar.gz"
      sha256 "2a76b17c38aafca0527d8bd9c681e1b67956c4f6f08bdee68b71b6b87f6659d4"
    end
  end

  on_linux do
    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.11.177-stable/filetrace-26.11.11.177-linux-arm64.tar.gz"
      sha256 "9c8626cb9c72a996a53e2d0e40b5c3128c0c024d79db6538273c959d496a336d"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.11.177-stable/filetrace-26.11.11.177-linux-amd64.tar.gz"
      sha256 "1c177dc08ee8289f157dc397d9110d07c620806431cb2c64f7817a640d404317"
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
