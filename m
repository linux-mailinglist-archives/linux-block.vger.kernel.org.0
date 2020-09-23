Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416F1274E6E
	for <lists+linux-block@lfdr.de>; Wed, 23 Sep 2020 03:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgIWBeF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Sep 2020 21:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26685 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbgIWBeF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 21:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600824844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCIodVP1nU0hjYc5t820i86oAfBR68B29fhjEz3ktVQ=;
        b=ehxkDBA/I9b7jnSocd+fwotO5nCrmtIeRXiqNRS0aB1cAe39TWNx1aIlNmsoBpfi13ws+M
        wkU9RPtFlNl0KIJ3s8alE9/gUpdkldl6SxnMKotZPqEALJ2mB9625ZyZ8TogNueH7KBrdy
        iyF1TX5/V3Nqxw8bxB3onsIIJXxUTxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-YWNVUMqLNaCYQT-ocB3irA-1; Tue, 22 Sep 2020 21:34:02 -0400
X-MC-Unique: YWNVUMqLNaCYQT-ocB3irA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1338D427C2;
        Wed, 23 Sep 2020 01:34:01 +0000 (UTC)
Received: from localhost (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1138319D6C;
        Wed, 23 Sep 2020 01:33:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V3 for 5.11 01/12] sbitmap: remove sbitmap_clear_bit_unlock
Date:   Wed, 23 Sep 2020 09:33:28 +0800
Message-Id: <20200923013339.1621784-2-ming.lei@redhat.com>
In-Reply-To: <20200923013339.1621784-1-ming.lei@redhat.com>
References: <20200923013339.1621784-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No one uses this helper any more, so kill it.

Cc: Omar Sandoval <osandov@fb.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/sbitmap.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index e40d019c3d9d..51edc05489cb 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -320,12 +320,6 @@ static inline void sbitmap_deferred_clear_bit(struct sbitmap *sb, unsigned int b
 	set_bit(SB_NR_TO_BIT(sb, bitnr), addr);
 }
 
-static inline void sbitmap_clear_bit_unlock(struct sbitmap *sb,
-					    unsigned int bitnr)
-{
-	clear_bit_unlock(SB_NR_TO_BIT(sb, bitnr), __sbitmap_word(sb, bitnr));
-}
-
 static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
 {
 	return test_bit(SB_NR_TO_BIT(sb, bitnr), __sbitmap_word(sb, bitnr));
-- 
2.25.2

