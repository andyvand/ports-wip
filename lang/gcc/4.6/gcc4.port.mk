# $OpenBSD: gcc4.port.mk,v 1.14 2011/09/15 17:25:35 espie Exp $

MODGCC4_ARCHES?=
MODGCC4_LANGS?=


.if ${MODGCC4_LANGS:L} != "java" && !${MODGCC4_LANGS:L:Mc}
# Always include support for this
# unless only java is needed
MODGCC4_LANGS+=	c
.endif

_MODGCC4_OKAY = c c++ java fortran
.for _l in ${MODGCC4_LANGS:L}
.  if !${_MODGCC4_OKAY:M${_l}}
ERRORS += "Fatal: unknown language ${_l}"
.  endif
.endfor

_MODGCC4_ARCH_USES = No

.if ${MODGCC4_ARCHES:L} != ""
.  for _i in ${MODGCC4_ARCHES}
.    if !empty(MACHINE_ARCH:M${_i})
_MODGCC4_ARCH_USES = Yes
.    endif
.  endfor
.endif

COMPILER_VERSION ?= gcc2

_MODGCC4_LINKS =
.if ${_MODGCC4_ARCH_USES:L} == "yes"

.  if ${MODGCC4_LANGS:L:Mc} && ${COMPILER_VERSION:L:Ngcc4*}
BUILD_DEPENDS += gcc->=4.6,<4.7:lang/gcc/4.6
_MODGCC4_LINKS += egcc gcc egcc cc
.  endif

.  if ${MODGCC4_LANGS:L:Mc++}
.    if ${COMPILER_VERSION:L:Mgcc4*}
MODGCC4STDCPP = stdc++
WANTLIB += stdc++>=53.0
.    else
BUILD_DEPENDS += g++->=4.6,<4.7:lang/gcc/4.6,-c++
MODGCC4STDCPP = estdc++
LIB_DEPENDS += libstdc++->=4.6,<4.7:lang/gcc/4.6,-estdc
WANTLIB += estdc++>=7
_MODGCC4_LINKS += eg++ g++ eg++ c++
.    endif
.  endif

.  if ${MODGCC4_LANGS:L:Mfortran}
BUILD_DEPENDS += g95->=4.6,<4.7:lang/gcc/4.6,-f95
WANTLIB += gfortran>=2
LIB_DEPENDS += g95->=4.6,<4.7:lang/gcc/4.6,-f95
_MODGCC4_LINKS += egfortran gfortran
.  endif

.  if ${MODGCC4_LANGS:L:Mjava}
BUILD_DEPENDS += gcj->=4.6,<4.7:lang/gcc/4.6,-java
MODGCC4_GCJWANTLIB = gcj
MODGCC4_GCJLIBDEP = gcj->=4.6,<4.7:lang/gcc/4.6,-java
_MODGCC4_LINKS += egcj gcj egcjh gcjh ejar gjar egij gij
.  endif

.endif

.if !empty(_MODGCC4_LINKS)
.  for _src _dest in ${_MODGCC4_LINKS}
MODGCC4_post-patch += ln -sf ${LOCALBASE}/bin/${_src} ${WRKDIR}/bin/${_dest};
.  endfor
.endif

