cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.12"
  sha256 arm:   "fa40ef013ac9a9fcba33dd6624705bf73cb306018e5fa29aa7210280b8a82e2a",
         intel: "c321cb61a83b1c8db9bda8c16d40e0ba4dddf981cf2d4f4d17b18660c60c902b"

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
