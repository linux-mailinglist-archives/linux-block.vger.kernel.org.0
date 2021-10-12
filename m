Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D3442ADC5
	for <lists+linux-block@lfdr.de>; Tue, 12 Oct 2021 22:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhJLU1y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Oct 2021 16:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31443 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234460AbhJLU1y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 16:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634070351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j20UAtWtq8r/uPWs+yBMZbP4xOs9Q4tdf7SXtdw4vY4=;
        b=SHw6583vtoxV9OqrYhyEC4tpGha2HZjhKm3xOUw/LQkah3KTQBQwYjiN5NUQExCtHu1KHb
        DNH9l0H1+CS8ZFOm1OLWqMBf5qTAcLzuRGo4gd+m50OnKtKbUPYIVe1YuXvuGBp/1wkVuT
        g027MZwWmVOIUVRH89uFFdmFxHTvhDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-98NkiJLDOGix-0WUubu3aA-1; Tue, 12 Oct 2021 16:25:48 -0400
X-MC-Unique: 98NkiJLDOGix-0WUubu3aA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 696DA801AFC;
        Tue, 12 Oct 2021 20:25:47 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3C9E60CC6;
        Tue, 12 Oct 2021 20:25:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 19CKP45A026290;
        Tue, 12 Oct 2021 16:25:04 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 19CKP3K3026286;
        Tue, 12 Oct 2021 16:25:03 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 12 Oct 2021 16:25:03 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] loop: don't print warnings if the underlying filesystem
 doesn't support discard
In-Reply-To: <20211012062049.GB17407@lst.de>
Message-ID: <alpine.LRH.2.02.2110121516440.21015@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2109231539520.27863@file01.intranet.prod.int.rdu2.redhat.com> <20210924155822.GA10064@lst.de> <alpine.LRH.2.02.2110040851130.30719@file01.intranet.prod.int.rdu2.redhat.com> <20211012062049.GB17407@lst.de>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Tue, 12 Oct 2021, Christoph Hellwig wrote:

> On Mon, Oct 04, 2021 at 09:01:33AM -0400, Mikulas Patocka wrote:
> > Do you want this patch?
> 
> Yes, this looks like what I want.  Minor nitpicks below:
> 
> > +	.fallocate_flags = BLKDEV_FALLOC_FL_SUPPORTED,
> 
> I'd probably call this fallocate_supported_flags.
> 
> > +	.fallocate_flags = FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE,
> 
> Please avoid over 80 lines for a plain list of flags.

OK. Here I'm sending a new version of the patch.

BTW. for some filesystems (cifs, ext4, fuse, ...), the supported falloc 
flags vary dynamically - for example, ext4 can do COLLAPSE_RANGE and 
INSERT_RANGE operations only if the filesystem is not ext2 or ext3 and if 
the file is not encrypted.

Should we add a new flag FALLOC_FL_RETURN_SUPORTED_FLAGS that will return 
the supported flags instead of using a static field in the file_operations 
structure?

Mikulas



From: Mikulas Patocka <mpatocka@redhat.com>

The loop driver checks for the fallocate method and if it is present, it 
assumes that the filesystem can do FALLOC_FL_ZERO_RANGE and 
FALLOC_FL_PUNCH_HOLE requests. However, some filesystems (such as fat, or 
tmpfs) have the fallocate method, but lack the capability to do 
FALLOC_FL_ZERO_RANGE and/or FALLOC_FL_PUNCH_HOLE.

This results in syslog warnings "blk_update_request: operation not 
supported error, dev loop0, sector 0 op 0x9:(WRITE_ZEROES) flags 0x800800 
phys_seg 0 prio class 0". The error can be reproduced with this command:
"truncate -s 1GiB /tmp/file; losetup /dev/loop0 /tmp/file; blkdiscard -z 
/dev/loop0"

