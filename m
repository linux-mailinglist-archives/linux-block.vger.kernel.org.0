Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3328A433043
	for <lists+linux-block@lfdr.de>; Tue, 19 Oct 2021 09:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhJSH6z (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 Oct 2021 03:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbhJSH6y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 03:58:54 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1CDC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 00:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hgpwRxJYRFBwu9geJsz0/IYlJR2gT4n8ROrc/7hUPug=; b=LvOWaX9ti9135CmAfC2koUaXF1
        HOSUDOmEQQ/6BeqKPs+1+V7YLhdvCT1Ys9BNeMZ2mTC74WEHClHMeTpepMkCfmXLrwgqB3/NS9R47
        oP62LDqL3sA8nvTYUmojnE8nlMa6oqn+9hZNyKM1U9sXKyLXt3nW0W0AGEceFUBmuny87dtx9eVHH
        A+BgTgYqfsGrDF2f6ypdWUE2howL3cO4w0a/dCruQVq9C5uCJzoqBdlRHtZofa32HZry3IzXEgj9v
        p0Al0S/k/KQ5Nhgvij1OYuZkbxq1GltIGID6PX/tbkw7ey1kRJUoQBQYF2lcxrdz7lfyFPgM9un0C
        7puo/S0w==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcjzF-000THz-62; Tue, 19 Oct 2021 07:56:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Milan Broz <gmazyland@gmail.com>
Subject: [PATCH] block: remove support for cryptoloop and the xor transfer
Date:   Tue, 19 Oct 2021 09:56:39 +0200
Message-Id: <20211019075639.2333969-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Support for cyrptoloop has been officially marked broken and deprecated
in favor of dm-crypt (which supports the same broken algorithms if
needed) in Linux 2.6.4 (released in March 2004), and support for it has
been entirely removed from losetup in util-linux 2.23 (released in April
2013).  The XOR transfer has never been more than a toy to demonstrate
the transfer in the bad old times of crypto export restrictions.
Remove them as they have some nasty interactions with loop device life
times due to the iteration over all loop devices in
loop_unregister_transfer.

Suggested-by: Milan Broz <gmazyland@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/Kconfig      |  23 ---
 drivers/block/Makefile     |   1 -
 drivers/block/cryptoloop.c | 206 --------------------
 drivers/block/loop.c       | 376 +++----------------------------------
 drivers/block/loop.h       |  30 ---
 5 files changed, 26 insertions(+), 610 deletions(-)
 delete mode 100644 drivers/block/cryptoloop.c

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 9151e8ffba1cf..d97eaf6adb6dd 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -180,14 +180,6 @@ config BLK_DEV_LOOP
 	  bits of, say, a sound file). This is also safe if the file resides
 	  on a remote file server.
 
-	  There are several ways of encrypting disks. Some of these require
-	  kernel patches. The vanilla kernel offers the cryptoloop option
-	  and a Device Mapper target (which is superior, as it supports all
-	  file systems). If you want to use the cryptoloop, say Y to both
-	  LOOP and CRYPTOLOOP, and make sure you have a recent (version 2.12
-	  or later) version of util-linux. Additionally, be aware that
-	  the cryptoloop is not safe for storing journaled filesystems.
-
 	  Note that this loop device has nothing to do with the loopback
 	  device used for network connections from the machine to itself.
 
@@ -211,21 +203,6 @@ config BLK_DEV_LOOP_MIN_COUNT
 	  is used, it can be set to 0, since needed loop devices can be
 	  dynamically allocated with the /dev/loop-control interface.
 
