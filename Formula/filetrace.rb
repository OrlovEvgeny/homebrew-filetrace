class Filetrace < Formula
  desc "See which files a machine sends over the network, and where they go"
  homepage "https://github.com/OrlovEvgeny/filetrace"
  version "26.11.4.16"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.4.16-stable/filetrace-26.11.4.16-darwin-arm64.tar.gz"
      sha256 "9bdf6a18e85cab2909c2ff1a5742eb6624b44415a185bec09ff5fd776fc6ad6e"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.4.16-stable/filetrace-26.11.4.16-darwin-amd64.tar.gz"
      sha256 "b465c31bab1dbd59cf37cea734f1aef6ad4e9be0a270745cbaebb42f4cb602ec"
    end
  end

  on_linux do
    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.4.16-stable/filetrace-26.11.4.16-linux-arm64.tar.gz"
      sha256 "acd32cf98186e006aa69884c1b8ede39c9c82276cbf726219a727cc3c692e363"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.4.16-stable/filetrace-26.11.4.16-linux-amd64.tar.gz"
      sha256 "154ce671c027f57a7806cb4a744dd1e3d682b2f371b551185b0ca530f379288d"
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
