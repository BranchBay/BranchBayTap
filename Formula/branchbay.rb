class Branchbay < Formula
  desc "Native Git client"
  homepage "https://branchbay.dev/"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/releases/1.0.11/branch-bay-1.0.11-linux-x86_64.tar.gz"
  version "1.0.11"
  sha256 "b1f4d24e28d8401b6255993c6698f8f38b7ffd600d04c676b3a22ca081cd4d65"
  license :cannot_represent

  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/releases/1.0.11/branch-bay-1.0.11-linux-aarch64.tar.gz"
      sha256 "48cfbf2ac8c6138153bac7545fbb6cd793b1d0c9ce3aea9c00e9adcd7169c871"
    end
  end

  def install
    # A prebuilt binary looks for its libraries on the system path, so the
    # launcher in bin points it at Homebrew's.
    libexec.install "branch-bay"
    (bin/"branch-bay").write_env_script libexec/"branch-bay", LD_LIBRARY_PATH: "#{HOMEBREW_PREFIX}/lib"
    (share/"applications").install "branch-bay.desktop"
    (share/"icons").install "icons/hicolor"
  end

  test do
    assert_match "branch-bay", shell_output("#{bin}/branch-bay --version")
  end
end
