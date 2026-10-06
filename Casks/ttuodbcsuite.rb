cask "ttuodbcsuite" do
  version "20.00.40.00,2026-10"
  sha256 "a45e6b5157a3f4452401c42de979e22be013512bfc5fcac5935bf2a5ce3fb68e"

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

  # Minimum supported macOS. A bare symbol means ">=" (Homebrew PR #22185),
  # so this is macOS 11 and newer.
  depends_on macos: :big_sur

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
