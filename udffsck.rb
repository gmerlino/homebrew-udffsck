class Udffsck < Formula
  desc "Repair-enabled fsck for UDF (from Linux udftools)"
  homepage "https://github.com/pali/udftools"

  head "https://github.com/gmerlino/udftools.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  conflicts_with "udftools", :because => "both install `udffsck` binary"

  def install
    if build.head?
      inreplace "autogen.sh", "libtoolize", "glibtoolize"
      system "sh", "autogen.sh"
    end
    system "./configure", "--prefix=#{prefix}"
    cd("libudffs") { system "make" }
    cd("udffsck") { system "make" }
    mkdir bin.to_s
    cp "udffsck/udffsck", "#{bin}/udffsck"
  end

  test do
    system "#{bin}/udffsck", "--help"
  end
end
