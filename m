Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2795EE44E
	for <lists+linux-block@lfdr.de>; Mon,  4 Nov 2019 16:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbfKDPzr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Nov 2019 10:55:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56399 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727989AbfKDPzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 10:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572882946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TX3MENt9H948tvZRMkm6vUw7B2bDTuG4mimG9EWlwJE=;
        b=VZZBwZDCSFT2dw9FtovBeVcxGynJ3NFhKP7cNPOrIKPMSSiIgT5yA8O9OK7IHflBHEw6BK
        gJ5mca6Mw1t0C/CLnzz2oemoWHZOiuAQjseMKmQ+F0kHTcyWi/e1NAvAQXl6ILZ4IHsG3a
        7wBKCFz5HbQxjIsyEPqgl5i/g77+xYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-iC_iGiXSOZiurNxGLnqCmw-1; Mon, 04 Nov 2019 10:55:44 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9C7347A;
        Mon,  4 Nov 2019 15:55:43 +0000 (UTC)
Received: from localhost (ovpn-116-49.ams2.redhat.com [10.36.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0CC15D6C8;
        Mon,  4 Nov 2019 15:55:41 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing v2 2/3] Makefile: add missing .pc dependency on .spec file
Date:   Mon,  4 Nov 2019 16:55:23 +0100
Message-Id: <20191104155524.58422-3-stefanha@redhat.com>
In-Reply-To: <20191104155524.58422-1-stefanha@redhat.com>
References: <20191104155524.58422-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: iC_iGiXSOZiurNxGLnqCmw-1
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

