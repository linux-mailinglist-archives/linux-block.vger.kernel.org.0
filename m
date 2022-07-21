Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4820657CA71
	for <lists+linux-block@lfdr.de>; Thu, 21 Jul 2022 14:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiGUMMt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Jul 2022 08:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiGUMMs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 08:12:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE87863DA;
        Thu, 21 Jul 2022 05:12:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BC5FE33B1B;
        Thu, 21 Jul 2022 12:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658405565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdfYcaJz/rVvUgQh9mM5KOeqw/V+QhAPgnAIcoCYX0c=;
        b=grK/QwTTpUl774QEijPv3t0xV3eqLXdX72OLaDcFrjED1A3ZKnBgMf9zEbmfzhhROdtVhN
        Xtn2XwPMgy5HmI/+4UWMf0RFpXNyB+4B4azqVMPH67mu1TUaTqz6qPRm0UgMwRA4i+ftu3
        fR4UD8QGHbNzDEme3z3o9DvfcyDXXkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658405565;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZdfYcaJz/rVvUgQh9mM5KOeqw/V+QhAPgnAIcoCYX0c=;
        b=DXsX2HyX755VJx1whMyY2bJHep+3VR+PkignZ+VTyFpbudPRYpwuWRCy3++uVE1eEetSSc
        j6wtdCCBhqim32Bw==
Received: from localhost.localdomain (unknown [10.163.16.22])
        by relay2.suse.de (Postfix) with ESMTP id BF32C2C149;
        Thu, 21 Jul 2022 12:12:40 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-block@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-raid@vger.kernel.org,
        Coly Li <colyli@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        NeilBrown <neilb@suse.de>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Xiao Ni <xni@redhat.com>
Subject: [PATCH v6 6/7] badblocks: switch to the improved badblock handling code
Date:   Thu, 21 Jul 2022 20:11:51 +0800
Message-Id: <20220721121152.4180-7-colyli@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220721121152.4180-1-colyli@suse.de>
References: <20220721121152.4180-1-colyli@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch removes old code of badblocks_set(), badblocks_clear() and
badblocks_check(), and make them as wrappers to call _badblocks_set(),
_badblocks_clear() and _badblocks_check().

By this change now the badblock handing switch to the improved algorithm
in  _badblocks_set(), _badblocks_clear() and _badblocks_check().

This patch only contains the changes of old code deletion, new added
code for the improved algorithms are in previous patches.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Geliang Tang <geliang.tang@suse.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: NeilBrown <neilb@suse.de>
Cc: Vishal L Verma <vishal.l.verma@intel.com>
Cc: Xiao Ni <xni@redhat.com>
---
 block/badblocks.c | 308 +---------------------------------------------
 1 file changed, 3 insertions(+), 305 deletions(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index cbc79f056f74..2e6250641e3b 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -1396,74 +1396,7 @@ static int _badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 			sector_t *first_bad, int *bad_sectors)
 {
-	int hi;
-	int lo;
-	u64 *p = bb->page;
-	int rv;
-	sector_t target = s + sectors;
-	unsigned seq;
-
-	if (bb->shift > 0) {
-		/* round the start down, and the end up */
-		s >>= bb->shift;
-		target += (1<<bb->shift) - 1;
-		target >>= bb->shift;
-	}
-	/* 'target' is now the first block after the bad range */
-
-retry:
-	seq = read_seqbegin(&bb->lock);
-	lo = 0;
-	rv = 0;
-	hi = bb->count;
-
-	/* Binary search between lo and hi for 'target'
-	 * i.e. for the last range that starts before 'target'
-	 */
-	/* INVARIANT: ranges before 'lo' and at-or-after 'hi'
-	 * are known not to be the last range before target.
-	 * VARIANT: hi-lo is the number of possible
-	 * ranges, and decreases until it reaches 1
-	 */
-	while (hi - lo > 1) {
-		int mid = (lo + hi) / 2;
-		sector_t a = BB_OFFSET(p[mid]);
-
-		if (a < target)
-			/* This could still be the one, earlier ranges
-			 * could not.
-			 */
-			lo = mid;
-		else
-			/* This and later ranges are definitely out. */
-			hi = mid;
-	}
-	/* 'lo' might be the last that started before target, but 'hi' isn't */
-	if (hi > lo) {
-		/* need to check all range that end after 's' to see if
-		 * any are unacknowledged.
-		 */
-		while (lo >= 0 &&
-		       BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) {
-			if (BB_OFFSET(p[lo]) < target) {
-				/* starts before the end, and finishes after
-				 * the start, so they must overlap
-				 */
-				if (rv != -1 && BB_ACK(p[lo]))
-					rv = 1;
-				else
-					rv = -1;
-				*first_bad = BB_OFFSET(p[lo]);
-				*bad_sectors = BB_LEN(p[lo]);
-			}
-			lo--;
-		}
-	}
-
-	if (read_seqretry(&bb->lock, seq))
-		goto retry;
-
-	return rv;
+	return _badblocks_check(bb, s, sectors, first_bad, bad_sectors);
 }
 EXPORT_SYMBOL_GPL(badblocks_check);
 
