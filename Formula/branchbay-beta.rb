class BranchbayBeta < Formula
  desc "Native Git client"
  homepage "https://branchbay.dev/"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/releases/1.0.0-beta.1/branch-bay-1.0.0-beta.1-linux-x86_64.tar.gz"
  version "1.0.0-beta.1"
  sha256 "0aba3208d79d914214a3e308fd03fc45da9c6979aa554d7f4a2f0d14a9eadc94"
  license :cannot_represent

  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/releases/1.0.0-beta.1/branch-bay-1.0.0-beta.1-linux-aarch64.tar.gz"
      sha256 "7698d89f5538f265a79e15d724be298699ee0aeab003b3c59c4c9d35dae8cdc8"
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
