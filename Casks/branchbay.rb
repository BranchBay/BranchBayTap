cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.10"
  sha256 arm:   "7eb472c240fb9e6f9ee5e0626879ee1b293c64dff086e132a08acb77813986b6",
         intel: "8cdb1f7a312612d421ef10fcef6ab535246a20b5d26678ae4dca84d6e00afb3d"

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
