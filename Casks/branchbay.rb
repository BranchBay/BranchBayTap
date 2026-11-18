cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.1.0"
  sha256 arm:   "70ab9a158a07a4ef3809e2de3185583a2d89433e84f34ca98108a6cf09c79e69",
         intel: "6f56be45633d73542967815f076c0f3f7c6e6514d0d04cd49b22888f18a37695"

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
