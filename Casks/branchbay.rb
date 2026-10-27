cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.7"
  sha256 arm:   "77f329645983630d082e036d99f984d01fc06d179a8e44cde457115cb3e0e78d",
         intel: "72d2bc0481f2631190cca96db7a397136ad83ab08a249fae3934fc126e2b2ee7"

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