This patch introduces a field "fallocate_supported_flags" in struct 
file_operations that specifies the flags that are supported by the 
fallocate methods. The loopback driver will check this field to determine 
if FALLOC_FL_PUNCH_HOLE or FALLOC_FL_ZERO_RANGE is supported

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6/block/fops.c
===================================================================
--- linux-2.6.orig/block/fops.c
+++ linux-2.6/block/fops.c
@@ -628,6 +628,7 @@ const struct file_operations def_blk_fop
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.fallocate_supported_flags = BLKDEV_FALLOC_FL_SUPPORTED,
 };
 
 static __init int blkdev_init(void)
Index: linux-2.6/fs/btrfs/file.c
===================================================================
--- linux-2.6.orig/fs/btrfs/file.c
+++ linux-2.6/fs/btrfs/file.c
@@ -3688,6 +3688,8 @@ const struct file_operations btrfs_file_
 	.release	= btrfs_release_file,
 	.fsync		= btrfs_sync_file,
 	.fallocate	= btrfs_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE |
+		FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE,
 	.unlocked_ioctl	= btrfs_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= btrfs_compat_ioctl,
Index: linux-2.6/fs/ceph/file.c
===================================================================
--- linux-2.6.orig/fs/ceph/file.c
+++ linux-2.6/fs/ceph/file.c
@@ -2492,5 +2492,6 @@ const struct file_operations ceph_file_f
 	.unlocked_ioctl = ceph_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.fallocate	= ceph_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 	.copy_file_range = ceph_copy_file_range,
 };
Index: linux-2.6/fs/cifs/cifsfs.c
===================================================================
--- linux-2.6.orig/fs/cifs/cifsfs.c
+++ linux-2.6/fs/cifs/cifsfs.c
@@ -1281,6 +1281,9 @@ const struct file_operations cifs_file_o
 	.remap_file_range = cifs_remap_file_range,
 	.setlease = cifs_setlease,
 	.fallocate = cifs_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_PUNCH_HOLE |
+		FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE |
+		FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE,
 };
 
 const struct file_operations cifs_file_strict_ops = {
@@ -1301,6 +1304,9 @@ const struct file_operations cifs_file_s
 	.remap_file_range = cifs_remap_file_range,
 	.setlease = cifs_setlease,
 	.fallocate = cifs_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_PUNCH_HOLE |
+		FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE |
+		FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE,
 };
 
 const struct file_operations cifs_file_direct_ops = {
@@ -1321,6 +1327,9 @@ const struct file_operations cifs_file_d
 	.llseek = cifs_llseek,
 	.setlease = cifs_setlease,
 	.fallocate = cifs_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_PUNCH_HOLE |
+		FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE |
+		FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE,
 };
 
 const struct file_operations cifs_file_nobrl_ops = {
@@ -1339,6 +1348,9 @@ const struct file_operations cifs_file_n
 	.remap_file_range = cifs_remap_file_range,
 	.setlease = cifs_setlease,
 	.fallocate = cifs_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_PUNCH_HOLE |
+		FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE |
+		FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE,
 };
 
 const struct file_operations cifs_file_strict_nobrl_ops = {
@@ -1357,6 +1369,9 @@ const struct file_operations cifs_file_s
 	.remap_file_range = cifs_remap_file_range,
 	.setlease = cifs_setlease,
 	.fallocate = cifs_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_PUNCH_HOLE |
+		FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE |
+		FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE,
 };
 
 const struct file_operations cifs_file_direct_nobrl_ops = {
@@ -1375,6 +1390,9 @@ const struct file_operations cifs_file_d
 	.llseek = cifs_llseek,
 	.setlease = cifs_setlease,
 	.fallocate = cifs_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_PUNCH_HOLE |
+		FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE |
+		FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE,
 };
 
 const struct file_operations cifs_dir_ops = {
Index: linux-2.6/fs/ext4/file.c
===================================================================
--- linux-2.6.orig/fs/ext4/file.c
+++ linux-2.6/fs/ext4/file.c
@@ -929,6 +929,9 @@ const struct file_operations ext4_file_o
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ext4_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE |
+		FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
+		FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE,
 };
 
 const struct inode_operations ext4_file_inode_operations = {
Index: linux-2.6/fs/f2fs/file.c
===================================================================
--- linux-2.6.orig/fs/f2fs/file.c
+++ linux-2.6/fs/f2fs/file.c
@@ -4499,6 +4499,9 @@ const struct file_operations f2fs_file_o
 	.flush		= f2fs_file_flush,
 	.fsync		= f2fs_sync_file,
 	.fallocate	= f2fs_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE |
+		FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
+		FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE,
 	.unlocked_ioctl	= f2fs_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= f2fs_compat_ioctl,
Index: linux-2.6/fs/fat/file.c
===================================================================
--- linux-2.6.orig/fs/fat/file.c
+++ linux-2.6/fs/fat/file.c
@@ -211,6 +211,7 @@ const struct file_operations fat_file_op
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= fat_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE,
 };
 
 static int fat_cont_expand(struct inode *inode, loff_t size)
