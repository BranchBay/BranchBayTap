cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.1"
  sha256 arm:   "f21bdf12b9d7fd4cc58efed57f58acc039bca155cf2673c6ddc627234e301fb0",
         intel: "e0391f52f0407ca7f24b65b59486c9e37a4f506695bee25270a7c216eba78469"

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
