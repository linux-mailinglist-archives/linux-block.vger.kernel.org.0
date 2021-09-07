Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56AD402A8D
	for <lists+linux-block@lfdr.de>; Tue,  7 Sep 2021 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbhIGOQG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Sep 2021 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbhIGOQD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:16:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D755AC061796
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mdZm7oLuhx/Eo9EE+0u/5fuur/WO1BHinVHjxCBOhko=; b=KoS2NF1BSu2Kalf1yHGVo295SX
        XPkgR39jPbkpn7Sjjwl5mxsgI+ugGWC6eTMl9TkvjSliUh3iewnwphdXf/O1T/hIQ0K5UwG9UT1Za
        l7jGoWCJ8IDrRtQ18kBgYvlfAzfBRsIuIMaicexhH+GD2vt8I5lfFi5GpMhqtdb4WOvtA12o9jFye
        lNw86Gf4WPr907KUtWbVoa9cPxOTk99Q+345smvc40ybToLeeWvRViwqtCbov4hp64tkmPx+sVB3j
        Zi+xnbSX+ts5C75uZhYyCXGlDHDx/GDotuznZB+FHgMP8TvdcMg/mCZV1F8avS//Wnk4qkRiXIxye
        EUteJEZw==;
Received: from 089144201074.atnat0010.highway.a1.net ([89.144.201.74] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNbrA-007vqa-JP; Tue, 07 Sep 2021 14:13:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: split out operations on block special files
Date:   Tue,  7 Sep 2021 16:13:02 +0200
Message-Id: <20210907141303.1371844-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907141303.1371844-1-hch@lst.de>
References: <20210907141303.1371844-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a new block/fops.c for all the file and address_space operations
that provide the block special file support.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Makefile |   2 +-
 block/blk.h    |   2 +
 block/fops.c   | 640 +++++++++++++++++++++++++++++++++++++++++++++++++
 fs/block_dev.c | 637 ------------------------------------------------
 4 files changed, 643 insertions(+), 638 deletions(-)
 create mode 100644 block/fops.c

diff --git a/block/Makefile b/block/Makefile
index 1d0d466f2182a..a4d8d149670bf 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the kernel block layer
 #
 
-obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-sysfs.o \
+obj-$(CONFIG_BLOCK) := fops.o bio.o elevator.o blk-core.o blk-sysfs.o \
 			blk-flush.o blk-settings.o blk-ioc.o blk-map.o \
 			blk-exec.o blk-merge.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
diff --git a/block/blk.h b/block/blk.h
index 8c96b0c90c48d..7d2a0ba7ed21d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -373,4 +373,6 @@ static inline void bio_clear_hipri(struct bio *bio)
 	bio->bi_opf &= ~REQ_HIPRI;
 }
 