Index: linux-2.6/fs/fuse/file.c
===================================================================
--- linux-2.6.orig/fs/fuse/file.c
+++ linux-2.6/fs/fuse/file.c
@@ -3147,6 +3147,8 @@ static const struct file_operations fuse
 	.compat_ioctl	= fuse_file_compat_ioctl,
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE |
+		FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE,
 	.copy_file_range = fuse_copy_file_range,
 };
 
Index: linux-2.6/fs/gfs2/file.c
===================================================================
--- linux-2.6.orig/fs/gfs2/file.c
+++ linux-2.6/fs/gfs2/file.c
@@ -1366,6 +1366,7 @@ const struct file_operations gfs2_file_f
 	.splice_write	= gfs2_file_splice_write,
 	.setlease	= simple_nosetlease,
 	.fallocate	= gfs2_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 };
 
 const struct file_operations gfs2_dir_fops = {
Index: linux-2.6/fs/hugetlbfs/inode.c
===================================================================
--- linux-2.6.orig/fs/hugetlbfs/inode.c
+++ linux-2.6/fs/hugetlbfs/inode.c
@@ -1163,6 +1163,7 @@ const struct file_operations hugetlbfs_f
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
 	.llseek			= default_llseek,
 	.fallocate		= hugetlbfs_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 };
 
 static const struct inode_operations hugetlbfs_dir_inode_operations = {
Index: linux-2.6/fs/nfs/nfs4file.c
===================================================================
--- linux-2.6.orig/fs/nfs/nfs4file.c
+++ linux-2.6/fs/nfs/nfs4file.c
@@ -457,6 +457,7 @@ const struct file_operations nfs4_file_o
 	.copy_file_range = nfs4_copy_file_range,
 	.llseek		= nfs4_file_llseek,
 	.fallocate	= nfs42_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 	.remap_file_range = nfs42_remap_file_range,
 #else
 	.llseek		= nfs_file_llseek,
Index: linux-2.6/fs/ntfs3/file.c
===================================================================
--- linux-2.6.orig/fs/ntfs3/file.c
+++ linux-2.6/fs/ntfs3/file.c
@@ -1246,6 +1246,8 @@ const struct file_operations ntfs_file_o
 	.fsync		= generic_file_fsync,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ntfs_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE |
+		FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE,
 	.release	= ntfs_file_release,
 };
 // clang-format on
Index: linux-2.6/fs/ocfs2/file.c
===================================================================
--- linux-2.6.orig/fs/ocfs2/file.c
+++ linux-2.6/fs/ocfs2/file.c
@@ -2746,6 +2746,7 @@ const struct file_operations ocfs2_fops
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ocfs2_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 	.remap_file_range = ocfs2_remap_file_range,
 };
 
@@ -2792,6 +2793,7 @@ const struct file_operations ocfs2_fops_
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ocfs2_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 	.remap_file_range = ocfs2_remap_file_range,
 };
 
