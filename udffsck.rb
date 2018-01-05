class Udffsck < Formula
  desc "Repair-enabled fsck for UDF (from Linux udftools)"
  homepage "https://github.com/pali/udftools"

  head do
    url "https://github.com/gmerlino/udftools.git"

    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  def install
    if build.head?
      inreplace "autogen.sh", "libtoolize", "glibtoolize"
      system "sh", "autogen.sh"
    end
    system "./configure", "--prefix=#{prefix}"
    cd("libudffs") { system "make" }
    cd("udffsck") { system "make" }
    system "mkdir", "#{prefix}/bin"
    system "cp", "udffsck/udffsck", "#{prefix}/bin/udffsck"
  end
end
