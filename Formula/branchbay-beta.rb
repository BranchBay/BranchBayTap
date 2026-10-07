class BranchbayBeta < Formula
  desc "Native Git client"
  homepage "https://branchbay.dev/"
  # A URL outside any block, so the formula loads on macOS too, where
  # `depends_on :linux` then refuses it.
  url "https://releases.branchbay.dev/releases/1.0.0-beta.1/branch-bay-1.0.0-beta.1-linux-x86_64.tar.gz"
  version "1.0.0-beta.1"
  sha256 "a9e19ef0c7e874d18e5a57bf1c0213c0730570b363d7cfb23dcc0acc6c07f03e"
  license :cannot_represent

  depends_on "libxcb"
  depends_on "libxkbcommon"
  depends_on :linux

  on_linux do
    on_arm do
      url "https://releases.branchbay.dev/releases/1.0.0-beta.1/branch-bay-1.0.0-beta.1-linux-aarch64.tar.gz"
      sha256 "a5dae21aa97ec7190c0d1ee733aa6d75c1096a8a72d2917d31ca90ab9e18bf3b"
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
