cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.0"
  sha256 arm:   "59657082e11d5592f6a981c98d5147a4675c493e55157b73ce617fa20e818f78",
         intel: "07090d80b2ea2722b2e85fafa79244fbb9f9078ba9e9b124cac8b2dca2f5c5aa"

  url "https://releases.branchbay.dev/releases/#{version}/branch-bay-#{version}-macos-#{arch}.dmg"
  name "BranchBay"
  desc "Native Git client"
  homepage "https://branchbay.dev/"

  livecheck do
    url "https://releases.branchbay.dev/channels/stable.json"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on macos: :ventura

  app "BranchBay.app"
  binary "#{appdir}/BranchBay.app/Contents/MacOS/branch-bay", target: "branch-bay"

  zap trash: [
    "~/Library/Application Support/BranchBay",
    "~/Library/Preferences/dev.branchbay.app.plist",
  ]
end