+extern const struct address_space_operations def_blk_aops;
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/fops.c b/block/fops.c
new file mode 100644
index 0000000000000..b64fc9d465aea
--- /dev/null
+++ b/block/fops.c
@@ -0,0 +1,640 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 1991, 1992  Linus Torvalds
+ * Copyright (C) 2001  Andrea Arcangeli <andrea@suse.de> SuSE
+ * Copyright (C) 2016 - 2020 Christoph Hellwig
+ */
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/mpage.h>
+#include <linux/uio.h>
+#include <linux/namei.h>
+#include <linux/task_io_accounting_ops.h>
+#include <linux/falloc.h>
+#include <linux/suspend.h>
+#include "blk.h"
+
+static struct inode *bdev_file_inode(struct file *file)
+{
+	return file->f_mapping->host;
+}
+
+static int blkdev_get_block(struct inode *inode, sector_t iblock,
+		struct buffer_head *bh, int create)
+{
+	bh->b_bdev = I_BDEV(inode);
+	bh->b_blocknr = iblock;
+	set_buffer_mapped(bh);
+	return 0;
+}
+
+static unsigned int dio_bio_write_op(struct kiocb *iocb)
+{
+	unsigned int op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
+
+	/* avoid the need for a I/O completion work item */
+	if (iocb->ki_flags & IOCB_DSYNC)
+		op |= REQ_FUA;
+	return op;
+}
+
+#define DIO_INLINE_BIO_VECS 4
+
+static void blkdev_bio_end_io_simple(struct bio *bio)
+{
+	struct task_struct *waiter = bio->bi_private;
+
+	WRITE_ONCE(bio->bi_private, NULL);
+	blk_wake_io_task(waiter);
+}
+
+static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
+		struct iov_iter *iter, unsigned int nr_pages)
+{
+	struct file *file = iocb->ki_filp;
+	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
+	loff_t pos = iocb->ki_pos;
+	bool should_dirty = false;
+	struct bio bio;
+	ssize_t ret;
+	blk_qc_t qc;
+
+	if ((pos | iov_iter_alignment(iter)) &
+	    (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+
+	if (nr_pages <= DIO_INLINE_BIO_VECS)
+		vecs = inline_vecs;
+	else {
+		vecs = kmalloc_array(nr_pages, sizeof(struct bio_vec),
+				     GFP_KERNEL);
+		if (!vecs)
+			return -ENOMEM;
+	}
+
+	bio_init(&bio, vecs, nr_pages);
+	bio_set_dev(&bio, bdev);
+	bio.bi_iter.bi_sector = pos >> 9;
+	bio.bi_write_hint = iocb->ki_hint;
+	bio.bi_private = current;
+	bio.bi_end_io = blkdev_bio_end_io_simple;
+	bio.bi_ioprio = iocb->ki_ioprio;
+
+	ret = bio_iov_iter_get_pages(&bio, iter);
+	if (unlikely(ret))
+		goto out;
+	ret = bio.bi_iter.bi_size;
+
+	if (iov_iter_rw(iter) == READ) {
+		bio.bi_opf = REQ_OP_READ;
+		if (iter_is_iovec(iter))
+			should_dirty = true;
+	} else {
+		bio.bi_opf = dio_bio_write_op(iocb);
+		task_io_account_write(ret);
+	}
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		bio.bi_opf |= REQ_NOWAIT;
+	if (iocb->ki_flags & IOCB_HIPRI)
+		bio_set_polled(&bio, iocb);
+
+	qc = submit_bio(&bio);
+	for (;;) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!READ_ONCE(bio.bi_private))
+			break;
+		if (!(iocb->ki_flags & IOCB_HIPRI) ||
+		    !blk_poll(bdev_get_queue(bdev), qc, true))
+			blk_io_schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+
+	bio_release_pages(&bio, should_dirty);
+	if (unlikely(bio.bi_status))
+		ret = blk_status_to_errno(bio.bi_status);
+
+out:
+	if (vecs != inline_vecs)
+		kfree(vecs);
+
+	bio_uninit(&bio);
+
+	return ret;
+}
+
+struct blkdev_dio {
+	union {
+		struct kiocb		*iocb;
+		struct task_struct	*waiter;
+	};
+	size_t			size;
+	atomic_t		ref;
+	bool			multi_bio : 1;
+	bool			should_dirty : 1;
+	bool			is_sync : 1;
+	struct bio		bio;
+};
+
+static struct bio_set blkdev_dio_pool;
+
+static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
+{
+	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);
+}
+
+static void blkdev_bio_end_io(struct bio *bio)
+{
+	struct blkdev_dio *dio = bio->bi_private;
+	bool should_dirty = dio->should_dirty;
+
+	if (bio->bi_status && !dio->bio.bi_status)
+		dio->bio.bi_status = bio->bi_status;
+
+	if (!dio->multi_bio || atomic_dec_and_test(&dio->ref)) {
+		if (!dio->is_sync) {
+			struct kiocb *iocb = dio->iocb;
+			ssize_t ret;
+
+			if (likely(!dio->bio.bi_status)) {
+				ret = dio->size;
+				iocb->ki_pos += ret;
+			} else {
+				ret = blk_status_to_errno(dio->bio.bi_status);
+			}
+
+			dio->iocb->ki_complete(iocb, ret, 0);
+			if (dio->multi_bio)
+				bio_put(&dio->bio);
+		} else {
+			struct task_struct *waiter = dio->waiter;
+
+			WRITE_ONCE(dio->waiter, NULL);
+			blk_wake_io_task(waiter);
+		}
+	}
+
+	if (should_dirty) {
+		bio_check_pages_dirty(bio);
+	} else {
+		bio_release_pages(bio, false);
+		bio_put(bio);
+	}
+}
+
+static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
+		unsigned int nr_pages)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = bdev_file_inode(file);
+	struct block_device *bdev = I_BDEV(inode);
+	struct blk_plug plug;
+	struct blkdev_dio *dio;
+	struct bio *bio;
+	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
+	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
+	loff_t pos = iocb->ki_pos;
+	blk_qc_t qc = BLK_QC_T_NONE;
+	int ret = 0;
+
+	if ((pos | iov_iter_alignment(iter)) &
+	    (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+
+	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
+
+	dio = container_of(bio, struct blkdev_dio, bio);
+	dio->is_sync = is_sync = is_sync_kiocb(iocb);
+	if (dio->is_sync) {
+		dio->waiter = current;
+		bio_get(bio);
+	} else {
+		dio->iocb = iocb;
+	}
+
+	dio->size = 0;
+	dio->multi_bio = false;
+	dio->should_dirty = is_read && iter_is_iovec(iter);
+
+	/*
+	 * Don't plug for HIPRI/polled IO, as those should go straight
+	 * to issue
+	 */
+	if (!is_poll)
+		blk_start_plug(&plug);
+
+	for (;;) {
+		bio_set_dev(bio, bdev);
+		bio->bi_iter.bi_sector = pos >> 9;
+		bio->bi_write_hint = iocb->ki_hint;
+		bio->bi_private = dio;
+		bio->bi_end_io = blkdev_bio_end_io;
+		bio->bi_ioprio = iocb->ki_ioprio;
+
+		ret = bio_iov_iter_get_pages(bio, iter);
+		if (unlikely(ret)) {
+			bio->bi_status = BLK_STS_IOERR;
+			bio_endio(bio);
+			break;
+		}
+
+		if (is_read) {
+			bio->bi_opf = REQ_OP_READ;
+			if (dio->should_dirty)
+				bio_set_pages_dirty(bio);
+		} else {
+			bio->bi_opf = dio_bio_write_op(iocb);
+			task_io_account_write(bio->bi_iter.bi_size);
+		}
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			bio->bi_opf |= REQ_NOWAIT;
+
+		dio->size += bio->bi_iter.bi_size;
+		pos += bio->bi_iter.bi_size;
+
+		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
+		if (!nr_pages) {
+			bool polled = false;
+
+			if (iocb->ki_flags & IOCB_HIPRI) {
+				bio_set_polled(bio, iocb);
+				polled = true;
+			}
+
+			qc = submit_bio(bio);
+
+			if (polled)
+				WRITE_ONCE(iocb->ki_cookie, qc);
+			break;
+		}
+
+		if (!dio->multi_bio) {
+			/*
+			 * AIO needs an extra reference to ensure the dio
+			 * structure which is embedded into the first bio
+			 * stays around.
+			 */
+			if (!is_sync)
+				bio_get(bio);
+			dio->multi_bio = true;
+			atomic_set(&dio->ref, 2);
+		} else {
+			atomic_inc(&dio->ref);
+		}
+
+		submit_bio(bio);
+		bio = bio_alloc(GFP_KERNEL, nr_pages);
+	}
+
+	if (!is_poll)
+		blk_finish_plug(&plug);
+
+	if (!is_sync)
+		return -EIOCBQUEUED;
+
+	for (;;) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!READ_ONCE(dio->waiter))
+			break;
+
+		if (!(iocb->ki_flags & IOCB_HIPRI) ||
+		    !blk_poll(bdev_get_queue(bdev), qc, true))
+			blk_io_schedule();
+	}
+	__set_current_state(TASK_RUNNING);
+
+	if (!ret)
+		ret = blk_status_to_errno(dio->bio.bi_status);
+	if (likely(!ret))
+		ret = dio->size;
+
+	bio_put(&dio->bio);
+	return ret;
+}
+
+static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
+{
+	unsigned int nr_pages;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
+	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_VECS)
+		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
+
+	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
+}
+
+static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
+{
+	return block_write_full_page(page, blkdev_get_block, wbc);
+}
+
+static int blkdev_readpage(struct file * file, struct page * page)
+{
+	return block_read_full_page(page, blkdev_get_block);
+}
+
+static void blkdev_readahead(struct readahead_control *rac)
+{
+	mpage_readahead(rac, blkdev_get_block);
+}
+
+static int blkdev_write_begin(struct file *file, struct address_space *mapping,
+		loff_t pos, unsigned len, unsigned flags, struct page **pagep,
+		void **fsdata)
+{
+	return block_write_begin(mapping, pos, len, flags, pagep,
+				 blkdev_get_block);
+}
+
+static int blkdev_write_end(struct file *file, struct address_space *mapping,
+		loff_t pos, unsigned len, unsigned copied, struct page *page,
+		void *fsdata)
+{
+	int ret;
+	ret = block_write_end(file, mapping, pos, len, copied, page, fsdata);
+
+	unlock_page(page);
+	put_page(page);
+
+	return ret;
+}
+
+static int blkdev_writepages(struct address_space *mapping,
+			     struct writeback_control *wbc)
+{
+	return generic_writepages(mapping, wbc);
+}
+
+const struct address_space_operations def_blk_aops = {
+	.set_page_dirty	= __set_page_dirty_buffers,
+	.readpage	= blkdev_readpage,
+	.readahead	= blkdev_readahead,
+	.writepage	= blkdev_writepage,
+	.write_begin	= blkdev_write_begin,
+	.write_end	= blkdev_write_end,
+	.writepages	= blkdev_writepages,
+	.direct_IO	= blkdev_direct_IO,
+	.migratepage	= buffer_migrate_page_norefs,
+	.is_dirty_writeback = buffer_check_dirty_writeback,
+};
+
+/*
+ * for a block special file file_inode(file)->i_size is zero
+ * so we compute the size by hand (just as in block_read/write above)
+ */
+static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *bd_inode = bdev_file_inode(file);
+	loff_t retval;
+
+	inode_lock(bd_inode);
+	retval = fixed_size_llseek(file, offset, whence, i_size_read(bd_inode));
+	inode_unlock(bd_inode);
+	return retval;
+}
+	
+static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
+		int datasync)
+{
+	struct inode *bd_inode = bdev_file_inode(filp);
+	struct block_device *bdev = I_BDEV(bd_inode);
+	int error;
+	
+	error = file_write_and_wait_range(filp, start, end);
+	if (error)
+		return error;
+
+	/*
+	 * There is no need to serialise calls to blkdev_issue_flush with
+	 * i_mutex and doing so causes performance issues with concurrent
+	 * O_SYNC writers to a block device.
+	 */
+	error = blkdev_issue_flush(bdev);
+	if (error == -EOPNOTSUPP)
+		error = 0;
+
+	return error;
+}
+
+static int blkdev_open(struct inode *inode, struct file *filp)
+{
+	struct block_device *bdev;
+
+	/*
+	 * Preserve backwards compatibility and allow large file access
+	 * even if userspace doesn't ask for it explicitly. Some mkfs
+	 * binary needs it. We might want to drop this workaround
+	 * during an unstable branch.
+	 */
+	filp->f_flags |= O_LARGEFILE;
+	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
+
+	if (filp->f_flags & O_NDELAY)
+		filp->f_mode |= FMODE_NDELAY;
+	if (filp->f_flags & O_EXCL)
+		filp->f_mode |= FMODE_EXCL;
+	if ((filp->f_flags & O_ACCMODE) == 3)
+		filp->f_mode |= FMODE_WRITE_IOCTL;
+
+	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode, filp);
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+	filp->f_mapping = bdev->bd_inode->i_mapping;
+	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
+	return 0;
+}
+
+static int blkdev_close(struct inode *inode, struct file *filp)
+{
+	struct block_device *bdev = I_BDEV(bdev_file_inode(filp));
+
+	blkdev_put(bdev, filp->f_mode);
+	return 0;
+}
+
+static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+{
+	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	fmode_t mode = file->f_mode;
+
+	/*
+	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
+	 * to updated it before every ioctl.
+	 */
+	if (file->f_flags & O_NDELAY)
+		mode |= FMODE_NDELAY;
+	else
+		mode &= ~FMODE_NDELAY;
+
+	return blkdev_ioctl(bdev, mode, cmd, arg);
+}
+
+/*
+ * Write data to the block device.  Only intended for the block device itself
+ * and the raw driver which basically is a fake block device.
+ *
+ * Does not take i_mutex for the write and thus is not for general purpose
+ * use.
+ */
+static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *bd_inode = bdev_file_inode(file);
+	loff_t size = i_size_read(bd_inode);
+	struct blk_plug plug;
+	size_t shorted = 0;
+	ssize_t ret;
+
+	if (bdev_read_only(I_BDEV(bd_inode)))
+		return -EPERM;
+
+	if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode->i_rdev))
+		return -ETXTBSY;
+
+	if (!iov_iter_count(from))
+		return 0;
+
+	if (iocb->ki_pos >= size)
+		return -ENOSPC;
+
+	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
+		return -EOPNOTSUPP;
+
+	size -= iocb->ki_pos;
+	if (iov_iter_count(from) > size) {
+		shorted = iov_iter_count(from) - size;
+		iov_iter_truncate(from, size);
+	}
+
+	blk_start_plug(&plug);
+	ret = __generic_file_write_iter(iocb, from);
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	iov_iter_reexpand(from, iov_iter_count(from) + shorted);
+	blk_finish_plug(&plug);
+	return ret;
+}
+
+static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *bd_inode = bdev_file_inode(file);
+	loff_t size = i_size_read(bd_inode);
+	loff_t pos = iocb->ki_pos;
+	size_t shorted = 0;
+	ssize_t ret;
+
+	if (pos >= size)
+		return 0;
+
+	size -= pos;
+	if (iov_iter_count(to) > size) {
+		shorted = iov_iter_count(to) - size;
+		iov_iter_truncate(to, size);
+	}
+
+	ret = generic_file_read_iter(iocb, to);
+	iov_iter_reexpand(to, iov_iter_count(to) + shorted);
+	return ret;
+}
+
+#define	BLKDEV_FALLOC_FL_SUPPORTED					\
+		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
+		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
+
+static long blkdev_fallocate(struct file *file, int mode, loff_t start,
+			     loff_t len)
+{
+	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
+	loff_t end = start + len - 1;
+	loff_t isize;
+	int error;
+
+	/* Fail if we don't recognize the flags. */
+	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
+		return -EOPNOTSUPP;
+
+	/* Don't go off the end of the device. */
+	isize = i_size_read(bdev->bd_inode);
+	if (start >= isize)
+		return -EINVAL;
+	if (end >= isize) {
+		if (mode & FALLOC_FL_KEEP_SIZE) {
+			len = isize - start;
+			end = start + len - 1;
+		} else
+			return -EINVAL;
+	}
+
+	/*
+	 * Don't allow IO that isn't aligned to logical block size.
+	 */
+	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
+		return -EINVAL;
+
+	/* Invalidate the page cache, including dirty pages. */
+	error = truncate_bdev_range(bdev, file->f_mode, start, end);
+	if (error)
+		return error;
+
+	switch (mode) {
+	case FALLOC_FL_ZERO_RANGE:
+	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
+		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
+					    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
+		break;
+	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
+		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
+					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
+		break;
+	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
+		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
+					     GFP_KERNEL, 0);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	if (error)
+		return error;
+
+	/*
+	 * Invalidate the page cache again; if someone wandered in and dirtied
+	 * a page, we just discard it - userspace has no way of knowing whether
+	 * the write happened before or after discard completing...
+	 */
+	return truncate_bdev_range(bdev, file->f_mode, start, end);
+}
+
+const struct file_operations def_blk_fops = {
+	.open		= blkdev_open,
+	.release	= blkdev_close,
+	.llseek		= blkdev_llseek,
+	.read_iter	= blkdev_read_iter,
+	.write_iter	= blkdev_write_iter,
+	.iopoll		= blkdev_iopoll,
+	.mmap		= generic_file_mmap,
+	.fsync		= blkdev_fsync,
+	.unlocked_ioctl	= block_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= compat_blkdev_ioctl,
+#endif
+	.splice_read	= generic_file_splice_read,
+	.splice_write	= iter_file_splice_write,
+	.fallocate	= blkdev_fallocate,
+};
+
+static __init int blkdev_init(void)
+{
+	return bioset_init(&blkdev_dio_pool, 4,
+				offsetof(struct blkdev_dio, bio),
+				BIOSET_NEED_BVECS|BIOSET_PERCPU_CACHE);
+}
+module_init(blkdev_init);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 45df6cbccf121..84c97e2760474 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -7,12 +7,10 @@
 
 #include <linux/init.h>
 #include <linux/mm.h>
