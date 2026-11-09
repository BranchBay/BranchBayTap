cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.11"
  sha256 arm:   "0bc7dfcae4faacbb18f68714b18b261cd530bcfcf3ca79b694d3f984858fc7cb",
         intel: "d9daaf1fca47cf6d06b75884c3658e05d198a13ae812d155e46192a77b8ba575"

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
