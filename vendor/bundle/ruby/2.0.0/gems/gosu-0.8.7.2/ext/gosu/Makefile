
SHELL = /bin/sh

# V=0 quiet, V=1 verbose.  other values don't work.
V = 0
Q1 = $(V:1=)
Q = $(Q1:0=@)
ECHO1 = $(V:1=@:)
ECHO = $(ECHO1:0=@echo)

#### Start of system configuration section. ####

srcdir = .
topdir = /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/include/ruby-2.0.0
hdrdir = $(topdir)
arch_hdrdir = /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr/include/ruby-2.0.0/universal-darwin14
PATH_SEPARATOR = :
VPATH = $(srcdir):$(arch_hdrdir)/ruby:$(hdrdir)/ruby
prefix = /System/Library/Frameworks/Ruby.framework/Versions/2.0/usr
rubysitearchprefix = $(rubylibprefix)/$(sitearch)
rubyarchprefix = $(rubylibprefix)/$(arch)
rubylibprefix = $(libdir)/$(RUBY_BASE_NAME)
exec_prefix = $(prefix)
vendorarchhdrdir = $(vendorhdrdir)/$(sitearch)
sitearchhdrdir = $(sitehdrdir)/$(sitearch)
rubyarchhdrdir = $(rubyhdrdir)/$(arch)
vendorhdrdir = $(rubyhdrdir)/vendor_ruby
sitehdrdir = $(rubyhdrdir)/site_ruby
rubyhdrdir = $(includedir)/$(RUBY_VERSION_NAME)
vendorarchdir = $(vendorlibdir)/$(sitearch)
vendorlibdir = $(vendordir)/$(ruby_version)
vendordir = $(rubylibprefix)/vendor_ruby
sitearchdir = ./.gem.20150127-97101-1s3k39e
sitelibdir = ./.gem.20150127-97101-1s3k39e
sitedir = $(DESTDIR)/Library/Ruby/Site
rubyarchdir = $(rubylibdir)/$(arch)
rubylibdir = $(rubylibprefix)/$(ruby_version)
sitearchincludedir = $(includedir)/$(sitearch)
archincludedir = $(includedir)/$(arch)
sitearchlibdir = $(libdir)/$(sitearch)
archlibdir = $(libdir)/$(arch)
ridir = $(datarootdir)/$(RI_BASE_NAME)
mandir = $(DESTDIR)/usr/share/man
localedir = $(datarootdir)/locale
libdir = $(exec_prefix)/lib
psdir = $(docdir)
pdfdir = $(docdir)
dvidir = $(docdir)
htmldir = $(docdir)
infodir = $(DESTDIR)/usr/share/info
docdir = $(datarootdir)/doc/$(PACKAGE)
oldincludedir = /usr/include
includedir = $(prefix)/include
localstatedir = $(prefix)/var
sharedstatedir = $(prefix)/com
sysconfdir = $(DESTDIR)/Library/Ruby/Site
datadir = $(datarootdir)
datarootdir = $(prefix)/share
libexecdir = $(exec_prefix)/libexec
sbindir = $(exec_prefix)/sbin
bindir = $(exec_prefix)/bin
archdir = $(rubyarchdir)


CC = xcrun clang
CXX = xcrun clang++
LIBRUBY = $(LIBRUBY_SO)
LIBRUBY_A = lib$(RUBY_SO_NAME)-static.a
LIBRUBYARG_SHARED = -l$(RUBY_SO_NAME)
LIBRUBYARG_STATIC = -l$(RUBY_SO_NAME)-static
empty =
OUTFLAG = -o $(empty)
COUTFLAG = -o $(empty)