-#include <linux/fcntl.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
 #include <linux/major.h>
 #include <linux/device_cgroup.h>
-#include <linux/highmem.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/module.h>
@@ -20,20 +18,14 @@
 #include <linux/magic.h>
 #include <linux/buffer_head.h>
 #include <linux/swap.h>
-#include <linux/pagevec.h>
 #include <linux/writeback.h>
-#include <linux/mpage.h>
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 #include <linux/uio.h>
 #include <linux/namei.h>
-#include <linux/log2.h>
 #include <linux/cleancache.h>
-#include <linux/task_io_accounting_ops.h>
-#include <linux/falloc.h>
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
-#include <linux/suspend.h>
 #include "internal.h"
 #include "../block/blk.h"
 
@@ -42,8 +34,6 @@ struct bdev_inode {
 	struct inode vfs_inode;
 };
 
-static const struct address_space_operations def_blk_aops;
-
 static inline struct bdev_inode *BDEV_I(struct inode *inode)
 {
 	return container_of(inode, struct bdev_inode, vfs_inode);
@@ -194,332 +184,6 @@ int sb_min_blocksize(struct super_block *sb, int size)
 
 EXPORT_SYMBOL(sb_min_blocksize);
 
-static int
-blkdev_get_block(struct inode *inode, sector_t iblock,
-		struct buffer_head *bh, int create)
-{
-	bh->b_bdev = I_BDEV(inode);
-	bh->b_blocknr = iblock;
-	set_buffer_mapped(bh);
-	return 0;
-}
-
-static struct inode *bdev_file_inode(struct file *file)
-{
-	return file->f_mapping->host;
-}
-
-static unsigned int dio_bio_write_op(struct kiocb *iocb)
-{
-	unsigned int op = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
-
-	/* avoid the need for a I/O completion work item */
-	if (iocb->ki_flags & IOCB_DSYNC)
-		op |= REQ_FUA;
-	return op;
-}
-
-#define DIO_INLINE_BIO_VECS 4
-
-static void blkdev_bio_end_io_simple(struct bio *bio)
-{
-	struct task_struct *waiter = bio->bi_private;
-
-	WRITE_ONCE(bio->bi_private, NULL);
-	blk_wake_io_task(waiter);
-}
-
-static ssize_t
-__blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
-		unsigned int nr_pages)
-{
-	struct file *file = iocb->ki_filp;
-	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
-	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
-	loff_t pos = iocb->ki_pos;
-	bool should_dirty = false;
-	struct bio bio;
-	ssize_t ret;
-	blk_qc_t qc;
-
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
-
-	if (nr_pages <= DIO_INLINE_BIO_VECS)
-		vecs = inline_vecs;
-	else {
-		vecs = kmalloc_array(nr_pages, sizeof(struct bio_vec),
-				     GFP_KERNEL);
-		if (!vecs)
-			return -ENOMEM;
-	}
-
-	bio_init(&bio, vecs, nr_pages);
-	bio_set_dev(&bio, bdev);
-	bio.bi_iter.bi_sector = pos >> 9;
-	bio.bi_write_hint = iocb->ki_hint;
-	bio.bi_private = current;
-	bio.bi_end_io = blkdev_bio_end_io_simple;
-	bio.bi_ioprio = iocb->ki_ioprio;
-
-	ret = bio_iov_iter_get_pages(&bio, iter);
-	if (unlikely(ret))
-		goto out;
-	ret = bio.bi_iter.bi_size;
-
-	if (iov_iter_rw(iter) == READ) {
-		bio.bi_opf = REQ_OP_READ;
-		if (iter_is_iovec(iter))
-			should_dirty = true;
-	} else {
-		bio.bi_opf = dio_bio_write_op(iocb);
-		task_io_account_write(ret);
-	}
-	if (iocb->ki_flags & IOCB_NOWAIT)
-		bio.bi_opf |= REQ_NOWAIT;
-	if (iocb->ki_flags & IOCB_HIPRI)
-		bio_set_polled(&bio, iocb);
-
-	qc = submit_bio(&bio);
-	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (!READ_ONCE(bio.bi_private))
-			break;
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
-			blk_io_schedule();
-	}
-	__set_current_state(TASK_RUNNING);
-
-	bio_release_pages(&bio, should_dirty);
-	if (unlikely(bio.bi_status))
-		ret = blk_status_to_errno(bio.bi_status);
-
-out:
-	if (vecs != inline_vecs)
-		kfree(vecs);
-
-	bio_uninit(&bio);
-
-	return ret;
-}
-
-struct blkdev_dio {
-	union {
-		struct kiocb		*iocb;
-		struct task_struct	*waiter;
-	};
-	size_t			size;
-	atomic_t		ref;
-	bool			multi_bio : 1;
-	bool			should_dirty : 1;
-	bool			is_sync : 1;
-	struct bio		bio;
-};
-
-static struct bio_set blkdev_dio_pool;
-
-static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
-{
-	struct block_device *bdev = I_BDEV(kiocb->ki_filp->f_mapping->host);
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);
-}
-
-static void blkdev_bio_end_io(struct bio *bio)
-{
-	struct blkdev_dio *dio = bio->bi_private;
-	bool should_dirty = dio->should_dirty;
-
-	if (bio->bi_status && !dio->bio.bi_status)
-		dio->bio.bi_status = bio->bi_status;
-
-	if (!dio->multi_bio || atomic_dec_and_test(&dio->ref)) {
-		if (!dio->is_sync) {
-			struct kiocb *iocb = dio->iocb;
-			ssize_t ret;
-
-			if (likely(!dio->bio.bi_status)) {
-				ret = dio->size;
-				iocb->ki_pos += ret;
-			} else {
-				ret = blk_status_to_errno(dio->bio.bi_status);
-			}
-
-			dio->iocb->ki_complete(iocb, ret, 0);
-			if (dio->multi_bio)
-				bio_put(&dio->bio);
-		} else {
-			struct task_struct *waiter = dio->waiter;
-
-			WRITE_ONCE(dio->waiter, NULL);
-			blk_wake_io_task(waiter);
-		}
-	}
-
-	if (should_dirty) {
-		bio_check_pages_dirty(bio);
-	} else {
-		bio_release_pages(bio, false);
-		bio_put(bio);
-	}
-}
-
-static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
-		unsigned int nr_pages)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *inode = bdev_file_inode(file);
-	struct block_device *bdev = I_BDEV(inode);
-	struct blk_plug plug;
-	struct blkdev_dio *dio;
-	struct bio *bio;
-	bool is_poll = (iocb->ki_flags & IOCB_HIPRI) != 0;
-	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
-	loff_t pos = iocb->ki_pos;
-	blk_qc_t qc = BLK_QC_T_NONE;
-	int ret = 0;
-
-	if ((pos | iov_iter_alignment(iter)) &
-	    (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
-
-	bio = bio_alloc_kiocb(iocb, nr_pages, &blkdev_dio_pool);
-
-	dio = container_of(bio, struct blkdev_dio, bio);
-	dio->is_sync = is_sync = is_sync_kiocb(iocb);
-	if (dio->is_sync) {
-		dio->waiter = current;
-		bio_get(bio);
-	} else {
-		dio->iocb = iocb;
-	}
-
-	dio->size = 0;
-	dio->multi_bio = false;
-	dio->should_dirty = is_read && iter_is_iovec(iter);
-
-	/*
-	 * Don't plug for HIPRI/polled IO, as those should go straight
-	 * to issue
-	 */
-	if (!is_poll)
-		blk_start_plug(&plug);
-
-	for (;;) {
-		bio_set_dev(bio, bdev);
-		bio->bi_iter.bi_sector = pos >> 9;
-		bio->bi_write_hint = iocb->ki_hint;
-		bio->bi_private = dio;
-		bio->bi_end_io = blkdev_bio_end_io;
-		bio->bi_ioprio = iocb->ki_ioprio;
-
-		ret = bio_iov_iter_get_pages(bio, iter);
-		if (unlikely(ret)) {
-			bio->bi_status = BLK_STS_IOERR;
-			bio_endio(bio);
-			break;
-		}
-
-		if (is_read) {
-			bio->bi_opf = REQ_OP_READ;
-			if (dio->should_dirty)
-				bio_set_pages_dirty(bio);
-		} else {
-			bio->bi_opf = dio_bio_write_op(iocb);
-			task_io_account_write(bio->bi_iter.bi_size);
-		}
-		if (iocb->ki_flags & IOCB_NOWAIT)
-			bio->bi_opf |= REQ_NOWAIT;
-
-		dio->size += bio->bi_iter.bi_size;
-		pos += bio->bi_iter.bi_size;
-
-		nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS);
-		if (!nr_pages) {
-			bool polled = false;
-
-			if (iocb->ki_flags & IOCB_HIPRI) {
-				bio_set_polled(bio, iocb);
-				polled = true;
-			}
-
-			qc = submit_bio(bio);
-
-			if (polled)
-				WRITE_ONCE(iocb->ki_cookie, qc);
-			break;
-		}
-
-		if (!dio->multi_bio) {
-			/*
-			 * AIO needs an extra reference to ensure the dio
-			 * structure which is embedded into the first bio
-			 * stays around.
-			 */
-			if (!is_sync)
-				bio_get(bio);
-			dio->multi_bio = true;
-			atomic_set(&dio->ref, 2);
-		} else {
-			atomic_inc(&dio->ref);
-		}
-
-		submit_bio(bio);
-		bio = bio_alloc(GFP_KERNEL, nr_pages);
-	}
-
-	if (!is_poll)
-		blk_finish_plug(&plug);
-
-	if (!is_sync)
-		return -EIOCBQUEUED;
-
-	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (!READ_ONCE(dio->waiter))
-			break;
-
-		if (!(iocb->ki_flags & IOCB_HIPRI) ||
-		    !blk_poll(bdev_get_queue(bdev), qc, true))
-			blk_io_schedule();
-	}
-	__set_current_state(TASK_RUNNING);
-
-	if (!ret)
-		ret = blk_status_to_errno(dio->bio.bi_status);
-	if (likely(!ret))
-		ret = dio->size;
-
-	bio_put(&dio->bio);
-	return ret;
-}
-
-static ssize_t
-blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	unsigned int nr_pages;
-
-	if (!iov_iter_count(iter))
-		return 0;
-
-	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
-	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_VECS)
-		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
-
-	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
-}
-
-static __init int blkdev_init(void)
-{
-	return bioset_init(&blkdev_dio_pool, 4,
-				offsetof(struct blkdev_dio, bio),
-				BIOSET_NEED_BVECS|BIOSET_PERCPU_CACHE);
-}
-module_init(blkdev_init);
-
 int __sync_blockdev(struct block_device *bdev, int wait)
 {
 	if (!bdev)
@@ -637,81 +301,6 @@ int thaw_bdev(struct block_device *bdev)
 }
 EXPORT_SYMBOL(thaw_bdev);
 
