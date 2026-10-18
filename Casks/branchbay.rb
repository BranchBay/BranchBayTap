cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.2"
  sha256 arm:   "95e7153087acd6ad6fc2bfacafe1308d5c8198f106daff5dc54843b7b614851d",
         intel: "d3e8a6e35ab88f609746f916bc9d42acaa5735d5da05e156546ce660e6ce3149"

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
