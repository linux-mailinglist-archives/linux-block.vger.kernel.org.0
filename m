Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C09DAC03C
	for <lists+linux-block@lfdr.de>; Fri,  6 Sep 2019 21:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392981AbfIFTN1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 6 Sep 2019 15:13:27 -0400
Received: from mtel-bg02.venev.name ([77.70.28.44]:46694 "EHLO
        mtel-bg02.venev.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392980AbfIFTN1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Sep 2019 15:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
         s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fi8ucjjg2QspVh9mhFRX7nSefEX0Ac9ST+dZJle9rpM=; b=TECFahY+MfgG31kttDIeRY4n6+
        ALIrgcThXoRbTuMYKY15M2+PKDodnjFqarmLeqHQlZGLFNwCM5igOmRXAbBBJZkfjPSJPPX6lc64l
        ow8sv1VPiYa59Mt0RPmElWkz4kVLoENWH5HIjccRSTnK/160RNdy7Fr+MPOwJn6fQiBZLY/F2UjD9
        iQAZO+DQ2owYgWqd72p/oXzvcKqSzGb3abjMXC2ysZZo5pCB/t2ogcdFIwdos8M/ZmQ/pdc9zFD4Z
        7YiZQ29dNc4gVtuSyKVVGPpzOLH73UCxzuGCPN9gZseGPmDqJSoC7eLwnmLV34DfJeK3jxhM8vq6G
        4QLjYdyqTFFE/+NYB4oXohMsPUalTesTeIBdKJKkF9TuSGukhNXhfoRJLYXhzifUb/MqkcdMIq08c
        rY7Ypetn/ujrZVyxn+chGnkIS60XQgvhCVW0oC1rlOZvfXUZC/zqAMtDcPy3WKPh5y29b7gZb3FIR
        SyEtI8luHpFaJMttfPfni8ABXv4KPBTaNWKPoV0FHeMgQSN2rGoUHApu96SCvI3IjUKJ5bR0Ta1qN
        +K3eopx/jknXIzYcGSo9ZuTMqXb7nCORQiFrdxMbI4/NiwUIMCt93fuIZesv4AqDv1S0SXQbySAnb
        2vC9YBFVjS1IynS8RdbMAf40HAX6Rmb1FTGgwqJPw=;
X-Check-Malware: ok
Received: from mtel-bg02.venev.name
        by mtel-bg02.venev.name with esmtpsa
        (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (envelope-from <hristo@venev.name>)
        id 1i6Jfd-00063G-0V; Fri, 06 Sep 2019 19:13:21 +0000
From:   Hristo Venev <hristo@venev.name>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Hristo Venev <hristo@venev.name>
Subject: [PATCH 1/2] liburing/test: There are now 4 reserved fields
Date:   Fri,  6 Sep 2019 20:12:51 +0100
Message-Id: <20190906191252.30332-1-hristo@venev.name>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <c0ab3b6a-3e30-8a91-512e-aed9218015a7@kernel.dk>
References: <c0ab3b6a-3e30-8a91-512e-aed9218015a7@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Hristo Venev <hristo@venev.name>
---
 test/io_uring_setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/io_uring_setup.c b/test/io_uring_setup.c
index 2dd3763..73b0398 100644
--- a/test/io_uring_setup.c
+++ b/test/io_uring_setup.c
@@ -67,8 +67,8 @@ dump_resv(struct io_uring_params *p)
 	if (!p)
 		return "";
 
-	sprintf(resvstr, "0x%.8x 0x%.8x 0x%.8x 0x%.8x 0x%.8x", p->resv[0],
-		p->resv[1], p->resv[2], p->resv[3], p->resv[4]);
+	sprintf(resvstr, "0x%.8x 0x%.8x 0x%.8x 0x%.8x", p->resv[0],
+		p->resv[1], p->resv[2], p->resv[3]);
 
 	return resvstr;
 }
@@ -118,7 +118,7 @@ main(int argc, char **argv)
 
 	/* resv array is non-zero */
 	memset(&p, 0, sizeof(p));
-	p.resv[0] = p.resv[1] = p.resv[2] = p.resv[3] = p.resv[4] = 1;
+	p.resv[0] = p.resv[1] = p.resv[2] = p.resv[3] = 1;
 	status |= try_io_uring_setup(1, &p, -1, EINVAL);
 
 	/* invalid flags */
-- 
2.21.0

