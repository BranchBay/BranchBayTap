class Branchbay < Formula
  desc "Native Git client"
  homepage "https://branchbay.dev/"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/releases/1.0.1/branch-bay-1.0.1-linux-x86_64.tar.gz"
  version "1.0.1"
  sha256 "d007de05c8962ae3f39530e7b2d5a6576a22dd7568c71a4520d4d21e995c55de"
  license :cannot_represent

  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/releases/1.0.1/branch-bay-1.0.1-linux-aarch64.tar.gz"
      sha256 "c3c999f22e3d22b6a09f18a8662e05c99cf837e67707f3a398005a4377e259fd"
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
