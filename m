Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB08387704
	for <lists+linux-block@lfdr.de>; Tue, 18 May 2021 13:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242558AbhERLBi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 May 2021 07:01:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:47286 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239147AbhERLBh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 May 2021 07:01:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2134AF19;
        Tue, 18 May 2021 11:00:17 +0000 (UTC)
From:   colyli@suse.de
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Coly Li <colyli@suse.de>,
        Diego Ercolani <diego.ercolani@gmail.com>,
        Jan Szubiak <jan.szubiak@linuxpolska.pl>,
        Marco Rebhan <me@dblsaiko.net>,
        Matthias Ferdinand <bcache@mfedv.net>,
        Thorsten Knabe <linux@thorsten-knabe.de>,
        Victor Westerhuis <victor@westerhu.is>,
        Vojtech Pavlik <vojtech@suse.cz>, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v3] bcache: avoid oversized read request in cache missing code path
Date:   Tue, 18 May 2021 19:00:09 +0800
Message-Id: <20210518110009.11413-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Coly Li <colyli@suse.de>

In the cache missing code path of cached device, if a proper location
from the internal B+ tree is matched for a cache miss range, function
cached_dev_cache_miss() will be called in cache_lookup_fn() in the
following code block,
[code block 1]
  526         unsigned int sectors = KEY_INODE(k) == s->iop.inode
  527                 ? min_t(uint64_t, INT_MAX,
  528                         KEY_START(k) - bio->bi_iter.bi_sector)
  529                 : INT_MAX;
  530         int ret = s->d->cache_miss(b, s, bio, sectors);

Here s->d->cache_miss() is the call backfunction pointer initialized as
cached_dev_cache_miss(), the last parameter 'sectors' is an important
hint to calculate the size of read request to backing device of the
missing cache data.

Current calculation in above code block may generate oversized value of
'sectors', which consequently may trigger 2 different potential kernel
panics by BUG() or BUG_ON() as listed below,

1) BUG_ON() inside bch_btree_insert_key(),
[code block 2]
   886         BUG_ON(b->ops->is_extents && !KEY_SIZE(k));
2) BUG() inside biovec_slab(),
[code block 3]
   51         default:
   52                 BUG();
   53                 return NULL;

All the above panics are original from cached_dev_cache_miss() by the
oversized parameter 'sectors'.

Inside cached_dev_cache_miss(), parameter 'sectors' is used to calculate
the size of data read from backing device for the cache missing. This
size is stored in s->insert_bio_sectors by the following lines of code,
[code block 4]
  909    s->insert_bio_sectors = min(sectors, bio_sectors(bio) + reada);

Then the actual key inserting to the internal B+ tree is generated and
stored in s->iop.replace_key by the following lines of code,
[code block 5]
  911   s->iop.replace_key = KEY(s->iop.inode,
  912                    bio->bi_iter.bi_sector + s->insert_bio_sectors,
  913                    s->insert_bio_sectors);
The oversized parameter 'sectors' may trigger panic 1) by BUG_ON() from
the above code block.

And the bio sending to backing device for the missing data is allocated
with hint from s->insert_bio_sectors by the following lines of code,
[code block 6]
  926    cache_bio = bio_alloc_bioset(GFP_NOWAIT,
  927                 DIV_ROUND_UP(s->insert_bio_sectors, PAGE_SECTORS),
  928                 &dc->disk.bio_split);
The oversized parameter 'sectors' may trigger panic 2) by BUG() from the
agove code block.

Now let me explain how the panics happen with the oversized 'sectors'.
In code block 5, replace_key is generated by macro KEY(). From the
definition of macro KEY(),
[code block 7]
  71 #define KEY(inode, offset, size)                                  \
  72 ((struct bkey) {                                                  \
  73      .high = (1ULL << 63) | ((__u64) (size) << 20) | (inode),     \
  74      .low = (offset)                                              \
  75 })

Here 'size' is 16bits width embedded in 64bits member 'high' of struct
bkey. But in code block 1, if "KEY_START(k) - bio->bi_iter.bi_sector" is
very probably to be larger than (1<<16) - 1, which makes the bkey size
calculation in code block 5 is overflowed. In one bug report the value
of parameter 'sectors' is 131072 (= 1 << 17), the overflowed 'sectors'
results the overflowed s->insert_bio_sectors in code block 4, then makes
size field of s->iop.replace_key to be 0 in code block 5. Then the 0-
sized s->iop.replace_key is inserted into the internal B+ tree as cache
missing check key (a special key to detect and avoid a racing between
normal write request and cache missing read request) as,
[code block 8]
  915   ret = bch_btree_insert_check_key(b, &s->op, &s->iop.replace_key);

Then the 0-sized s->iop.replace_key as 3rd parameter triggers the bkey
size check BUG_ON() in code block 2, and causes the kernel panic 1).

