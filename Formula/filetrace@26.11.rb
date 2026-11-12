class FiletraceAT2611 < Formula
  desc "See which files a machine sends over the network, and where they go"
  homepage "https://github.com/OrlovEvgeny/filetrace"
  version "26.11.8.191"
  license "MIT"

  keg_only :versioned_formula

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.8.191-stable/filetrace-26.11.8.191-darwin-arm64.tar.gz"
      sha256 "54d84ff24e6d86836142b509811ce3b690566d76164c3a54eafcf5e75158c251"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.8.191-stable/filetrace-26.11.8.191-darwin-amd64.tar.gz"
      sha256 "f8da412ef0f09061c1731d6e4d93f5c8ff2c37389fade97ba0e29288f31c7126"
    end
  end

  on_linux do
    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.8.191-stable/filetrace-26.11.8.191-linux-arm64.tar.gz"
      sha256 "b201458d27b67e97e6b25d55f85490b68e9bef6ad1ffa8f33798262e63bb904c"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.8.191-stable/filetrace-26.11.8.191-linux-amd64.tar.gz"
      sha256 "460ed3f661d6f3b92f48323f6c71ef0e637d0728d018cb84579d97406146fd5b"
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
