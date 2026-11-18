cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.1.0"
  sha256 arm:   "aa0422f0e683556fd6144cd2b68acd5096da64d94ce92161f6d193cf0308a797",
         intel: "fa152a000a2082a31ea82a9e515478d15f55793bb8f1d76e333115351415630f"

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
