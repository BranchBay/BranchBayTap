cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.4"
  sha256 arm:   "174183a3f91f712f9debfeaa4acb1e90fe765ed3542327d29c27356384307330",
         intel: "4f3199216f01d1487b7a3ba5229cd588f39b5bdcaff50eab2dcfeb8a3e0ca6e9"

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
