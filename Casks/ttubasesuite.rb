cask "ttubasesuite" do
  version "20.00.23.00,2025-05"
  sha256 "24693ad17a1568ad0db1318ac59d394b36fca2e377fe01b6d28cb84b81d53b50"

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
