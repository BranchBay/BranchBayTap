cask "branchbay@beta" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.0-beta.2"
  sha256 arm:   "89e6ba5cebb96c484d26fc5ca8ff335177b1fe704425d9ad1d6cfa520dfab892",
         intel: "358a80f6ec37ad33f4bd19d37a91283064a82d71a5a8665a76eacb106938f3c7"

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
