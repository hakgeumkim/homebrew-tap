class LidAwake < Formula
  desc "Keep a MacBook awake with the lid closed on AC power, sleep normally on battery"
  homepage "https://github.com/hakgeumkim/lid-awake-skill"
  url "https://github.com/hakgeumkim/lid-awake-skill/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "bccb6d02972a250655c408b169154326ac0c0b4968682474d4ac8e465f53eeef"
  license "MIT"

  depends_on :macos

  def install
    contents = prefix/"LidAwake.app/Contents"
    (contents/"MacOS").mkpath
    system "swiftc", "-O", "main.swift", "-o", contents/"MacOS/LidAwake"
    contents.install "Info.plist"
    system "codesign", "--force", "-s", "-", prefix/"LidAwake.app"
    pkgshare.install "install-sudoers.sh"
  end

  def caveats
    <<~EOS
      LidAwake needs to run three pmset commands without a password. Allow them once:
        sudo #{opt_pkgshare}/install-sudoers.sh

      Copy the app and start it:
        cp -R #{opt_prefix}/LidAwake.app ~/Applications/ && open ~/Applications/LidAwake.app

      Then turn on "로그인 시 실행" (Launch at Login) in its menu bar menu.
    EOS
  end

  test do
    assert_path_exists prefix/"LidAwake.app/Contents/MacOS/LidAwake"
  end
end
