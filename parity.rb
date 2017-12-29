require 'formula'

class Parity < Formula
  homepage 'https://github.com/paritytech/parity'

  if build.include? "master" or build.include? "nightly"
    version '1.9.0'
    url 'http://d1h4xl4cr1h0mo.cloudfront.net/nightly/x86_64-apple-darwin/parity'
  elsif build.include? "beta" or build.include? "latest"
    version '1.8.4'
    url 'http://d1h4xl4cr1h0mo.cloudfront.net/v1.8.5/x86_64-apple-darwin/parity'
    sha256 "93285a110b4d89986345b0b125e8fb17dfd9d42d849610948e9a51b9d5b77eaa"
  elsif build.include? "stable"
    version '1.7.10'
    url 'http://d1h4xl4cr1h0mo.cloudfront.net/v1.7.11/x86_64-apple-darwin/parity'
    sha256 "b2d156510cdb2223b4c69910bf41062622da7caeed03429a2e1071907977892e"
  else
    version '1.8.4'
    url 'http://d1h4xl4cr1h0mo.cloudfront.net/v1.8.5/x86_64-apple-darwin/parity'
    sha256 "93285a110b4d89986345b0b125e8fb17dfd9d42d849610948e9a51b9d5b77eaa"
  end

  option 'master', 'Install nightly version.'
  option 'beta', 'Install latest beta (default). '
  option 'stable', 'Install latest stable'

  option 'geth-compatible', 'Run service with --geth option.'

  bottle :unneeded

  def install
    bin.install "parity"
  end

  test do
    system "#{bin}/delta", "--version"
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <true/>
        <key>ThrottleInterval</key>
        <integer>300</integer>
        <key>ProgramArguments</key>
        <array>
          <string>#{prefix}/bin/parity</string>
          #{'<string>--geth</string>' if build.include? 'geth-compatible'}
        </array>
        <key>WorkingDirectory</key>
        <string>#{HOMEBREW_PREFIX}</string>
      </dict>
    </plist>
    EOS
  end
end
