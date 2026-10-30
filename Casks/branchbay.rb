cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.9"
  sha256 arm:   "fd0229590160c3313fd5b0d2cfebbbb39a06279ee88ae6949ab873f4db4acb80",
         intel: "8653db079409576398b10ccec7e918c350eff563afc135d68525b6e17f1c38d9"

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
