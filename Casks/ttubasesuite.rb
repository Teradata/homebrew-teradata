cask "ttubasesuite" do
  version "20.00.18.00,2024-12"
  sha256 "1949e2ee5f00a228eedef8dbb08c753b3169c6b6041c6ea742c5f5614d1b191d"

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
