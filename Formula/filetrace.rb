class Filetrace < Formula
  desc "See which files a machine sends over the network, and where they go"
  homepage "https://github.com/OrlovEvgeny/filetrace"
  version "26.11.10.6"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.10.6-stable/filetrace-26.11.10.6-darwin-arm64.tar.gz"
      sha256 "699f64dd74d9533795a5556866a0b9e1fc36e6d62128e4caa2ed680f7fef0381"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.10.6-stable/filetrace-26.11.10.6-darwin-amd64.tar.gz"
      sha256 "90d37d898624d3ba86f777b1ab4d89c7650dd43e2535cfb8323c742622c09db8"
    end
  end

  on_linux do
    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.10.6-stable/filetrace-26.11.10.6-linux-arm64.tar.gz"
      sha256 "9116b2d1bf1b55633b9d16956cd30cd03b61cd3d19a2f98725e156e73050a090"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.10.6-stable/filetrace-26.11.10.6-linux-amd64.tar.gz"
      sha256 "208ced6e1340e891c83ccea1ac6bbbfd3b3cca1ef127609c591d51fccabdca9a"
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