-static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
-{
-	return block_write_full_page(page, blkdev_get_block, wbc);
-}
-
-static int blkdev_readpage(struct file * file, struct page * page)
-{
-	return block_read_full_page(page, blkdev_get_block);
-}
-
-static void blkdev_readahead(struct readahead_control *rac)
-{
-	mpage_readahead(rac, blkdev_get_block);
-}
-
-static int blkdev_write_begin(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned flags,
-			struct page **pagep, void **fsdata)
-{
-	return block_write_begin(mapping, pos, len, flags, pagep,
-				 blkdev_get_block);
-}
-
-static int blkdev_write_end(struct file *file, struct address_space *mapping,
-			loff_t pos, unsigned len, unsigned copied,
-			struct page *page, void *fsdata)
-{
-	int ret;
-	ret = block_write_end(file, mapping, pos, len, copied, page, fsdata);
-
-	unlock_page(page);
-	put_page(page);
-
-	return ret;
-}
-
-/*
- * private llseek:
- * for a block special file file_inode(file)->i_size is zero
- * so we compute the size by hand (just as in block_read/write above)
- */
-static loff_t block_llseek(struct file *file, loff_t offset, int whence)
-{
-	struct inode *bd_inode = bdev_file_inode(file);
-	loff_t retval;
-
-	inode_lock(bd_inode);
-	retval = fixed_size_llseek(file, offset, whence, i_size_read(bd_inode));
-	inode_unlock(bd_inode);
-	return retval;
-}
-	
-static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
-		int datasync)
-{
-	struct inode *bd_inode = bdev_file_inode(filp);
-	struct block_device *bdev = I_BDEV(bd_inode);
-	int error;
-	
-	error = file_write_and_wait_range(filp, start, end);
-	if (error)
-		return error;
-
-	/*
-	 * There is no need to serialise calls to blkdev_issue_flush with
-	 * i_mutex and doing so causes performance issues with concurrent
-	 * O_SYNC writers to a block device.
-	 */
-	error = blkdev_issue_flush(bdev);
-	if (error == -EOPNOTSUPP)
-		error = 0;
-
-	return error;
-}
-
 /**
  * bdev_read_page() - Start reading a page from a block device
  * @bdev: The device to read the page from
@@ -1305,35 +894,6 @@ struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 }
 EXPORT_SYMBOL(blkdev_get_by_path);
 
-static int blkdev_open(struct inode * inode, struct file * filp)
-{
-	struct block_device *bdev;
-
-	/*
-	 * Preserve backwards compatibility and allow large file access
-	 * even if userspace doesn't ask for it explicitly. Some mkfs
-	 * binary needs it. We might want to drop this workaround
-	 * during an unstable branch.
-	 */
-	filp->f_flags |= O_LARGEFILE;
-
-	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
-
-	if (filp->f_flags & O_NDELAY)
-		filp->f_mode |= FMODE_NDELAY;
-	if (filp->f_flags & O_EXCL)
-		filp->f_mode |= FMODE_EXCL;
-	if ((filp->f_flags & O_ACCMODE) == 3)
-		filp->f_mode |= FMODE_WRITE_IOCTL;
-
-	bdev = blkdev_get_by_dev(inode->i_rdev, filp->f_mode, filp);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
-	filp->f_mapping = bdev->bd_inode->i_mapping;
-	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
-	return 0;
-}
-
 void blkdev_put(struct block_device *bdev, fmode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -1397,203 +957,6 @@ void blkdev_put(struct block_device *bdev, fmode_t mode)
 }
 EXPORT_SYMBOL(blkdev_put);
 