RUBY_EXTCONF_H = 
cflags   =  $(optflags) $(debugflags) $(warnflags)
optflags = 
debugflags = -g
warnflags = 
CCDLFLAGS = 
CFLAGS   = $(CCDLFLAGS)  -g -Os -pipe -DHAVE_GCC_SYNC_BUILTINS -DGOSU_DEPRECATED= -I/usr/local/include -x objective-c -DNDEBUG $(ARCH_FLAG)
INCFLAGS = -I. -I$(arch_hdrdir) -I$(hdrdir)/ruby/backward -I$(hdrdir) -I$(srcdir) -I../.. -I../../src
DEFS     = 
CPPFLAGS =  -D_XOPEN_SOURCE -D_DARWIN_C_SOURCE -D_DARWIN_UNLIMITED_SELECT -D_REENTRANT $(DEFS) $(cppflags)
CXXFLAGS = $(CCDLFLAGS)  -g -Os -pipe -DHAVE_GCC_SYNC_BUILTINS -DGOSU_DEPRECATED= -I/usr/local/include -x objective-c -DNDEBUG  -I/usr/local/include -x objective-c++ -U_GLIBCXX_DEBUG -U_GLIBCXX_DEBUG_PEDANTIC -stdlib=libc++ -std=gnu++11 $(ARCH_FLAG)
ldflags  = -L. -L/usr/local/lib -liconv -L/usr/local/lib  -lSDL2 -logg -lvorbis -lvorbisfile -framework AudioToolbox -framework IOKit -framework OpenAL -framework OpenGL -framework AppKit -framework ApplicationServices -framework Foundation -framework Carbon
dldflags = -Wl,-undefined,dynamic_lookup -Wl,-multiply_defined,suppress 
ARCH_FLAG =  -arch x86_64 -arch i386
DLDFLAGS = $(ldflags) $(dldflags) $(ARCH_FLAG)
LDSHARED = $(CC) -dynamic -bundle
LDSHAREDXX = $(CXX) -dynamic -bundle
AR = ar
EXEEXT = 

RUBY_INSTALL_NAME = ruby
RUBY_SO_NAME = ruby.2.0.0
RUBYW_INSTALL_NAME = 
RUBY_VERSION_NAME = $(RUBY_BASE_NAME)-$(ruby_version)
RUBYW_BASE_NAME = rubyw
RUBY_BASE_NAME = ruby

arch = universal-darwin14
sitearch = $(arch)
ruby_version = 2.0.0
ruby = $(bindir)/ruby
RUBY = $(ruby)
ruby_headers = $(hdrdir)/ruby.h $(hdrdir)/ruby/defines.h $(arch_hdrdir)/ruby/config.h

RM = rm -f
RM_RF = $(RUBY) -run -e rm -- -rf
RMDIRS = rmdir -p
MAKEDIRS = mkdir -p
INSTALL = /usr/bin/install -c
INSTALL_PROG = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 644
COPY = cp
TOUCH = exit >

#### End of system configuration section. ####

preload = 

libpath = . $(libdir)
LIBPATH =  -L. -L$(libdir)
DEFFILE = 

CLEANFILES = mkmf.log
DISTCLEANFILES = 
DISTCLEANDIRS = 

extout = 
extout_prefix = 
target_prefix = 
LOCAL_LIBS = 
LIBS = $(LIBRUBYARG_SHARED)  -lpthread -ldl -lobjc 
ORIG_SRCS = gosu_wrap.cxx Audio-AudioOpenAL.cpp Bitmap-Bitmap.cpp Bitmap-BitmapApple.cpp Bitmap-BitmapColorKey.cpp Bitmap-BitmapUtils.cpp DirectoriesUnix.cpp FileUnix.cpp Graphics-BlockAllocator.cpp Graphics-Color.cpp Graphics-Graphics.cpp Graphics-Image.cpp Graphics-LargeImageData.cpp Graphics-Resolution.cpp Graphics-ResolutionApple.cpp Graphics-TexChunk.cpp Graphics-Texture.cpp Graphics-Transform.cpp Input-Input.cpp Input-TextInput.cpp Inspection.cpp IO.cpp Math.cpp Text-Font.cpp Text-Text.cpp Text-TextApple.cpp Text-TextMac.cpp TimingApple.cpp Utility.cpp UtilityApple.cpp Window.cpp
SRCS = $(ORIG_SRCS) 
OBJS = gosu_wrap.o Audio-AudioOpenAL.o Bitmap-Bitmap.o Bitmap-BitmapApple.o Bitmap-BitmapColorKey.o Bitmap-BitmapUtils.o DirectoriesUnix.o FileUnix.o Graphics-BlockAllocator.o Graphics-Color.o Graphics-Graphics.o Graphics-Image.o Graphics-LargeImageData.o Graphics-Resolution.o Graphics-ResolutionApple.o Graphics-TexChunk.o Graphics-Texture.o Graphics-Transform.o Input-Input.o Input-TextInput.o Inspection.o IO.o Math.o Text-Font.o Text-Text.o Text-TextApple.o Text-TextMac.o TimingApple.o Utility.o UtilityApple.o Window.o
HDRS = $(srcdir)/gosu_wrap.h
TARGET = gosu
TARGET_NAME = gosu
TARGET_ENTRY = Init_$(TARGET_NAME)
DLLIB = $(TARGET).bundle
EXTSTATIC = 
STATIC_LIB = 