-config BLK_DEV_CRYPTOLOOP
-	tristate "Cryptoloop Support (DEPRECATED)"
-	select CRYPTO
-	select CRYPTO_CBC
-	depends on BLK_DEV_LOOP
-	help
-	  Say Y here if you want to be able to use the ciphers that are 
-	  provided by the CryptoAPI as loop transformation. This might be
-	  used as hard disk encryption.
-
-	  WARNING: This device is not safe for journaled file systems like
-	  ext3 or Reiserfs. Please use the Device Mapper crypto module
-	  instead, which can be configured to be on-disk compatible with the
-	  cryptoloop device.  cryptoloop support will be removed in Linux 5.16.
-
 source "drivers/block/drbd/Kconfig"
 
 config BLK_DEV_NBD
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index bc68817ef4966..11a74f17c9ad7 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -24,7 +24,6 @@ obj-$(CONFIG_CDROM_PKTCDVD)	+= pktcdvd.o
 obj-$(CONFIG_SUNVDC)		+= sunvdc.o
 
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
-obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
 obj-$(CONFIG_VIRTIO_BLK)	+= virtio_blk.o
 
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
deleted file mode 100644
index f0a91faa43a89..0000000000000
--- a/drivers/block/cryptoloop.c
+++ /dev/null
@@ -1,206 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
-   Linux loop encryption enabling module
-
-   Copyright (C)  2002 Herbert Valerio Riedel <hvr@gnu.org>
-   Copyright (C)  2003 Fruhwirth Clemens <clemens@endorphin.org>
-
- */
-
-#include <linux/module.h>
-
-#include <crypto/skcipher.h>
-#include <linux/init.h>
-#include <linux/string.h>
-#include <linux/blkdev.h>
-#include <linux/scatterlist.h>
-#include <linux/uaccess.h>
-#include "loop.h"
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("loop blockdevice transferfunction adaptor / CryptoAPI");
-MODULE_AUTHOR("Herbert Valerio Riedel <hvr@gnu.org>");
-
-#define LOOP_IV_SECTOR_BITS 9
-#define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)
-
-static int
-cryptoloop_init(struct loop_device *lo, const struct loop_info64 *info)
-{
-	int err = -EINVAL;
-	int cipher_len;
-	int mode_len;
-	char cms[LO_NAME_SIZE];			/* cipher-mode string */
-	char *mode;
-	char *cmsp = cms;			/* c-m string pointer */
-	struct crypto_sync_skcipher *tfm;
-
-	/* encryption breaks for non sector aligned offsets */
-
-	if (info->lo_offset % LOOP_IV_SECTOR_SIZE)
-		goto out;
-
-	strncpy(cms, info->lo_crypt_name, LO_NAME_SIZE);
-	cms[LO_NAME_SIZE - 1] = 0;
-
-	cipher_len = strcspn(cmsp, "-");
-
-	mode = cmsp + cipher_len;
-	mode_len = 0;
-	if (*mode) {
-		mode++;
-		mode_len = strcspn(mode, "-");
-	}
-
-	if (!mode_len) {
-		mode = "cbc";
-		mode_len = 3;
-	}
-
-	if (cipher_len + mode_len + 3 > LO_NAME_SIZE)
-		return -EINVAL;
-
-	memmove(cms, mode, mode_len);
-	cmsp = cms + mode_len;
-	*cmsp++ = '(';
-	memcpy(cmsp, info->lo_crypt_name, cipher_len);
-	cmsp += cipher_len;
-	*cmsp++ = ')';
-	*cmsp = 0;
-
-	tfm = crypto_alloc_sync_skcipher(cms, 0, 0);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	err = crypto_sync_skcipher_setkey(tfm, info->lo_encrypt_key,
-					  info->lo_encrypt_key_size);
-
-	if (err != 0)
-		goto out_free_tfm;
-
-	lo->key_data = tfm;
-	return 0;
-
- out_free_tfm:
-	crypto_free_sync_skcipher(tfm);
-
- out:
-	return err;
-}
-
-
-typedef int (*encdec_cbc_t)(struct skcipher_request *req);
-
-static int
-cryptoloop_transfer(struct loop_device *lo, int cmd,
-		    struct page *raw_page, unsigned raw_off,
-		    struct page *loop_page, unsigned loop_off,
-		    int size, sector_t IV)
-{
-	struct crypto_sync_skcipher *tfm = lo->key_data;
-	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
-	struct scatterlist sg_out;
-	struct scatterlist sg_in;
-
-	encdec_cbc_t encdecfunc;
-	struct page *in_page, *out_page;
-	unsigned in_offs, out_offs;
-	int err;
-
-	skcipher_request_set_sync_tfm(req, tfm);
-	skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
-				      NULL, NULL);
-
-	sg_init_table(&sg_out, 1);
-	sg_init_table(&sg_in, 1);
-
-	if (cmd == READ) {
-		in_page = raw_page;
-		in_offs = raw_off;
-		out_page = loop_page;
-		out_offs = loop_off;
-		encdecfunc = crypto_skcipher_decrypt;
-	} else {
-		in_page = loop_page;
-		in_offs = loop_off;
-		out_page = raw_page;
-		out_offs = raw_off;
-		encdecfunc = crypto_skcipher_encrypt;
-	}
-
-	while (size > 0) {
-		const int sz = min(size, LOOP_IV_SECTOR_SIZE);
-		u32 iv[4] = { 0, };
-		iv[0] = cpu_to_le32(IV & 0xffffffff);
-
-		sg_set_page(&sg_in, in_page, sz, in_offs);
-		sg_set_page(&sg_out, out_page, sz, out_offs);
-
-		skcipher_request_set_crypt(req, &sg_in, &sg_out, sz, iv);
-		err = encdecfunc(req);
-		if (err)
-			goto out;
-
-		IV++;
-		size -= sz;
-		in_offs += sz;
-		out_offs += sz;
-	}
-
-	err = 0;
-
-out:
-	skcipher_request_zero(req);
-	return err;
-}
-
-static int
-cryptoloop_ioctl(struct loop_device *lo, int cmd, unsigned long arg)
-{
-	return -EINVAL;
-}
-
-static int
-cryptoloop_release(struct loop_device *lo)
-{
-	struct crypto_sync_skcipher *tfm = lo->key_data;
-	if (tfm != NULL) {
-		crypto_free_sync_skcipher(tfm);
-		lo->key_data = NULL;
-		return 0;
-	}
-	printk(KERN_ERR "cryptoloop_release(): tfm == NULL?\n");
-	return -EINVAL;
-}
-
-static struct loop_func_table cryptoloop_funcs = {
-	.number = LO_CRYPT_CRYPTOAPI,
-	.init = cryptoloop_init,
-	.ioctl = cryptoloop_ioctl,
-	.transfer = cryptoloop_transfer,
-	.release = cryptoloop_release,
-	.owner = THIS_MODULE
-};
-
-static int __init
-init_cryptoloop(void)
-{
-	int rc = loop_register_transfer(&cryptoloop_funcs);
-
-	if (rc)
-		printk(KERN_ERR "cryptoloop: loop_register_transfer failed\n");
-	else
-		pr_warn("the cryptoloop driver has been deprecated and will be removed in in Linux 5.16\n");
-	return rc;
-}
-
-static void __exit
-cleanup_cryptoloop(void)
-{
-	if (loop_unregister_transfer(LO_CRYPT_CRYPTOAPI))
-		printk(KERN_ERR
-			"cryptoloop: loop_unregister_transfer failed\n");
-}
-
-module_init(init_cryptoloop);
-module_exit(cleanup_cryptoloop);
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774e..72e78f4d01642 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -133,58 +133,6 @@ static void loop_global_unlock(struct loop_device *lo, bool global)
 static int max_part;
 static int part_shift;
 
