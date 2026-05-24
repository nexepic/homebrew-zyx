class Zyx < Formula
  desc "High-performance embeddable graph database with Cypher query support"
  homepage "https://github.com/nexepic/zyx"
  url "https://github.com/nexepic/zyx/archive/refs/tags/v0.1.23.tar.gz"
  sha256 "96f8861654ef143db6f060a333f71b700626a80749263027107028313303b41b"
  license "Apache-2.0"

  depends_on "cmake" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "cli11"
  depends_on "antlr4-cpp-runtime"

  def install
    mkdir "buildDir"
    system "meson", "setup", "buildDir",
           "--buildtype=release",
           "-Ddefault_library=static",
           "-Db_lto=true",
           "-Dwarning_level=0",
           "-Dtests=disabled",
           "--prefix=#{prefix}",
           "--libdir=lib"
    system "meson", "compile", "-C", "buildDir"
    bin.install "buildDir/apps/cli/zyx"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zyx --version")
  end
end
