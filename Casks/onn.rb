cask "onn" do
  version "0.2.0"
  sha256 "6a30326e24436b8fe5013143d390eb9b78ce1b664d3e74abade741fa6b0c2852"

  url "https://github.com/jordan-simonovski/macos-outage-ticker/releases/download/v#{version}/ONN.dmg"
  name "ONN — Outage News Network"
  desc "Menu bar news ticker that cuts in when a status page reports an outage"
  homepage "https://github.com/jordan-simonovski/macos-outage-ticker"

  depends_on macos: :ventura

  app "ONN.app"

  # ONN is ad-hoc signed, not notarized, so Gatekeeper shows "Apple could not
  # verify ONN is free of malware" on first launch. That check is triggered by
  # the quarantine attribute Homebrew stamps on the download — stripping it here
  # keeps `brew install --cask onn` a single command with no --no-quarantine flag.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ONN.app"]
  end

  uninstall quit: "com.github.jordan-simonovski.ONN"

  zap trash: "~/Library/Application Support/ONN"
end
