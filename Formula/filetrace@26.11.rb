class FiletraceAT2611 < Formula
  desc "See which files a machine sends over the network, and where they go"
  homepage "https://github.com/OrlovEvgeny/filetrace"
  version "26.11.2.11"
  license "MIT"

  keg_only :versioned_formula

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.2.11-stable/filetrace-26.11.2.11-darwin-arm64.tar.gz"
      sha256 "ec8d5b6a962a6af7fac565f969af1e52eec4aa2294f9d7b84b23f3276c8fc3b4"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.2.11-stable/filetrace-26.11.2.11-darwin-amd64.tar.gz"
      sha256 "b38bc53c9d1b2a4ae13bf5950d450afe84f55b1df736502e6113ef21434c8660"
    end
  end

  on_linux do
    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.2.11-stable/filetrace-26.11.2.11-linux-arm64.tar.gz"
      sha256 "2507a12de731ac700b61c23319f11b0ffaf09cee96e2a78603b96756ed285ee6"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.2.11-stable/filetrace-26.11.2.11-linux-amd64.tar.gz"
      sha256 "86b874424e1df0d89581783d48e694ac35ad9314d55a52b1edbd3c294b077734"
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