-static int transfer_xor(struct loop_device *lo, int cmd,
-			struct page *raw_page, unsigned raw_off,
-			struct page *loop_page, unsigned loop_off,
-			int size, sector_t real_block)
-{
-	char *raw_buf = kmap_atomic(raw_page) + raw_off;
-	char *loop_buf = kmap_atomic(loop_page) + loop_off;
-	char *in, *out, *key;
-	int i, keysize;
-
-	if (cmd == READ) {
-		in = raw_buf;
-		out = loop_buf;
-	} else {
-		in = loop_buf;
-		out = raw_buf;
-	}
-
-	key = lo->lo_encrypt_key;
-	keysize = lo->lo_encrypt_key_size;
-	for (i = 0; i < size; i++)
-		*out++ = *in++ ^ key[(i & 511) % keysize];
-
-	kunmap_atomic(loop_buf);
-	kunmap_atomic(raw_buf);
-	cond_resched();
-	return 0;
-}
-
-static int xor_init(struct loop_device *lo, const struct loop_info64 *info)
-{
-	if (unlikely(info->lo_encrypt_key_size <= 0))
-		return -EINVAL;
-	return 0;
-}
-
-static struct loop_func_table none_funcs = {
-	.number = LO_CRYPT_NONE,
-}; 
-
-static struct loop_func_table xor_funcs = {
-	.number = LO_CRYPT_XOR,
-	.transfer = transfer_xor,
-	.init = xor_init
-}; 
-
-/* xfer_funcs[0] is special - its release function is never called */
-static struct loop_func_table *xfer_funcs[MAX_LO_CRYPT] = {
-	&none_funcs,
-	&xor_funcs
-};
-
 static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
 {
 	loff_t loopsize;
@@ -228,8 +176,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	/*
 	 * We support direct I/O only if lo_offset is aligned with the
 	 * logical I/O size of backing device, and the logical block
-	 * size of loop is bigger than the backing device's and the loop
-	 * needn't transform transfer.
+	 * size of loop is bigger than the backing device's.
 	 *
 	 * TODO: the above condition may be loosed in the future, and
 	 * direct I/O may be switched runtime at that time because most
@@ -238,8 +185,7 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	if (dio) {
 		if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
 				!(lo->lo_offset & dio_align) &&
-				mapping->a_ops->direct_IO &&
-				!lo->transfer)
+				mapping->a_ops->direct_IO)
 			use_dio = true;
 		else
 			use_dio = false;
@@ -299,24 +245,6 @@ static void loop_set_size(struct loop_device *lo, loff_t size)
 		kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 }
 
-static inline int
-lo_do_transfer(struct loop_device *lo, int cmd,
-	       struct page *rpage, unsigned roffs,
-	       struct page *lpage, unsigned loffs,
-	       int size, sector_t rblock)
-{
-	int ret;
-
-	ret = lo->transfer(lo, cmd, rpage, roffs, lpage, loffs, size, rblock);
-	if (likely(!ret))
-		return 0;
-
-	printk_ratelimited(KERN_ERR
-		"loop: Transfer error at byte offset %llu, length %i.\n",
-		(unsigned long long)rblock << 9, size);
-	return ret;
-}
-
 static int lo_write_bvec(struct file *file, struct bio_vec *bvec, loff_t *ppos)
 {
 	struct iov_iter i;
@@ -356,41 +284,6 @@ static int lo_write_simple(struct loop_device *lo, struct request *rq,
 	return ret;
 }
 
-/*
- * This is the slow, transforming version that needs to double buffer the
- * data as it cannot do the transformations in place without having direct
- * access to the destination pages of the backing file.
- */
-static int lo_write_transfer(struct loop_device *lo, struct request *rq,
-		loff_t pos)
-{
-	struct bio_vec bvec, b;
-	struct req_iterator iter;
-	struct page *page;
-	int ret = 0;
-
-	page = alloc_page(GFP_NOIO);
-	if (unlikely(!page))
-		return -ENOMEM;
-
-	rq_for_each_segment(bvec, rq, iter) {
-		ret = lo_do_transfer(lo, WRITE, page, 0, bvec.bv_page,
-			bvec.bv_offset, bvec.bv_len, pos >> 9);
-		if (unlikely(ret))
-			break;
-
-		b.bv_page = page;
-		b.bv_offset = 0;
-		b.bv_len = bvec.bv_len;
-		ret = lo_write_bvec(lo->lo_backing_file, &b, &pos);
-		if (ret < 0)
-			break;
-	}
-
-	__free_page(page);
-	return ret;
-}
-
 static int lo_read_simple(struct loop_device *lo, struct request *rq,
 		loff_t pos)
 {
@@ -420,64 +313,12 @@ static int lo_read_simple(struct loop_device *lo, struct request *rq,
 	return 0;
 }
 
-static int lo_read_transfer(struct loop_device *lo, struct request *rq,
-		loff_t pos)
-{
-	struct bio_vec bvec, b;
-	struct req_iterator iter;
-	struct iov_iter i;
-	struct page *page;
-	ssize_t len;
-	int ret = 0;
-
-	page = alloc_page(GFP_NOIO);
-	if (unlikely(!page))
-		return -ENOMEM;
-
-	rq_for_each_segment(bvec, rq, iter) {
-		loff_t offset = pos;
-
-		b.bv_page = page;
-		b.bv_offset = 0;
-		b.bv_len = bvec.bv_len;
-
-		iov_iter_bvec(&i, READ, &b, 1, b.bv_len);
-		len = vfs_iter_read(lo->lo_backing_file, &i, &pos, 0);
-		if (len < 0) {
-			ret = len;
-			goto out_free_page;
-		}
-
-		ret = lo_do_transfer(lo, READ, page, 0, bvec.bv_page,
-			bvec.bv_offset, len, offset >> 9);
-		if (ret)
-			goto out_free_page;
-
-		flush_dcache_page(bvec.bv_page);
-
-		if (len != bvec.bv_len) {
-			struct bio *bio;
-
-			__rq_for_each_bio(bio, rq)
-				zero_fill_bio(bio);
-			break;
-		}
-	}
-
-	ret = 0;
-out_free_page:
-	__free_page(page);
-	return ret;
-}
-
 static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 			int mode)
 {
 	/*
 	 * We use fallocate to manipulate the space mappings used by the image
-	 * a.k.a. discard/zerorange. However we do not support this if
-	 * encryption is enabled, because it may give an attacker useful
-	 * information.
+	 * a.k.a. discard/zerorange.
 	 */
 	struct file *file = lo->lo_backing_file;
 	struct request_queue *q = lo->lo_queue;
@@ -660,16 +501,12 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 	case REQ_OP_DISCARD:
 		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
 	case REQ_OP_WRITE:
-		if (lo->transfer)
-			return lo_write_transfer(lo, rq, pos);
-		else if (cmd->use_aio)
+		if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, WRITE);
 		else
 			return lo_write_simple(lo, rq, pos);
 	case REQ_OP_READ:
-		if (lo->transfer)
-			return lo_read_transfer(lo, rq, pos);
-		else if (cmd->use_aio)
+		if (cmd->use_aio)
 			return lo_rw_aio(lo, cmd, pos, READ);
 		else
 			return lo_read_simple(lo, rq, pos);
@@ -934,7 +771,7 @@ static void loop_config_discard(struct loop_device *lo)
 	 * not blkdev_issue_discard(). This maintains consistent behavior with
 	 * file-backed loop devices: discarded regions read back as zero.
 	 */
-	if (S_ISBLK(inode->i_mode) && !lo->lo_encrypt_key_size) {
+	if (S_ISBLK(inode->i_mode)) {
 		struct request_queue *backingq = bdev_get_queue(I_BDEV(inode));
 
 		max_discard_sectors = backingq->limits.max_write_zeroes_sectors;
@@ -943,11 +780,9 @@ static void loop_config_discard(struct loop_device *lo)
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
-	 * image a.k.a. discard. However we do not support discard if
-	 * encryption is enabled, because it may give an attacker
-	 * useful information.
+	 * image a.k.a. discard.
 	 */
-	} else if (!file->f_op->fallocate || lo->lo_encrypt_key_size) {
+	} else if (!file->f_op->fallocate) {
 		max_discard_sectors = 0;
 		granularity = 0;
 
@@ -1084,43 +919,6 @@ static void loop_update_rotational(struct loop_device *lo)
 		blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
 }
 
-static int
-loop_release_xfer(struct loop_device *lo)
-{
-	int err = 0;
-	struct loop_func_table *xfer = lo->lo_encryption;
-
-	if (xfer) {
-		if (xfer->release)
-			err = xfer->release(lo);
-		lo->transfer = NULL;
-		lo->lo_encryption = NULL;
-		module_put(xfer->owner);
-	}
-	return err;
-}
-
-static int
-loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
-	       const struct loop_info64 *i)
-{
-	int err = 0;
-
-	if (xfer) {
-		struct module *owner = xfer->owner;
-
-		if (!try_module_get(owner))
-			return -EINVAL;
-		if (xfer->init)
-			err = xfer->init(lo, i);
-		if (err)
-			module_put(owner);
-		else
-			lo->lo_encryption = xfer;
-	}
-	return err;
-}
-
 /**
  * loop_set_status_from_info - configure device from loop_info
  * @lo: struct loop_device to configure
@@ -1133,55 +931,27 @@ static int
 loop_set_status_from_info(struct loop_device *lo,
 			  const struct loop_info64 *info)
 {
-	int err;
-	struct loop_func_table *xfer;
-	kuid_t uid = current_uid();
-
 	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
 		return -EINVAL;
 
-	err = loop_release_xfer(lo);
-	if (err)
-		return err;
-
-	if (info->lo_encrypt_type) {
-		unsigned int type = info->lo_encrypt_type;
-
-		if (type >= MAX_LO_CRYPT)
-			return -EINVAL;
-		xfer = xfer_funcs[type];
-		if (xfer == NULL)
-			return -EINVAL;
-	} else
-		xfer = NULL;
-
-	err = loop_init_xfer(lo, xfer, info);
-	if (err)
-		return err;
+	switch (info->lo_encrypt_type) {
+	case LO_CRYPT_NONE:
+		break;
+	case LO_CRYPT_XOR:
+		pr_warn("support for the xor transformation has been removed.\n");
+		return -EINVAL;
+	case LO_CRYPT_CRYPTOAPI:
+		pr_warn("support for cryptoloop has been removed.  Use dm-crypt instead.\n");
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
 
 	lo->lo_offset = info->lo_offset;
 	lo->lo_sizelimit = info->lo_sizelimit;
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
-	memcpy(lo->lo_crypt_name, info->lo_crypt_name, LO_NAME_SIZE);
 	lo->lo_file_name[LO_NAME_SIZE-1] = 0;
-	lo->lo_crypt_name[LO_NAME_SIZE-1] = 0;
-
-	if (!xfer)
-		xfer = &none_funcs;
-	lo->transfer = xfer->transfer;
-	lo->ioctl = xfer->ioctl;
-
 	lo->lo_flags = info->lo_flags;
-
-	lo->lo_encrypt_key_size = info->lo_encrypt_key_size;
-	lo->lo_init[0] = info->lo_init[0];
-	lo->lo_init[1] = info->lo_init[1];
-	if (info->lo_encrypt_key_size) {
-		memcpy(lo->lo_encrypt_key, info->lo_encrypt_key,
-		       info->lo_encrypt_key_size);
-		lo->lo_key_owner = uid;
-	}
-
 	return 0;
 }
 
@@ -1381,16 +1151,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	lo->lo_backing_file = NULL;
 	spin_unlock_irq(&lo->lo_lock);
 
-	loop_release_xfer(lo);
-	lo->transfer = NULL;
-	lo->ioctl = NULL;
 	lo->lo_device = NULL;
-	lo->lo_encryption = NULL;
 	lo->lo_offset = 0;
 	lo->lo_sizelimit = 0;
-	lo->lo_encrypt_key_size = 0;
-	memset(lo->lo_encrypt_key, 0, LO_KEY_SIZE);
-	memset(lo->lo_crypt_name, 0, LO_NAME_SIZE);
 	memset(lo->lo_file_name, 0, LO_NAME_SIZE);
 	blk_queue_logical_block_size(lo->lo_queue, 512);
 	blk_queue_physical_block_size(lo->lo_queue, 512);
@@ -1498,7 +1261,6 @@ static int
 loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 {
 	int err;
-	kuid_t uid = current_uid();
 	int prev_lo_flags;
 	bool partscan = false;
 	bool size_changed = false;
@@ -1506,12 +1268,6 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	err = mutex_lock_killable(&lo->lo_mutex);
 	if (err)
 		return err;
-	if (lo->lo_encrypt_key_size &&
-	    !uid_eq(lo->lo_key_owner, uid) &&
-	    !capable(CAP_SYS_ADMIN)) {
-		err = -EPERM;
-		goto out_unlock;
-	}
 	if (lo->lo_state != Lo_bound) {
 		err = -ENXIO;
 		goto out_unlock;
@@ -1597,14 +1353,6 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	info->lo_sizelimit = lo->lo_sizelimit;
 	info->lo_flags = lo->lo_flags;
 	memcpy(info->lo_file_name, lo->lo_file_name, LO_NAME_SIZE);
-	memcpy(info->lo_crypt_name, lo->lo_crypt_name, LO_NAME_SIZE);
-	info->lo_encrypt_type =
-		lo->lo_encryption ? lo->lo_encryption->number : 0;
-	if (lo->lo_encrypt_key_size && capable(CAP_SYS_ADMIN)) {
-		info->lo_encrypt_key_size = lo->lo_encrypt_key_size;
-		memcpy(info->lo_encrypt_key, lo->lo_encrypt_key,
-		       lo->lo_encrypt_key_size);
-	}
 
 	/* Drop lo_mutex while we call into the filesystem. */
 	path = lo->lo_backing_file->f_path;
@@ -1630,16 +1378,8 @@ loop_info64_from_old(const struct loop_info *info, struct loop_info64 *info64)
 	info64->lo_rdevice = info->lo_rdevice;
 	info64->lo_offset = info->lo_offset;
 	info64->lo_sizelimit = 0;
-	info64->lo_encrypt_type = info->lo_encrypt_type;
-	info64->lo_encrypt_key_size = info->lo_encrypt_key_size;
 	info64->lo_flags = info->lo_flags;
-	info64->lo_init[0] = info->lo_init[0];
-	info64->lo_init[1] = info->lo_init[1];
-	if (info->lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
-		memcpy(info64->lo_crypt_name, info->lo_name, LO_NAME_SIZE);
-	else
-		memcpy(info64->lo_file_name, info->lo_name, LO_NAME_SIZE);
-	memcpy(info64->lo_encrypt_key, info->lo_encrypt_key, LO_KEY_SIZE);
+	memcpy(info64->lo_file_name, info->lo_name, LO_NAME_SIZE);
 }
 
 static int
@@ -1651,16 +1391,8 @@ loop_info64_to_old(const struct loop_info64 *info64, struct loop_info *info)
 	info->lo_inode = info64->lo_inode;
 	info->lo_rdevice = info64->lo_rdevice;
 	info->lo_offset = info64->lo_offset;
-	info->lo_encrypt_type = info64->lo_encrypt_type;
-	info->lo_encrypt_key_size = info64->lo_encrypt_key_size;
 	info->lo_flags = info64->lo_flags;
-	info->lo_init[0] = info64->lo_init[0];
-	info->lo_init[1] = info64->lo_init[1];
-	if (info->lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
-		memcpy(info->lo_name, info64->lo_crypt_name, LO_NAME_SIZE);
-	else
-		memcpy(info->lo_name, info64->lo_file_name, LO_NAME_SIZE);
-	memcpy(info->lo_encrypt_key, info64->lo_encrypt_key, LO_KEY_SIZE);
+	memcpy(info->lo_name, info64->lo_file_name, LO_NAME_SIZE);
 
 	/* error in case values were truncated */
 	if (info->lo_device != info64->lo_device ||
@@ -1809,7 +1541,7 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 		err = loop_set_block_size(lo, arg);
 		break;
 	default:
-		err = lo->ioctl ? lo->ioctl(lo, cmd, arg) : -EINVAL;
+		err = -EINVAL;
 	}
 	mutex_unlock(&lo->lo_mutex);
 	return err;
@@ -1885,7 +1617,6 @@ struct compat_loop_info {
 	compat_ulong_t	lo_inode;       /* ioctl r/o */
 	compat_dev_t	lo_rdevice;     /* ioctl r/o */
 	compat_int_t	lo_offset;
-	compat_int_t	lo_encrypt_type;
 	compat_int_t	lo_encrypt_key_size;    /* ioctl w/o */
 	compat_int_t	lo_flags;       /* ioctl r/o */
 	char		lo_name[LO_NAME_SIZE];
@@ -1914,16 +1645,8 @@ loop_info64_from_compat(const struct compat_loop_info __user *arg,
 	info64->lo_rdevice = info.lo_rdevice;
 	info64->lo_offset = info.lo_offset;
 	info64->lo_sizelimit = 0;
-	info64->lo_encrypt_type = info.lo_encrypt_type;
-	info64->lo_encrypt_key_size = info.lo_encrypt_key_size;
 	info64->lo_flags = info.lo_flags;
-	info64->lo_init[0] = info.lo_init[0];
-	info64->lo_init[1] = info.lo_init[1];
-	if (info.lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
-		memcpy(info64->lo_crypt_name, info.lo_name, LO_NAME_SIZE);
-	else
-		memcpy(info64->lo_file_name, info.lo_name, LO_NAME_SIZE);
-	memcpy(info64->lo_encrypt_key, info.lo_encrypt_key, LO_KEY_SIZE);
+	memcpy(info64->lo_file_name, info.lo_name, LO_NAME_SIZE);
 	return 0;
 }
 
@@ -1943,24 +1666,14 @@ loop_info64_to_compat(const struct loop_info64 *info64,
 	info.lo_inode = info64->lo_inode;
 	info.lo_rdevice = info64->lo_rdevice;
 	info.lo_offset = info64->lo_offset;
-	info.lo_encrypt_type = info64->lo_encrypt_type;
-	info.lo_encrypt_key_size = info64->lo_encrypt_key_size;
 	info.lo_flags = info64->lo_flags;
-	info.lo_init[0] = info64->lo_init[0];
-	info.lo_init[1] = info64->lo_init[1];
-	if (info.lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
-		memcpy(info.lo_name, info64->lo_crypt_name, LO_NAME_SIZE);
-	else
-		memcpy(info.lo_name, info64->lo_file_name, LO_NAME_SIZE);
-	memcpy(info.lo_encrypt_key, info64->lo_encrypt_key, LO_KEY_SIZE);
+	memcpy(info.lo_name, info64->lo_file_name, LO_NAME_SIZE);
 
 	/* error in case values were truncated */
 	if (info.lo_device != info64->lo_device ||
 	    info.lo_rdevice != info64->lo_rdevice ||
 	    info.lo_inode != info64->lo_inode ||
-	    info.lo_offset != info64->lo_offset ||
-	    info.lo_init[0] != info64->lo_init[0] ||
-	    info.lo_init[1] != info64->lo_init[1])
+	    info.lo_offset != info64->lo_offset)
 		return -EOVERFLOW;
 
 	if (copy_to_user(arg, &info, sizeof(info)))
@@ -2101,43 +1814,6 @@ MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 
-int loop_register_transfer(struct loop_func_table *funcs)
-{
-	unsigned int n = funcs->number;
-
-	if (n >= MAX_LO_CRYPT || xfer_funcs[n])
-		return -EINVAL;
-	xfer_funcs[n] = funcs;
-	return 0;
-}
-
-int loop_unregister_transfer(int number)
-{
-	unsigned int n = number;
-	struct loop_func_table *xfer;
-
-	if (n == 0 || n >= MAX_LO_CRYPT || (xfer = xfer_funcs[n]) == NULL)
-		return -EINVAL;
-	/*
-	 * This function is called from only cleanup_cryptoloop().
-	 * Given that each loop device that has a transfer enabled holds a
-	 * reference to the module implementing it we should never get here
-	 * with a transfer that is set (unless forced module unloading is
-	 * requested). Thus, check module's refcount and warn if this is
-	 * not a clean unloading.
-	 */
-#ifdef CONFIG_MODULE_UNLOAD
-	if (xfer->owner && module_refcount(xfer->owner) != -1)
-		pr_err("Danger! Unregistering an in use transfer function.\n");
-#endif
-
-	xfer_funcs[n] = NULL;
-	return 0;
-}
-
-EXPORT_SYMBOL(loop_register_transfer);
-EXPORT_SYMBOL(loop_unregister_transfer);
-
 static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 04c88dd6eabd6..082d4b6bfc6a6 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -32,23 +32,10 @@ struct loop_device {
 	loff_t		lo_offset;
 	loff_t		lo_sizelimit;
 	int		lo_flags;
-	int		(*transfer)(struct loop_device *, int cmd,
-				    struct page *raw_page, unsigned raw_off,
-				    struct page *loop_page, unsigned loop_off,
-				    int size, sector_t real_block);
 	char		lo_file_name[LO_NAME_SIZE];
-	char		lo_crypt_name[LO_NAME_SIZE];
-	char		lo_encrypt_key[LO_KEY_SIZE];
-	int		lo_encrypt_key_size;
-	struct loop_func_table *lo_encryption;
-	__u32           lo_init[2];
-	kuid_t		lo_key_owner;	/* Who set the key */
-	int		(*ioctl)(struct loop_device *, int cmd, 
-				 unsigned long arg); 
 
 	struct file *	lo_backing_file;
 	struct block_device *lo_device;
-	void		*key_data; 
 
 	gfp_t		old_gfp_mask;
 
@@ -82,21 +69,4 @@ struct loop_cmd {
 	struct cgroup_subsys_state *memcg_css;
 };
 
-/* Support for loadable transfer modules */
-struct loop_func_table {
-	int number;	/* filter type */ 
-	int (*transfer)(struct loop_device *lo, int cmd,
-			struct page *raw_page, unsigned raw_off,
-			struct page *loop_page, unsigned loop_off,
-			int size, sector_t real_block);
-	int (*init)(struct loop_device *, const struct loop_info64 *); 
-	/* release is called from loop_unregister_transfer or clr_fd */
-	int (*release)(struct loop_device *); 
-	int (*ioctl)(struct loop_device *, int cmd, unsigned long arg);
-	struct module *owner;
-}; 
-
-int loop_register_transfer(struct loop_func_table *funcs);
-int loop_unregister_transfer(int number); 
-
 #endif
-- 
2.30.2

