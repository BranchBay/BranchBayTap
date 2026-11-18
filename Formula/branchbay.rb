class Branchbay < Formula
  desc "Native Git client"
  homepage "https://branchbay.dev/"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/releases/1.1.0/branch-bay-1.1.0-linux-x86_64.tar.gz"
  version "1.1.0"
  sha256 "f7228aad9da40f208cec2b3032be4134c2ba7f92adaad9491271fd22e25c4058"
  license :cannot_represent

  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/releases/1.1.0/branch-bay-1.1.0-linux-aarch64.tar.gz"
      sha256 "13969ca89946b5ffa338ccab4b9563db2f4a0aebebbbb88096254e5fcd308c87"
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
