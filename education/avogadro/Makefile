# $OpenBSD$

#ONLY_FOR_ARCHS =	???
#NOT_FOR_ARCHS =	???
#SHARED_ONLY =		???

V =			1.0.3
CATEGORIES =		education biology
COMMENT =		molecule editor and visualizer
DISTNAME =		avogadro-${V}
HOMEPAGE =		http://avogadro.openmolecules.net/

SHARED_LIBS +=		avogadro		0.0	# 1.0

#MAINTAINER =		???

PERMIT_PACKAGE_CDROM =	Yes | Reason if No
PERMIT_PACKAGE_FTP =	Yes | Reason if No
PERMIT_DISTFILES_CDROM =Yes | Reason if No
PERMIT_DISTFILES_FTP =	Yes | Reason if No

WANTLIB += c m pthread stdc++ z
WANTLIB += GL GLU ICE SM X11 Xext
WANTLIB += lib/qt4/QtGui lib/qt4/QtNetwork lib/qt4/QtOpenGL
WANTLIB += boost_python-mt openbabel python2.7

MASTER_SITES =		${MASTER_SITE_SOURCEFORGE:=avogadro/${V}/}
EXTRACT_SUFX =		.tar.bz2

MODULES =		devel/cmake x11/qt4
BUILD_DEPENDS =		textproc/docbook
RUN_DEPENDS =		devel/desktop-file-utils
LIB_DEPENDS =		devel/boost \
			devel/py-sip \
			graphics/glew \
			math/eigen2 \
			misc/openbabel \
			x11/py-qt4 \

SEPARATE_BUILD =	simple
USE_GROFF =		Yes

NO_REGRESS =		Yes

.include <bsd.port.mk>