Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8E1C1C7E
	for <lists+linux-block@lfdr.de>; Fri,  1 May 2020 20:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgEASCe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 1 May 2020 14:02:34 -0400
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:54194 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729161AbgEASCe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 May 2020 14:02:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8770B182CF66B;
        Fri,  1 May 2020 18:02:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2828:2859:2904:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6119:7903:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:13439:13972:14181:14659:14721:21080:21433:21451:21627:21660:21740:21788:21987:21990:30003:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: dust01_1634cf6994e20
X-Filterd-Recvd-Size: 2968
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 May 2020 18:02:32 +0000 (UTC)
Message-ID: <c05138cb12f43498299d2b438173d082be2ebf17.camel@perches.com>
Subject: Re: [PATCH v3 0/4] floppy: suppress UBSAN warning in
 setup_rw_floppy()
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-block@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 May 2020 11:02:31 -0700
In-Reply-To: <20200501134416.72248-1-efremov@linux.com>
References: <20200501134416.72248-1-efremov@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2020-05-01 at 16:44 +0300, Denis Efremov wrote:
> These patches are based on Willy's cleanup patches
> https://lkml.org/lkml/2020/3/31/609.

Maybe add pr_fmt and clean up a few messages so
all the logging output is prefixed too.

---
 drivers/block/floppy.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c3daa64..b26bb1 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -145,6 +145,8 @@
  * Better audit of register_blkdev.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #undef  FLOPPY_SILENT_DCL_CLEAR
 
 #define REALLY_SLOW_IO
@@ -1724,7 +1726,7 @@ irqreturn_t floppy_interrupt(int irq, void *dev_id)
 	if (current_fdc >= N_FDC || fdc_state[current_fdc].address == -1) {
 		/* we don't even know which FDC is the culprit */
 		pr_info("DOR0=%x\n", fdc_state[0].dor);
-		pr_info("floppy interrupt on bizarre fdc %d\n", current_fdc);
+		pr_info("interrupt on bizarre fdc %d\n", current_fdc);
 		pr_info("handler=%ps\n", handler);
 		is_alive(__func__, "bizarre fdc");
 		return IRQ_NONE;
@@ -2276,7 +2278,7 @@ static void request_done(int uptodate)
 	reschedule_timeout(MAXTIMEOUT, msg);
 
 	if (!req) {
-		pr_info("floppy.c: no request in request_done\n");
+		pr_info("no request in request_done\n");
 		return;
 	}
 
@@ -4181,8 +4183,7 @@ static void floppy_rb0_cb(struct bio *bio)
 	int drive = cbdata->drive;
 
 	if (bio->bi_status) {
-		pr_info("floppy: error %d while reading block 0\n",
-			bio->bi_status);
+		pr_info("error %d while reading block 0\n", bio->bi_status);
 		set_bit(FD_OPEN_SHOULD_FAIL_BIT, &drive_state[drive].flags);
 	}
 	complete(&cbdata->complete);
@@ -4954,7 +4955,7 @@ static void floppy_release_irq_and_dma(void)
 #endif
 
 	if (delayed_work_pending(&fd_timeout))
-		pr_info("floppy timer still active:%s\n", timeout_message);
+		pr_info("timer still active:%s\n", timeout_message);
 	if (delayed_work_pending(&fd_timer))
 		pr_info("auxiliary floppy timer still active\n");
 	if (work_pending(&floppy_work))


