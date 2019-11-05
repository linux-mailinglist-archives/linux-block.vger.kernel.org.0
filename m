Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21D38EF681
	for <lists+linux-block@lfdr.de>; Tue,  5 Nov 2019 08:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbfKEHjk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Nov 2019 02:39:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55985 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387484AbfKEHjk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 5 Nov 2019 02:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572939579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TX3MENt9H948tvZRMkm6vUw7B2bDTuG4mimG9EWlwJE=;
        b=hWRNGCaFzgVsr8Wqb2rSNhOiVv8ylRXC09BfMG/Et7FTogN6QcAQjmEUY6xCK8Z0w2vUQG
        WCXjRvQvwvBq0UIOlBgEXU9d11zJkAENrG5sGGUmO/wGdx9u/ojzDQbx+VIzSuBlbLTvXo
        s7GWYsEZMgs8Ke30cgt0v6et0K0LFrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-Fr3JEYv5MQe6ivUuNPaRBw-1; Tue, 05 Nov 2019 02:39:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1B73477;
        Tue,  5 Nov 2019 07:39:36 +0000 (UTC)
Received: from localhost (ovpn-116-232.ams2.redhat.com [10.36.116.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E4A060BF4;
        Tue,  5 Nov 2019 07:39:35 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Julia Suvorova <jusual@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing v3 2/3] Makefile: add missing .pc dependency on .spec file
Date:   Tue,  5 Nov 2019 08:39:16 +0100
Message-Id: <20191105073917.62557-3-stefanha@redhat.com>
In-Reply-To: <20191105073917.62557-1-stefanha@redhat.com>
References: <20191105073917.62557-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Fr3JEYv5MQe6ivUuNPaRBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The version number is extracted from the .spec file.  Make .pc depend on
.spec so that VERSION variable substitutions are always up-to-date.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index cc457bb..8af1c3a 100644
--- a/Makefile
+++ b/Makefile
@@ -31,7 +31,7 @@ ifneq ($(MAKECMDGOALS),clean)
 include config-host.mak
 endif
=20
-%.pc: %.pc.in config-host.mak
+%.pc: %.pc.in config-host.mak $(SPECFILE)
 =09sed -e "s%@prefix@%$(prefix)%g" \
 =09    -e "s%@libdir@%$(libdir)%g" \
 =09    -e "s%@includedir@%$(includedir)%g" \
--=20
2.23.0

