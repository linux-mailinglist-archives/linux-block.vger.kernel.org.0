Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B065D5A66CE
	for <lists+linux-block@lfdr.de>; Tue, 30 Aug 2022 17:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiH3PCs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Aug 2022 11:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiH3PCp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 11:02:45 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7229C107C72
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 08:02:44 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r69so10931647pgr.2
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=/9Lf4xNKfoRKxAd7oWMZL7jTcEqykBX2zTkqq5PC3YY=;
        b=ntdGNdiDA4CdMhem1QeG5un1aUWH9Q66kUJ/agy5zRqTjsjI1WkRa4AylykIgBhbJY
         uGxTFw/nOgsovNHt2MbiOqVBP1fe2wEk7wRXcjlUFXdMgQJeKwgrQlK5Ca7PGfrz0rWw
         XlC9nA0jM/+G08wIN99qH6IClgj/hX8Sq5STcwe3uoE1Pd8FsGl5Tnq/6vV8VClqllrQ
         dxZPK3hqX2922YuYcy0qZHJUjAtQ4SeX3fI2VH1auaOSu3QwkJwkoMRFdUKL7XzJst63
         DuhCgv6xLoEL5+K7Db5/E1AdCp8G6EcGKIIfMwSQIBrpJZYuVTsCIIzt4j+oxkJpWzGN
         7wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=/9Lf4xNKfoRKxAd7oWMZL7jTcEqykBX2zTkqq5PC3YY=;
        b=bJr96gf7b5DiPLtR7QF9XOGL1tZz/UBQTlSNp6sSEuWSGyXRiU1a0+o4UgfbN3RJMC
         40t2sjs8keADTwOqtgwgfiqg8c8mTIEnDBl9S/VgfAuBe6mTwymakEyWncvQNtMJ03xf
         FsUMw8MJACpaJivrG6PkdXtcsQVp9cSVcWMjjCrGu9SPv3wFjrlB0P0Vwp/jWqiycVVH
         90j/ToubDknPjPSQ5va1oxHBc5UShLpo0MbVrc7aAvXNzM34cszae4JvXjEgDEVYW9n3
         YUIC5asMqYZ/CpQTBwyYO1MZSbxjoziUS8PcYMfTgwh07KYBvcibtqXqnfcTlZAIJaDL
         0m3w==
X-Gm-Message-State: ACgBeo2BwcAG6UQraurdtYgfi01BifSLaMyl9FZWYbXJcj5nFO4Ydnau
        NQCocqfg8b9u1C60+lQMvlus9QOLVDpIbg==
X-Google-Smtp-Source: AA6agR6RrEQN3L39IPT4T7TQJuPVI8cLby/OH6tkb/m5TUr6qs92Nx/lkrpi85Who+N/MhGUiiIAXg==
X-Received: by 2002:a63:1725:0:b0:42b:4300:358 with SMTP id x37-20020a631725000000b0042b43000358mr18605032pgl.536.1661871763782;
        Tue, 30 Aug 2022 08:02:43 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id u123-20020a626081000000b0053813de1fdasm5688398pfb.28.2022.08.30.08.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 08:02:42 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, acourbot@chromium.org, hch@infradead.org
Cc:     linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v2] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Date:   Wed, 31 Aug 2022 00:01:53 +0900
Message-Id: <20220830150153.12627-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a request fails at virtio_queue_rqs(), it is inserted to requeue_list
and passed to virtio_queue_rq(). Then blk_mq_start_request() can be called
again at virtio_queue_rq() and trigger WARN_ON_ONCE like below trace because
request state was already set to MQ_RQ_IN_FLIGHT in virtio_queue_rqs()
despite the failure.