@@ -1485,154 +1418,7 @@ EXPORT_SYMBOL_GPL(badblocks_check);
 int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 			int acknowledged)
 {
-	u64 *p;
-	int lo, hi;
-	int rv = 0;
-	unsigned long flags;
-
-	if (bb->shift < 0)
-		/* badblocks are disabled */
-		return 1;
-
-	if (bb->shift) {
-		/* round the start down, and the end up */
-		sector_t next = s + sectors;
-
-		s >>= bb->shift;
-		next += (1<<bb->shift) - 1;
-		next >>= bb->shift;
-		sectors = next - s;
-	}
-
-	write_seqlock_irqsave(&bb->lock, flags);
-
-	p = bb->page;
-	lo = 0;
-	hi = bb->count;
-	/* Find the last range that starts at-or-before 's' */
-	while (hi - lo > 1) {
-		int mid = (lo + hi) / 2;
-		sector_t a = BB_OFFSET(p[mid]);
-
-		if (a <= s)
-			lo = mid;
-		else
-			hi = mid;
-	}
-	if (hi > lo && BB_OFFSET(p[lo]) > s)
-		hi = lo;
-
-	if (hi > lo) {
-		/* we found a range that might merge with the start
-		 * of our new range
-		 */
-		sector_t a = BB_OFFSET(p[lo]);
-		sector_t e = a + BB_LEN(p[lo]);
-		int ack = BB_ACK(p[lo]);
-
-		if (e >= s) {
-			/* Yes, we can merge with a previous range */
-			if (s == a && s + sectors >= e)
-				/* new range covers old */
-				ack = acknowledged;
-			else
-				ack = ack && acknowledged;
-
-			if (e < s + sectors)
-				e = s + sectors;
-			if (e - a <= BB_MAX_LEN) {
-				p[lo] = BB_MAKE(a, e-a, ack);
-				s = e;
-			} else {
-				/* does not all fit in one range,
-				 * make p[lo] maximal
-				 */
-				if (BB_LEN(p[lo]) != BB_MAX_LEN)
-					p[lo] = BB_MAKE(a, BB_MAX_LEN, ack);
-				s = a + BB_MAX_LEN;
-			}
-			sectors = e - s;
-		}
-	}
-	if (sectors && hi < bb->count) {
-		/* 'hi' points to the first range that starts after 's'.
-		 * Maybe we can merge with the start of that range
-		 */
-		sector_t a = BB_OFFSET(p[hi]);
-		sector_t e = a + BB_LEN(p[hi]);
-		int ack = BB_ACK(p[hi]);
-
-		if (a <= s + sectors) {
-			/* merging is possible */
-			if (e <= s + sectors) {
-				/* full overlap */
-				e = s + sectors;
-				ack = acknowledged;
-			} else
-				ack = ack && acknowledged;
-
-			a = s;
-			if (e - a <= BB_MAX_LEN) {
-				p[hi] = BB_MAKE(a, e-a, ack);
-				s = e;
-			} else {
-				p[hi] = BB_MAKE(a, BB_MAX_LEN, ack);
-				s = a + BB_MAX_LEN;
-			}
-			sectors = e - s;
-			lo = hi;
-			hi++;
-		}
-	}
-	if (sectors == 0 && hi < bb->count) {
-		/* we might be able to combine lo and hi */
-		/* Note: 's' is at the end of 'lo' */
-		sector_t a = BB_OFFSET(p[hi]);
-		int lolen = BB_LEN(p[lo]);
-		int hilen = BB_LEN(p[hi]);
-		int newlen = lolen + hilen - (s - a);
-
-		if (s >= a && newlen < BB_MAX_LEN) {
-			/* yes, we can combine them */
-			int ack = BB_ACK(p[lo]) && BB_ACK(p[hi]);
-
-			p[lo] = BB_MAKE(BB_OFFSET(p[lo]), newlen, ack);
-			memmove(p + hi, p + hi + 1,
-				(bb->count - hi - 1) * 8);
-			bb->count--;
-		}
-	}
-	while (sectors) {
-		/* didn't merge (it all).
-		 * Need to add a range just before 'hi'
-		 */
-		if (bb->count >= MAX_BADBLOCKS) {
-			/* No room for more */
-			rv = 1;
-			break;
-		} else {
-			int this_sectors = sectors;
-
-			memmove(p + hi + 1, p + hi,
-				(bb->count - hi) * 8);
-			bb->count++;
-
-			if (this_sectors > BB_MAX_LEN)
-				this_sectors = BB_MAX_LEN;
-			p[hi] = BB_MAKE(s, this_sectors, acknowledged);
-			sectors -= this_sectors;
-			s += this_sectors;
-		}
-	}
-
-	bb->changed = 1;
-	if (!acknowledged)
-		bb->unacked_exist = 1;
-	else
-		badblocks_update_acked(bb);
-	write_sequnlock_irqrestore(&bb->lock, flags);
-
-	return rv;
+	return _badblocks_set(bb, s, sectors, acknowledged);
 }
 EXPORT_SYMBOL_GPL(badblocks_set);
 
