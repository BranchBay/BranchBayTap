cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.8"
  sha256 arm:   "a84169c5934e1b40a212d91760d05b998459ae9b5e702903fed842b9f0c7cd52",
         intel: "578be451499936f7021e5b9b0e9bdd5c9d41e7d62a09be04c63f1c705055ad0d"

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
