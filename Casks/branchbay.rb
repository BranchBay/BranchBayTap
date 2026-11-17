cask "branchbay" do
  arch arm: "arm64", intel: "x86_64"

  version "1.0.13"
  sha256 arm:   "91ea0b784fc49b6618cfc5d76aa43599a047b27423f2597b8d7926e4ef0f512e",
         intel: "8cc57fd4851fc3c06e8f275f15999816ae89f042306b7d0c0899b47c8e3a248f"

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
