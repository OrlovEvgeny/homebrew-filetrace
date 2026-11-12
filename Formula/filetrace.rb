class Filetrace < Formula
  desc "See which files a machine sends over the network, and where they go"
  homepage "https://github.com/OrlovEvgeny/filetrace"
  version "26.11.7.4"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.7.4-stable/filetrace-26.11.7.4-darwin-arm64.tar.gz"
      sha256 "4be9ad23204bcc87d98c31b5f112cdcca87f8cce1ee0fa8f52e8d79c08a76a07"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.7.4-stable/filetrace-26.11.7.4-darwin-amd64.tar.gz"
      sha256 "11c625da9873cc57b96bcf6ad08981a3c62c19d2d1fc674e1816c5c7f52f1a33"
    end
  end

  on_linux do
    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.7.4-stable/filetrace-26.11.7.4-linux-arm64.tar.gz"
      sha256 "76e100280fa761b0cc417f6c53dd1be246cc86c4bbdc38d084c92503c1c50d56"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.7.4-stable/filetrace-26.11.7.4-linux-amd64.tar.gz"
      sha256 "c89483ae5156fc69663042c164db3c98917cd81a752665b79765fd63b0a8ccf3"
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
