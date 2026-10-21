cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.3"
  sha256 arm:   "3cf1e5f718eed6a7debd96c4fae447c1239d05ec32ff0589f452421908818811",
         intel: "2bed7dbb350488e23c676f5fb25fb8d1fa2c262dd7d08575fd90eebba2a85f84"

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
