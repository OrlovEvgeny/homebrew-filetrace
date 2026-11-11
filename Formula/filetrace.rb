class Filetrace < Formula
  desc "See which files a machine sends over the network, and where they go"
  homepage "https://github.com/OrlovEvgeny/filetrace"
  version "26.11.1.160"
  license "MIT"

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.1.160-stable/filetrace-26.11.1.160-darwin-arm64.tar.gz"
      sha256 "b8bf23e2f1952d62dee1b70a0ef57d413791955af03f9ec19493f33668a2d937"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.1.160-stable/filetrace-26.11.1.160-darwin-amd64.tar.gz"
      sha256 "d6915a3a1ebdeb25b1410b7e8fd57331db81cc7964b776bd466962a74e29739b"
    end
  end

  on_linux do
    on_arm do
      url "https://filetrace.eorlov.org/dist/v26.11.1.160-stable/filetrace-26.11.1.160-linux-arm64.tar.gz"
      sha256 "7647c0beed01fe7a649c7fbfb73366dd186a093c11e57b928edf5535e8c1192d"
    end
    on_intel do
      url "https://filetrace.eorlov.org/dist/v26.11.1.160-stable/filetrace-26.11.1.160-linux-amd64.tar.gz"
      sha256 "040bec6ada4f1e897ce4ff51a5f2b47378852254b60d2dbfe4d008e31e52163d"
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