BINDIR        = $(DESTDIR)$(bindir)
RUBYCOMMONDIR = $(DESTDIR)$(sitedir)$(target_prefix)
RUBYLIBDIR    = $(DESTDIR)$(sitelibdir)$(target_prefix)
RUBYARCHDIR   = $(DESTDIR)$(sitearchdir)$(target_prefix)
HDRDIR        = $(DESTDIR)$(rubyhdrdir)/ruby$(target_prefix)
ARCHHDRDIR    = $(DESTDIR)$(rubyhdrdir)/$(arch)/ruby$(target_prefix)

TARGET_SO     = $(DLLIB)
CLEANLIBS     = $(TARGET).bundle 
CLEANOBJS     = *.o  *.bak

all:    $(DLLIB)
static: $(STATIC_LIB)
.PHONY: all install static install-so install-rb
.PHONY: clean clean-so clean-static clean-rb

clean-static::
clean-rb-default::
clean-rb::
clean-so::
clean: clean-so clean-static clean-rb-default clean-rb
		-$(Q)$(RM) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES) .*.time

distclean-rb-default::
distclean-rb::
distclean-so::
distclean-static::
distclean: clean distclean-so distclean-static distclean-rb-default distclean-rb
		-$(Q)$(RM) Makefile $(RUBY_EXTCONF_H) conftest.* mkmf.log
		-$(Q)$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)
		-$(Q)$(RMDIRS) $(DISTCLEANDIRS) 2> /dev/null || true

realclean: distclean
install: install-so install-rb

install-so: $(DLLIB) ./.RUBYARCHDIR.time
	$(INSTALL_PROG) $(DLLIB) $(RUBYARCHDIR)
clean-static::
	-$(Q)$(RM) $(STATIC_LIB)
install-rb: pre-install-rb install-rb-default
install-rb-default: pre-install-rb-default
pre-install-rb: Makefile
pre-install-rb-default: Makefile
pre-install-rb-default:
	$(ECHO) installing default gosu libraries
./.RUBYARCHDIR.time:
	$(Q) $(MAKEDIRS) $(RUBYARCHDIR)
	$(Q) $(TOUCH) $@

site-install: site-install-so site-install-rb
site-install-so: install-so
site-install-rb: install-rb

.SUFFIXES: .c .m .cc .mm .cxx .cpp .C .o

.cc.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.mm.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.cxx.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.cpp.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.C.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $<

.c.o:
	$(ECHO) compiling $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -c $<

.m.o:
	$(ECHO) compiling $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -c $<

$(DLLIB): $(OBJS) Makefile
	$(ECHO) linking shared-object $(DLLIB)
	-$(Q)$(RM) $(@)
	$(Q) $(LDSHAREDXX) -o $@ $(OBJS) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)
	$(Q) test -z '$(RUBY_CODESIGN)' || codesign -s '$(RUBY_CODESIGN)' -f $@



$(OBJS): $(HDRS) $(ruby_headers)
