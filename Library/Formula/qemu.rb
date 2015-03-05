require "formula"

class Qemu < Formula
  homepage "http://www.qemu.org/"
  head "git://git.qemu-project.org/qemu.git"
  url "http://wiki.qemu-project.org/download/qemu-2.2.0.tar.bz2"
  sha1 "9a16623775a92fd25334f4eced4e6a56ab536233"

  bottle do
    sha1 "becc370764c6a1408112cd0bfd534842591cdda5" => :yosemite
    sha1 "fbd6ec4d831ecf814a47a4dd1b0811223ecef5be" => :mavericks
    sha1 "27cc527a607c4c9d818e78eba2a0bd55ad5e52b9" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "libtool" => :build
  depends_on "jpeg"
  depends_on "gnutls"
  depends_on "glib"
  depends_on "pixman"
  depends_on "vde" => :optional
  depends_on "sdl" => :optional
  depends_on "gtk+" => :optional

  option "with-32-nics", "Increase the max nics to 32"
  
  def patches
    if build.include? 'with-32-nics'
      return :DATA
    end
  end
  
  def install
    args = %W[
      --prefix=#{prefix}
      --cc=#{ENV.cc}
      --host-cc=#{ENV.cc}
      --enable-cocoa
      --disable-bsd-user
      --disable-guest-agent
    ]
    args << (build.with?("sdl") ? "--enable-sdl" : "--disable-sdl")
    args << (build.with?("vde") ? "--enable-vde" : "--disable-vde")
    args << (build.with?("gtk+") ? "--enable-gtk" : "--disable-gtk")
    ENV["LIBTOOL"] = "glibtool"
    system "./configure", *args
    system "make", "V=1", "install"
  end
end

__END__
diff --git a/include/net/net.h b/include/net/net.h
index 008d610..20cf9a6 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -160,7 +160,7 @@ void do_info_network(Monitor *mon, const QDict *qdict);
 
 /* NIC info */
 
-#define MAX_NICS 8
+#define MAX_NICS 32
 
 struct NICInfo {
     MACAddr macaddr;