@@ -1652,95 +1438,7 @@ EXPORT_SYMBOL_GPL(badblocks_set);
  */
 int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 {
-	u64 *p;
-	int lo, hi;
-	sector_t target = s + sectors;
-	int rv = 0;
-
-	if (bb->shift > 0) {
-		/* When clearing we round the start up and the end down.
-		 * This should not matter as the shift should align with
-		 * the block size and no rounding should ever be needed.
-		 * However it is better the think a block is bad when it
-		 * isn't than to think a block is not bad when it is.
-		 */
-		s += (1<<bb->shift) - 1;
-		s >>= bb->shift;
-		target >>= bb->shift;
-	}
-
-	write_seqlock_irq(&bb->lock);
-
-	p = bb->page;
-	lo = 0;
-	hi = bb->count;
-	/* Find the last range that starts before 'target' */
-	while (hi - lo > 1) {
-		int mid = (lo + hi) / 2;
-		sector_t a = BB_OFFSET(p[mid]);
-
-		if (a < target)
-			lo = mid;
-		else
-			hi = mid;
-	}
-	if (hi > lo) {
-		/* p[lo] is the last range that could overlap the
-		 * current range.  Earlier ranges could also overlap,
-		 * but only this one can overlap the end of the range.
-		 */
-		if ((BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > target) &&
-		    (BB_OFFSET(p[lo]) < target)) {
-			/* Partial overlap, leave the tail of this range */
-			int ack = BB_ACK(p[lo]);
-			sector_t a = BB_OFFSET(p[lo]);
-			sector_t end = a + BB_LEN(p[lo]);
-
-			if (a < s) {
-				/* we need to split this range */
-				if (bb->count >= MAX_BADBLOCKS) {
-					rv = -ENOSPC;
-					goto out;
-				}
-				memmove(p+lo+1, p+lo, (bb->count - lo) * 8);
-				bb->count++;
-				p[lo] = BB_MAKE(a, s-a, ack);
-				lo++;
-			}
-			p[lo] = BB_MAKE(target, end - target, ack);
-			/* there is no longer an overlap */
-			hi = lo;
-			lo--;
-		}
-		while (lo >= 0 &&
-		       (BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) &&
-		       (BB_OFFSET(p[lo]) < target)) {
-			/* This range does overlap */
-			if (BB_OFFSET(p[lo]) < s) {
-				/* Keep the early parts of this range. */
-				int ack = BB_ACK(p[lo]);
-				sector_t start = BB_OFFSET(p[lo]);
-
-				p[lo] = BB_MAKE(start, s - start, ack);
-				/* now low doesn't overlap, so.. */
-				break;
-			}
-			lo--;
-		}
-		/* 'lo' is strictly before, 'hi' is strictly after,
-		 * anything between needs to be discarded
-		 */
-		if (hi - lo > 1) {
-			memmove(p+lo+1, p+hi, (bb->count - hi) * 8);
-			bb->count -= (hi - lo - 1);
-		}
-	}
-
-	badblocks_update_acked(bb);
-	bb->changed = 1;
-out:
-	write_sequnlock_irq(&bb->lock);
-	return rv;
+	return _badblocks_clear(bb, s, sectors);
 }
 EXPORT_SYMBOL_GPL(badblocks_clear);
 
-- 
2.35.3

