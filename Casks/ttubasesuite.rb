cask "ttubasesuite" do
  version "20.00.29.00,"
  sha256 "0867c64867c94d5d3c8c3f325bc7fff92bb5b5abe2de2e5631f93aeb387ceca2"

  url "https://downloads.teradata.com/sites/default/files/#{version.csv.second}/TeradataToolsAndUtilities-macosx-brew-#{version.csv.first}.tar"
  name "Teradata Tools and Utilities"
  desc "Collection of Teradata client tools"
  homepage "https://downloads.teradata.com/TeradataToolsAndUtilities_macOSBrew"

  livecheck do
    url :homepage
    regex(%r{href=.*?/(\d+(?:-\d+)+)/TeradataToolsAndUtilities-macosx-brew[._-]v?(\d+(?:\.\d+)+)\.t}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match[1]},#{match[0]}" }
    end
  end

  depends_on macos: ">= :catalina"

  pkg "TeradataToolsAndUtilities#{version.csv.first}.pkg"

  uninstall script:  {
              executable: "silent-uninstall.sh",
              args:       ["BASE"],
              sudo:       true,
            },
            pkgutil: "com.Teradata.*2000.pkg.ttuuninstaller"

  zap trash: "~/Library/Saved Application State/com.teradata.TTUListProducts.savedState"

  caveats do
    license "https://downloads.teradata.com/download/license/download-agreement-teradata-tools-utilities"
  end
end
