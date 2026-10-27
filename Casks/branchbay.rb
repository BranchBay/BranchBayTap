cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.6"
  sha256 arm:   "64bbadf8d923806fff964e4830b86338418cea138d72d1941344a0f3332cceb9",
         intel: "225bbdb6bc76af388dee5626dc735aea5a01fc6db7636b8a47441f7bec36204f"

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
