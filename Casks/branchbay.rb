cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.5"
  sha256 arm:   "f41eae3c24463f2c80867dfa3632ee1f5187d4f0571bbde6352b2a72b26d331c",
         intel: "067f06a9bed531c7e19fca8a1675501ed502c29e9a5fcfea5930967068287bd0"

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
