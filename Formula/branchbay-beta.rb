class BranchbayBeta < Formula
  desc "Native Git client"
  homepage "https://branchbay.dev/"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/releases/1.0.0-beta.2/branch-bay-1.0.0-beta.2-linux-x86_64.tar.gz"
  version "1.0.0-beta.2"
  sha256 "9c0d40bd423eacf5d89380f2d3f7d128411f6db5307ad77798eb797a9f5872bf"
  license :cannot_represent

  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/releases/1.0.0-beta.2/branch-bay-1.0.0-beta.2-linux-aarch64.tar.gz"
      sha256 "33b77ebfaad33d4d44a094f026bc00d12ca2d32d7788b0ff536dc372671fabc2"
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