[    1.890468] ------------[ cut here ]------------
[    1.890776] WARNING: CPU: 2 PID: 122 at block/blk-mq.c:1143
blk_mq_start_request+0x8a/0xe0
[    1.891045] Modules linked in:
[    1.891250] CPU: 2 PID: 122 Comm: journal-offline Not tainted 5.19.0+ #44
[    1.891504] Hardware name: ChromiumOS crosvm, BIOS 0
[    1.891739] RIP: 0010:blk_mq_start_request+0x8a/0xe0
[    1.891961] Code: 12 80 74 22 48 8b 4b 10 8b 89 64 01 00 00 8b 53
20 83 fa ff 75 08 ba 00 00 00 80 0b 53 24 c1 e1 10 09 d1 89 48 34 5b
41 5e c3 <0f> 0b eb b8 65 8b 05 2b 39 b6 7e 89 c0 48 0f a3 05 39 77 5b
01 0f
[    1.892443] RSP: 0018:ffffc900002777b0 EFLAGS: 00010202
[    1.892673] RAX: 0000000000000000 RBX: ffff888004bc0000 RCX: 0000000000000000
[    1.892952] RDX: 0000000000000000 RSI: ffff888003d7c200 RDI: ffff888004bc0000
[    1.893228] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff888004bc0100
[    1.893506] R10: ffffffffffffffff R11: ffffffff8185ca10 R12: ffff888004bc0000
[    1.893797] R13: ffffc90000277900 R14: ffff888004ab2340 R15: ffff888003d86e00
[    1.894060] FS:  00007ffa143a4640(0000) GS:ffff88807dd00000(0000)
knlGS:0000000000000000
[    1.894412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.894682] CR2: 00005648577d9088 CR3: 00000000053da004 CR4: 0000000000170ee0
[    1.894953] Call Trace:
[    1.895139]  <TASK>
[    1.895303]  virtblk_prep_rq+0x1e5/0x280
[    1.895509]  virtio_queue_rq+0x5c/0x310
[    1.895710]  ? virtqueue_add_sgs+0x95/0xb0
[    1.895905]  ? _raw_spin_unlock_irqrestore+0x16/0x30
[    1.896133]  ? virtio_queue_rqs+0x340/0x390
[    1.896453]  ? sbitmap_get+0xfa/0x220
[    1.896678]  __blk_mq_issue_directly+0x41/0x180
[    1.896906]  blk_mq_plug_issue_direct+0xd8/0x2c0
[    1.897115]  blk_mq_flush_plug_list+0x115/0x180
[    1.897342]  blk_add_rq_to_plug+0x51/0x130
[    1.897543]  blk_mq_submit_bio+0x3a1/0x570
[    1.897750]  submit_bio_noacct_nocheck+0x418/0x520
[    1.897985]  ? submit_bio_noacct+0x1e/0x260
[    1.897989]  ext4_bio_write_page+0x222/0x420
[    1.898000]  mpage_process_page_bufs+0x178/0x1c0
[    1.899451]  mpage_prepare_extent_to_map+0x2d2/0x440
[    1.899603]  ext4_writepages+0x495/0x1020
[    1.899733]  do_writepages+0xcb/0x220
[    1.899871]  ? __seccomp_filter+0x171/0x7e0
[    1.900006]  file_write_and_wait_range+0xcd/0xf0
[    1.900167]  ext4_sync_file+0x72/0x320
[    1.900308]  __x64_sys_fsync+0x66/0xa0
[    1.900449]  do_syscall_64+0x31/0x50
[    1.900595]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[    1.900747] RIP: 0033:0x7ffa16ec96ea
[    1.900883] Code: b8 4a 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3
48 83 ec 18 89 7c 24 0c e8 e3 02 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 43 03 f8 ff 8b
44 24
[    1.901302] RSP: 002b:00007ffa143a3ac0 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[    1.901499] RAX: ffffffffffffffda RBX: 0000560277ec6fe0 RCX: 00007ffa16ec96ea
[    1.901696] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000016
[    1.901884] RBP: 0000560277ec5910 R08: 0000000000000000 R09: 00007ffa143a4640
[    1.902082] R10: 00007ffa16e4d39e R11: 0000000000000293 R12: 00005602773f59e0
[    1.902459] R13: 0000000000000000 R14: 00007fffbfc007ff R15: 00007ffa13ba4000
[    1.902763]  </TASK>
[    1.902877] ---[ end trace 0000000000000000 ]---

To avoid calling blk_mq_start_request() twice, This patch moves the
execution of blk_mq_start_request() to the end of virtblk_prep_rq().
And instead of requeuing failed request to plug list in the error path of
virtblk_add_req_batch(), it uses blk_mq_requeue_request() to change failed
request state to MQ_RQ_IDLE. Then virtblk can safely handle the request
on the next trial.

Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
Reported-by: Alexandre Courbot <acourbot@chromium.org>
Tested-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
v1 -> v2
 - Call blk_mq_start_request() after virtblk_add_req() can break the timestamp.
   So move virtblk_add_req() before blk_mq_start_request().
 - Use blk_mq_requeue_request() instead of requeuing failed request to plug list
   if virtblk_add_req() fails within virtblk_add_req_batch(). 


 drivers/block/virtio_blk.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30255fcaf181..dd9a05174726 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -322,14 +322,14 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(status))
 		return status;
 
-	blk_mq_start_request(req);
-
 	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
 	if (unlikely(vbr->sg_table.nents < 0)) {
 		virtblk_cleanup_cmd(req);
 		return BLK_STS_RESOURCE;
 	}
 
+	blk_mq_start_request(req);
+
 	return BLK_STS_OK;
 }
 
@@ -391,8 +391,7 @@ static bool virtblk_prep_rq_batch(struct request *req)
 }
 
 static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
-					struct request **rqlist,
-					struct request **requeue_list)
+					struct request **rqlist)
 {
 	unsigned long flags;
 	int err;
@@ -408,7 +407,7 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
 		if (err) {
 			virtblk_unmap_data(req, vbr);
 			virtblk_cleanup_cmd(req);
-			rq_list_add(requeue_list, req);
+			blk_mq_requeue_request(req, true);
 		}
 	}
 
@@ -436,7 +435,7 @@ static void virtio_queue_rqs(struct request **rqlist)
 
 		if (!next || req->mq_hctx != next->mq_hctx) {
 			req->rq_next = NULL;
-			kick = virtblk_add_req_batch(vq, rqlist, &requeue_list);
+			kick = virtblk_add_req_batch(vq, rqlist);
 			if (kick)
 				virtqueue_notify(vq->vq);
 
-- 
2.26.3

