
# -----------------------------------------------------------------------------
# A Sample build.mk
#
# Uncomment one of the following BuildFlavour settings to get the desired
# overall build type, and then tweak the options in the relevant section
# below.

# Uncomment one of these to select a build profile below:

# Full build with max optimisation (slow build)
BuildFlavour = perf

# Fastest build (libs unoptimised):
#BuildFlavour = quickest

# Fast build with optimised libraries:
#BuildFlavour = quick

# Profile the stage2 compiler:
#BuildFlavour = prof

# A development build, working on the stage 1 compiler:
#BuildFlavour = devel1

# A development build, working on the stage 2 compiler:
#BuildFlavour = devel2

GhcLibWays = v

# -------- 1. A Performance/Distribution build--------------------------------

ifeq "$(BuildFlavour)" "perf"

# perf matches the default settings, repeated here for comparison:

SRC_HC_OPTS     = -O -H64m
GhcStage1HcOpts = -O -fasm
GhcStage2HcOpts = -O2 -fasm
GhcHcOpts       = -Rghc-timing
GhcLibHcOpts    = -O2 -XGenerics
GhcLibWays     += p

HADDOCK_DOCS       = YES

ifeq "$(PlatformSupportsSharedLibs)" "YES"
GhcLibWays += dyn
endif

endif

# -------- A Fast build ------------------------------------------------------

ifeq "$(BuildFlavour)" "quickest"

SRC_HC_OPTS        = -H64m -O0 -fasm
GhcStage1HcOpts    = -O -fasm
GhcStage2HcOpts    = -O0 -fasm
GhcLibHcOpts       = -O0 -fasm
SplitObjs          = NO
HADDOCK_DOCS       = YES
BUILD_DOCBOOK_HTML = NO
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO

endif

# -------- A Fast build with optimised libs ----------------------------------

ifeq "$(BuildFlavour)" "quick"

SRC_HC_OPTS        = -H64m -O0 -fasm
GhcStage1HcOpts    = -O -fasm
GhcStage2HcOpts    = -O0 -fasm
GhcLibHcOpts       = -O -fasm
SplitObjs          = NO
HADDOCK_DOCS       = YES
BUILD_DOCBOOK_HTML = NO
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO

endif

# -------- Profile the stage2 compiler ---------------------------------------

ifeq "$(BuildFlavour)" "prof"

SRC_HC_OPTS        = -H64m -O0 -fasm
GhcStage1HcOpts    = -O -fasm
GhcStage2HcOpts    = -O -fasm
GhcLibHcOpts       = -O -fasm

GhcLibWays         += p
GhcProfiled        = YES

SplitObjs          = NO
HADDOCK_DOCS       = YES
BUILD_DOCBOOK_HTML = NO
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO

endif


# -------- A Development build (stage 1) -------------------------------------

ifeq "$(BuildFlavour)" "devel1"

SRC_HC_OPTS        = -H64m -O -fasm
GhcLibHcOpts       = -O -dcore-lint
GhcStage1HcOpts    = -Rghc-timing -O0 -DDEBUG
GhcStage2HcOpts    = -Rghc-timing -O -fasm
SplitObjs          = NO
HADDOCK_DOCS       = YES
BUILD_DOCBOOK_HTML = NO
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO

endif

# -------- A Development build (stage 2) -------------------------------------

ifeq "$(BuildFlavour)" "devel2"

SRC_HC_OPTS        = -H64m -O -fasm
GhcLibHcOpts       = -O -dcore-lint
GhcStage1HcOpts    = -Rghc-timing -O -fasm
GhcStage2HcOpts    = -Rghc-timing -O0 -DDEBUG
SplitObjs          = NO
HADDOCK_DOCS       = YES
BUILD_DOCBOOK_HTML = NO
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO

endif

# -----------------------------------------------------------------------------
# Other settings that might be useful

# profiled RTS
#GhcRtsCcOpts =  -pg -g

# Optimised/profiled RTS
#GhcRtsCcOpts = -O2 -pg

#GhcRtsWithFrontPanel = YES
#SRC_HC_OPTS += `gtk-config --libs`

# NoFib settings
NoFibWays =
STRIP_CMD = :

# Building PDF or PS seems not to work for ghc-7
HADDOCK_DOCS       = YES
BUILD_DOCBOOK_HTML = YES
BUILD_DOCBOOK_PS   = NO
BUILD_DOCBOOK_PDF  = NO

# Make sure we build hoogle index and html for every library
libraries/base_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/array_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/bin-package-db_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/bytestring_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/Cabal_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/containers_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/directory_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/extensible-exceptions_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/filepath_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/ghc-binary_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/ghc-prim_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/haskell2010_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/haskell98_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/hpc_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/integer-gmp_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/old-locale_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/old-time_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/pretty_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/process_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/random_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/template-haskell_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/time_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/unix_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
utils/ghc-pkg_dist-install_HADDOCK_OPTS += --hoogle --html --internal --executable --use-unicode
utils/hsc2hs_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode


## We will need to install these docs by hand - some installer bug
libraries/xhtml_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/utf8-string_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/haskeline_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/mtl_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode
libraries/terminfo_dist-install_HADDOCK_OPTS += --hoogle --html --use-unicode


