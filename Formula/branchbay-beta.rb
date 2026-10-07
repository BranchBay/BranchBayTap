class BranchbayBeta < Formula
  desc "Native Git client"
  homepage "https://branchbay.dev/"
  version "1.0.0-beta.1"
  license :cannot_represent

  depends_on :linux

  on_linux do
    on_intel do
      url "https://releases.branchbay.dev/releases/1.0.0-beta.1/branch-bay-1.0.0-beta.1-linux-x86_64.tar.gz"
      sha256 "f4543148636df50dee730dcd013dcb50b994460ea6720c4e883c9ca07bd459ef"
    end
    on_arm do
      url "https://releases.branchbay.dev/releases/1.0.0-beta.1/branch-bay-1.0.0-beta.1-linux-aarch64.tar.gz"
      sha256 "807e1c3f5a6a4045728343ca2531f379beb09551ba76a91546d7897a6b8973f9"
    end
  end

  def install
    bin.install "branch-bay"
    (share/"applications").install "branch-bay.desktop"
    (share/"icons").install "icons/hicolor"
  end

  test do
    assert_match "branch-bay", shell_output("#{bin}/branch-bay --version")
  end
end
