class Filetrace < Formula
  desc "See which files a machine sends over the network, and where they go"
  homepage "https://github.com/OrlovEvgeny/filetrace"
  version "26.11.6.5"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.6.5-stable/filetrace-26.11.6.5-darwin-arm64.tar.gz"
      sha256 "a5a8548b800cac0961884d8056a1e6cadad7f05e94393f2ff6475bf13ef7c9b4"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.6.5-stable/filetrace-26.11.6.5-darwin-amd64.tar.gz"
      sha256 "56688cb64f0aca66cf032c919f77f5fd48cd81f97fd4827d5abcd18b2d7bc595"
    end
  end

  on_linux do
    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.6.5-stable/filetrace-26.11.6.5-linux-arm64.tar.gz"
      sha256 "509a304c7dd952deca08894cdf3a1c51db858f7efceb413a78dc876eb841ea90"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.6.5-stable/filetrace-26.11.6.5-linux-amd64.tar.gz"
      sha256 "4307f3d61520424b58e3f2655a626f65cb1b0385a4fdc48bdd75f18e1e0352b9"
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
