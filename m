Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E67EE44F
	for <lists+linux-block@lfdr.de>; Mon,  4 Nov 2019 16:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfKDPz4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Nov 2019 10:55:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34788 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727989AbfKDPzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 10:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572882955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1IlPEp/yPNlcJY8nMYUKAuC9khwJVXi8dm+r+xuCL/w=;
        b=Du3ZdfEm2mmELtnpQKzN84oDLRHvx9GKKmnTAOKkkG+F2mT/2Hs6O0Z6T/dIOOxLZ922L1
        KSnH4BkZ5ejwMV4LCe9sE7awBqRAaXZ01IQKFSADSnv10fjsxXZK7Y5KjQahuJjW8kzvcW
        Fxi/JmdYk5TOVoC+ihxSunyQ92yfbJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-xK3WRNTLOAWnX4lIz2uMjQ-1; Mon, 04 Nov 2019 10:55:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37FE11800DFB;
        Mon,  4 Nov 2019 15:55:52 +0000 (UTC)
Received: from localhost (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A11FF60863;
        Mon,  4 Nov 2019 15:55:45 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing v2 3/3] spec: Fedora RPM cleanups
Date:   Mon,  4 Nov 2019 16:55:24 +0100
Message-Id: <20191104155524.58422-4-stefanha@redhat.com>
In-Reply-To: <20191104155524.58422-1-stefanha@redhat.com>
References: <20191104155524.58422-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: xK3WRNTLOAWnX4lIz2uMjQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jeff Moyer <jmoyer@redhat.com>

Cole Robinson and Fabio Valenti made a number of suggestions for the
.spec file:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1766157

 * Release should be Release: 1%{?dist} so the .fcXX bits get appended
   to the version string
 * Source: should be a pointer to the upstream URL that hosts the
   release. In this case I think it should be
   https://github.com/axboe/liburing/archive/...
   the ending weirdness is due to github renaming the archive strangely.
   You might need to pass '-n %{name}-%{name}-%{version}' to
   %setup/%autosetup to tell it what the extracted archive name is
 * The %defattr lines should be removed:
   https://pagure.io/packaging-committee/issue/77
 * The Group: lines should be removed
 * All the BuildRoot and RPM_BUILD_ROOT lines should be removed. %clean
   should be removed
 * The ./configure line should be replaced with just %configure
 * The 'make' call should be %make_build
 * The 'make install' call should be %make_install
 * The %pre and %post sections can be entirely removed, ldconfig is
   done automatically:
   https://fedoraproject.org/wiki/Changes/Removing_ldconfig_scriptlets
 * The devel package 'Requires: liburing' should instead be: Requires:
   %{name} =3D %{version}-%{release}
 * The devel package should also have Requires: pkgconfig
 * I think all the %attr usage can be entirely removed, unless they are
   doing something that the build system isn't doing.
 * The Provides: liburing.so.1 shouldn't be necessary, I'm pretty sure
   RPM automatically adds annotations like this
 * Replace %setup with %autosetup, which will automatically apply any
   listed Patch: in the spec if anything is backported in the future.
   It's a small maintenace optimization

These changes work on Fedora 31 and openSUSE Leap 15.1.  Therefore they
are likely to work on other rpm-based distributions too.

Tested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 liburing.spec | 47 +++++++++++++++++++----------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/liburing.spec b/liburing.spec
index f9e9262..08d46f4 100644
--- a/liburing.spec
+++ b/liburing.spec
@@ -1,12 +1,11 @@
 Name: liburing
 Version: 0.2
-Release: 1
+Release: 1%{?dist}
 Summary: Linux-native io_uring I/O access library
 License: LGPLv2+
-Group:  System Environment/Libraries
 Source: %{name}-%{version}.tar.gz
-BuildRoot: %{_tmppath}/%{name}-root
-URL: http://git.kernel.dk/cgit/liburing/
+URL: http://brick.kernel.dk/snaps/%{name}-%{version}.tar.gz
+BuildRequires: gcc
=20
 %description
 Provides native async IO for the Linux kernel, in a fast and efficient
@@ -14,47 +13,39 @@ manner, for both buffered and O_DIRECT.
=20
 %package devel
 Summary: Development files for Linux-native io_uring I/O access library
-Group: Development/System
-Requires: liburing
-Provides: liburing.so.1
+Requires: %{name} =3D %{version}-%{release}
+Requires: pkgconfig
=20
 %description devel
 This package provides header files to include and libraries to link with
 for the Linux-native io_uring.
=20
 %prep
-%setup
+%autosetup
=20
 %build
-./configure --prefix=3D/usr --libdir=3D/%{_libdir} --mandir=3D/usr/share/m=
an
-make
+./configure --prefix=3D%{_prefix} --libdir=3D/%{_libdir} --mandir=3D%{_man=
dir} --includedir=3D%{_includedir}
=20
-%install
-[ "$RPM_BUILD_ROOT" !=3D "/" ] && rm -rf $RPM_BUILD_ROOT
-
-make install DESTDIR=3D$RPM_BUILD_ROOT
-
-%clean
-[ "$RPM_BUILD_ROOT" !=3D "/" ] && rm -rf $RPM_BUILD_ROOT
+%make_build
=20
-%post -p /sbin/ldconfig
-
-%postun -p /sbin/ldconfig
+%install
+%make_install
=20
 %files
-%defattr(-,root,root)
 %attr(0755,root,root) %{_libdir}/liburing.so.*
 %doc COPYING
=20
 %files devel
-%defattr(-,root,root)
-%attr(-,root,root) %{_includedir}/liburing/
-%attr(0644,root,root) %{_includedir}/liburing.h
-%attr(0755,root,root) %{_libdir}/liburing.so
-%attr(0644,root,root) %{_libdir}/liburing.a
-%attr(0644,root,root) %{_libdir}/pkgconfig/*
-%attr(0644,root,root) %{_mandir}/man2/*
+%{_includedir}/liburing/
+%{_includedir}/liburing.h
+%{_libdir}/liburing.so
+%{_libdir}/liburing.a
+%{_libdir}/pkgconfig/*
+%{_mandir}/man2/*
=20
 %changelog
+* Thu Oct 31 2019 Jeff Moyer <jmoyer@redhat.com> - 0.2-1
+- Initial fedora package.
+
 * Tue Jan 8 2019 Jens Axboe <axboe@kernel.dk> - 0.1
 - Initial version
--=20
2.23.0