Index: linux-2.6/fs/overlayfs/file.c
===================================================================
--- linux-2.6.orig/fs/overlayfs/file.c
+++ linux-2.6/fs/overlayfs/file.c
@@ -658,6 +658,7 @@ const struct file_operations ovl_file_op
 	.fsync		= ovl_fsync,
 	.mmap		= ovl_mmap,
 	.fallocate	= ovl_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_SUPPORTED_MASK,
 	.fadvise	= ovl_fadvise,
 	.flush		= ovl_flush,
 	.splice_read    = generic_file_splice_read,
Index: linux-2.6/fs/xfs/xfs_file.c
===================================================================
--- linux-2.6.orig/fs/xfs/xfs_file.c
+++ linux-2.6/fs/xfs/xfs_file.c
@@ -1464,6 +1464,7 @@ const struct file_operations xfs_file_op
 	.fsync		= xfs_file_fsync,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.fallocate	= xfs_file_fallocate,
+	.fallocate_supported_flags = XFS_FALLOC_FL_SUPPORTED,
 	.fadvise	= xfs_file_fadvise,
 	.remap_file_range = xfs_file_remap_range,
 };
Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h
+++ linux-2.6/include/linux/fs.h
@@ -2098,6 +2098,7 @@ struct file_operations {
 	int (*setlease)(struct file *, long, struct file_lock **, void **);
 	long (*fallocate)(struct file *file, int mode, loff_t offset,
 			  loff_t len);
+	unsigned fallocate_supported_flags;
 	void (*show_fdinfo)(struct seq_file *m, struct file *f);
 #ifndef CONFIG_MMU
 	unsigned (*mmap_capabilities)(struct file *);
Index: linux-2.6/ipc/shm.c
===================================================================
--- linux-2.6.orig/ipc/shm.c
+++ linux-2.6/ipc/shm.c
@@ -44,6 +44,7 @@
 #include <linux/mount.h>
 #include <linux/ipc_namespace.h>
 #include <linux/rhashtable.h>
+#include <linux/falloc.h>
 
 #include <linux/uaccess.h>
 
@@ -558,6 +559,7 @@ static const struct file_operations shm_
 	.get_unmapped_area	= shm_get_unmapped_area,
 	.llseek		= noop_llseek,
 	.fallocate	= shm_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 };
 
 /*
@@ -571,6 +573,7 @@ static const struct file_operations shm_
 	.get_unmapped_area	= shm_get_unmapped_area,
 	.llseek		= noop_llseek,
 	.fallocate	= shm_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 };
 
 bool is_file_shm_hugepages(struct file *file)
Index: linux-2.6/mm/shmem.c
===================================================================
--- linux-2.6.orig/mm/shmem.c
+++ linux-2.6/mm/shmem.c
@@ -3797,6 +3797,7 @@ static const struct file_operations shme
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
+	.fallocate_supported_flags = FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE,
 #endif
 };
 
Index: linux-2.6/drivers/block/loop.c
===================================================================
--- linux-2.6.orig/drivers/block/loop.c
+++ linux-2.6/drivers/block/loop.c
@@ -947,7 +947,10 @@ static void loop_config_discard(struct l
 	 * encryption is enabled, because it may give an attacker
 	 * useful information.
 	 */
-	} else if (!file->f_op->fallocate || lo->lo_encrypt_key_size) {
+	} else if ((file->f_op->fallocate_supported_flags &
+			(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)) !=
+			(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE) ||
+		   lo->lo_encrypt_key_size) {
 		max_discard_sectors = 0;
 		granularity = 0;
 
@@ -959,7 +962,10 @@ static void loop_config_discard(struct l
 	if (max_discard_sectors) {
 		q->limits.discard_granularity = granularity;
 		blk_queue_max_discard_sectors(q, max_discard_sectors);
-		blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
+		if (file->f_op->fallocate_supported_flags & FALLOC_FL_ZERO_RANGE)
+			blk_queue_max_write_zeroes_sectors(q, max_discard_sectors);
+		else
+			blk_queue_max_write_zeroes_sectors(q, 0);
 		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 	} else {
 		q->limits.discard_granularity = 0;

