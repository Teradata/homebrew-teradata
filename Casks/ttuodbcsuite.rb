cask "ttuodbcsuite" do
  version "20.00.18.00,2024-12"
  sha256 "8599aa56a65ac64e59a61b0f1cd828fb34e8d7ef8c24d5944a46c4c7651f5e64"

  url "https://downloads.teradata.com/sites/default/files/#{version.csv.second}/TeradataODBC-macosx-brew-#{version.csv.first}.tar"
  name "Teradata Tools and Utilities"
  desc "ODBC Driver for Teradata"
  homepage "https://downloads.teradata.com/TeradataToolsAndUtilities_macOSBrew"

  livecheck do
    url :homepage
    regex(%r{href=.*?/(\d+(?:-\d+)+)/TeradataODBC-macosx-brew[._-]v?(\d+(?:\.\d+)+)\.t}i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match[1]},#{match[0]}" }
    end
  end

  depends_on macos: ">= :catalina"

  pkg "TeradataODBC#{version.csv.first}.pkg"

  uninstall script:  {
              executable: "silent-uninstall.sh",
              args:       ["ODBC"],
              sudo:       true,
            },
            pkgutil: "com.Teradata.*2000.pkg.ttuuninstaller"

  zap trash: "~/Library/Saved Application State/com.teradata.TTUListProducts.savedState"

  caveats do
    license "https://downloads.teradata.com/download/license/download-agreement-teradata-tools-utilities"
  end
end