Another kernel panic is from code block 6, is from the oversized value
s->insert_bio_sectors resulted by the oversized 'sectors'. From a bug
report the result of "DIV_ROUND_UP(s->insert_bio_sectors, PAGE_SECTORS)"
from code block 6 can be 344, 282, 946, 342 and many other values which
larther than BIO_MAX_VECS (a.k.a 256). When calling bio_alloc_bioset()
with such larger-than-256 value as the 2nd parameter, this value will
eventually be sent to biovec_slab() as parameter 'nr_vecs' in following
code path,
   bio_alloc_bioset() ==> bvec_alloc() ==> biovec_slab()

Because parameter 'nr_vecs' is larger-than-256 value, the panic by BUG()
in code block 3 is triggered inside biovec_slab().

From the above analysis, we know that the 4th parameter 'sector' sent
into cached_dev_cache_miss() may cause overflow in code block 5 and 6,
and finally cause kernel panic in code block 2 and 3.

Therefore inside cached_dev_cache_miss() before parameter 'sector' is
used to calculate s->insert_bio_sectors in code block4, there should be
an value overflow check on 'sector' and fix its value when necessary.
- To avoid overflow in code block 5, the maximum 'sectors' value should
  be equal or less than (1 << KEY_SIZE_BITS) - 1.
- To avoid overflow in code block 6, the maximum 'sectors' value should
  be euqal or less than BIO_MAX_VECS * PAGE_SECTORS.
Considering the kernel page size can be variable, a reasonable maximum
limitation of 'sectors' should be the smaller one of the values
"(1 << KEY_SIZE_BITS) - 1" and "BIO_MAX_VECS * PAGE_SECTORS".

In this patch, a local variable inside cached_dev_cache_miss() is added
as,
     max_miss_size =  min_t(uint32_t,
             (1 << KEY_SIZE_BITS) - 1, BIO_MAX_VECS * PAGE_SECTORS);
Then the following code check and fix parameter 'sectors' as,
     if (sectors > max_miss_size)
             sectors = max_miss_size;

Now inside cached_dev_cache_miss(), the calculated 'sectors' value sent
into code block 5 and 6 will not trigger neither of the above kernel
panics anymore.

Current problmatic code can be partially found since Linux v5.13-rc1,
therefore all maintained stable kernels should try to apply this fix.

Reported-by: Diego Ercolani <diego.ercolani@gmail.com>
Reported-by: Jan Szubiak <jan.szubiak@linuxpolska.pl>
Reported-by: Marco Rebhan <me@dblsaiko.net>
Reported-by: Matthias Ferdinand <bcache@mfedv.net>
Reported-by: Thorsten Knabe <linux@thorsten-knabe.de>
Reported-by: Victor Westerhuis <victor@westerhu.is>
Reported-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Coly Li <colyli@suse.de>
Cc: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
---
Changlog:
v3, fix typo in v2.
v2, fix the bypass bio size calculation in v1.
v1, the initial version

 drivers/md/bcache/request.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 29c231758293..ba1612b00b9f 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -883,6 +883,7 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 	unsigned int reada = 0;
 	struct cached_dev *dc = container_of(s->d, struct cached_dev, disk);
 	struct bio *miss, *cache_bio;
+	unsigned int max_miss_size;
 
 	s->cache_missed = 1;
 
@@ -899,6 +900,25 @@ static int cached_dev_cache_miss(struct btree *b, struct search *s,
 			      get_capacity(bio->bi_bdev->bd_disk) -
 			      bio_end_sector(bio));
 
+	/*
+	 * Make sure sectors won't exceed two size limitations,
+	 * - The bkey maximum size
+	 *   Size field in the bkey is 16 bits, the maximum permitted
+	 *   value is (1 << KEY_SIZE_BITS) - 1, in unit of sector.
+	 * - The bio io vecs maximum number
+	 *   BIO_MAX_VECS is the maximum permitted io vecs number of a
+	 *   bio, any larger value will result a BUG() complain in bio
+	 *   layer code. When maximum size of each io vector is a page,
+	 *   BIO_MAX_VECS * PAGE_SECTORS is the maximum permitted value
+	 *   in unit of sectors.
+	 * Then we are sure there is no overflow for key size of
+	 * s->iop.replace_key and bio io vecs number of cache_bio.
+	 */
+	max_miss_size =  min_t(uint32_t,
+		(1 << KEY_SIZE_BITS) - 1, BIO_MAX_VECS * PAGE_SECTORS);
+	if (sectors > max_miss_size)
+		sectors = max_miss_size;
+
 	s->insert_bio_sectors = min(sectors, bio_sectors(bio) + reada);
 
 	s->iop.replace_key = KEY(s->iop.inode,
-- 
2.26.2