-static int blkdev_close(struct inode * inode, struct file * filp)
-{
-	struct block_device *bdev = I_BDEV(bdev_file_inode(filp));
-	blkdev_put(bdev, filp->f_mode);
-	return 0;
-}
-
-static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
-{
-	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
-	fmode_t mode = file->f_mode;
-
-	/*
-	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
-	 * to updated it before every ioctl.
-	 */
-	if (file->f_flags & O_NDELAY)
-		mode |= FMODE_NDELAY;
-	else
-		mode &= ~FMODE_NDELAY;
-
-	return blkdev_ioctl(bdev, mode, cmd, arg);
-}
-
-/*
- * Write data to the block device.  Only intended for the block device itself
- * and the raw driver which basically is a fake block device.
- *
- * Does not take i_mutex for the write and thus is not for general purpose
- * use.
- */
-static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *bd_inode = bdev_file_inode(file);
-	loff_t size = i_size_read(bd_inode);
-	struct blk_plug plug;
-	size_t shorted = 0;
-	ssize_t ret;
-
-	if (bdev_read_only(I_BDEV(bd_inode)))
-		return -EPERM;
-
-	if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode->i_rdev))
-		return -ETXTBSY;
-
-	if (!iov_iter_count(from))
-		return 0;
-
-	if (iocb->ki_pos >= size)
-		return -ENOSPC;
-
-	if ((iocb->ki_flags & (IOCB_NOWAIT | IOCB_DIRECT)) == IOCB_NOWAIT)
-		return -EOPNOTSUPP;
-
-	size -= iocb->ki_pos;
-	if (iov_iter_count(from) > size) {
-		shorted = iov_iter_count(from) - size;
-		iov_iter_truncate(from, size);
-	}
-
-	blk_start_plug(&plug);
-	ret = __generic_file_write_iter(iocb, from);
-	if (ret > 0)
-		ret = generic_write_sync(iocb, ret);
-	iov_iter_reexpand(from, iov_iter_count(from) + shorted);
-	blk_finish_plug(&plug);
-	return ret;
-}
-
-static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
-{
-	struct file *file = iocb->ki_filp;
-	struct inode *bd_inode = bdev_file_inode(file);
-	loff_t size = i_size_read(bd_inode);
-	loff_t pos = iocb->ki_pos;
-	size_t shorted = 0;
-	ssize_t ret;
-
-	if (pos >= size)
-		return 0;
-
-	size -= pos;
-	if (iov_iter_count(to) > size) {
-		shorted = iov_iter_count(to) - size;
-		iov_iter_truncate(to, size);
-	}
-
-	ret = generic_file_read_iter(iocb, to);
-	iov_iter_reexpand(to, iov_iter_count(to) + shorted);
-	return ret;
-}
-
-static int blkdev_writepages(struct address_space *mapping,
-			     struct writeback_control *wbc)
-{
-	return generic_writepages(mapping, wbc);
-}
-
-static const struct address_space_operations def_blk_aops = {
-	.set_page_dirty	= __set_page_dirty_buffers,
-	.readpage	= blkdev_readpage,
-	.readahead	= blkdev_readahead,
-	.writepage	= blkdev_writepage,
-	.write_begin	= blkdev_write_begin,
-	.write_end	= blkdev_write_end,
-	.writepages	= blkdev_writepages,
-	.direct_IO	= blkdev_direct_IO,
-	.migratepage	= buffer_migrate_page_norefs,
-	.is_dirty_writeback = buffer_check_dirty_writeback,
-};
-
-#define	BLKDEV_FALLOC_FL_SUPPORTED					\
-		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
-		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
-
-static long blkdev_fallocate(struct file *file, int mode, loff_t start,
-			     loff_t len)
-{
-	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
-	loff_t end = start + len - 1;
-	loff_t isize;
-	int error;
-
-	/* Fail if we don't recognize the flags. */
-	if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
-		return -EOPNOTSUPP;
-
-	/* Don't go off the end of the device. */
-	isize = i_size_read(bdev->bd_inode);
-	if (start >= isize)
-		return -EINVAL;
-	if (end >= isize) {
-		if (mode & FALLOC_FL_KEEP_SIZE) {
-			len = isize - start;
-			end = start + len - 1;
-		} else
-			return -EINVAL;
-	}
-
-	/*
-	 * Don't allow IO that isn't aligned to logical block size.
-	 */
-	if ((start | len) & (bdev_logical_block_size(bdev) - 1))
-		return -EINVAL;
-
-	/* Invalidate the page cache, including dirty pages. */
-	error = truncate_bdev_range(bdev, file->f_mode, start, end);
-	if (error)
-		return error;
-
-	switch (mode) {
-	case FALLOC_FL_ZERO_RANGE:
-	case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
-		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
-					    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
-		break;
-	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
-		error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
-					     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
-		break;
-	case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
-		error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
-					     GFP_KERNEL, 0);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-	if (error)
-		return error;
-
-	/*
-	 * Invalidate the page cache again; if someone wandered in and dirtied
-	 * a page, we just discard it - userspace has no way of knowing whether
-	 * the write happened before or after discard completing...
-	 */
-	return truncate_bdev_range(bdev, file->f_mode, start, end);
-}
-
-const struct file_operations def_blk_fops = {
-	.open		= blkdev_open,
-	.release	= blkdev_close,
-	.llseek		= block_llseek,
-	.read_iter	= blkdev_read_iter,
-	.write_iter	= blkdev_write_iter,
-	.iopoll		= blkdev_iopoll,
-	.mmap		= generic_file_mmap,
-	.fsync		= blkdev_fsync,
-	.unlocked_ioctl	= block_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl	= compat_blkdev_ioctl,
-#endif
-	.splice_read	= generic_file_splice_read,
-	.splice_write	= iter_file_splice_write,
-	.fallocate	= blkdev_fallocate,
-};
-
 /**
  * lookup_bdev  - lookup a struct block_device by name
  * @pathname:	special file representing the block device
-- 
2.30.2

