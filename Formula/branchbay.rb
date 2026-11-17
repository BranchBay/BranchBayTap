class Branchbay < Formula
  desc "Native Git client"
  homepage "https://branchbay.dev/"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/releases/1.0.13/branch-bay-1.0.13-linux-x86_64.tar.gz"
  version "1.0.13"
  sha256 "40b52794122b065db101238cc08404cb6b89f4648b9da64c872fe1b36f7c44a4"
  license :cannot_represent

  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/releases/1.0.13/branch-bay-1.0.13-linux-aarch64.tar.gz"
      sha256 "2a860ecebd8d853ae9a6f2559c1b7520886955f329caf9ef87a67dc757590df3"
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
