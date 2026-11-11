class Filetrace < Formula
  desc "See which files a machine sends over the network, and where they go"
  homepage "https://github.com/OrlovEvgeny/filetrace"
  version "26.11.3.4"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.3.4-stable/filetrace-26.11.3.4-darwin-arm64.tar.gz"
      sha256 "830fcd5bd510dabc127523d2fceb083301d0156bd622e63fa64753453dec1fa6"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.3.4-stable/filetrace-26.11.3.4-darwin-amd64.tar.gz"
      sha256 "a0d3c321636c98fcb018a98fce3d8ddb054ad56bfd35ea0add60d94c385baa68"
    end
  end

  on_linux do
    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.3.4-stable/filetrace-26.11.3.4-linux-arm64.tar.gz"
      sha256 "214a8f732a365324a2af5a0e5dd4ab4e9845f11c9d5b8c195c856acd20e826d8"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.3.4-stable/filetrace-26.11.3.4-linux-amd64.tar.gz"
      sha256 "d89e5cd9d662091f6abfd85d11a47459d2f37065dd1ff169c7a0f2ad00b278a2"
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
