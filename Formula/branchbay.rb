class Branchbay < Formula
  desc "Native Git client"
  homepage "https://branchbay.dev/"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/releases/1.0.4/branch-bay-1.0.4-linux-x86_64.tar.gz"
  version "1.0.4"
  sha256 "a096b16292baf881d28b3b475a317712cbb2063a6ee0c9642b382e25a6fee950"
  license :cannot_represent

  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/releases/1.0.4/branch-bay-1.0.4-linux-aarch64.tar.gz"
      sha256 "26dc5d62e4390ebe4fcdce113ef634cf07cfe3c0c843dfb15194366be2e00a2b"
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
