cask "branchbay@beta" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.0-beta.1"
  sha256 arm:   "ae9c74bc1d2bd42b563b09c6d0bb17f1a09124cad518f233f3e8e257147062ae",
         intel: "f9993fde15db37792f2da2ed32c76bb6af8c74a9f87b8455caef8243412ef625"

  url "https://releases.branchbay.dev/releases/#{version}/branch-bay-#{version}-macos-#{arch}.dmg"
  name "BranchBay"
  desc "Native Git client"
  homepage "https://branchbay.dev/"

  livecheck do
    url "https://releases.branchbay.dev/channels/beta.json"
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
