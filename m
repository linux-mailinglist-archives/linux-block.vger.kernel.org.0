Return-Path: <linux-block+bounces-10572-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F6B953F0C
	for <lists+linux-block@lfdr.de>; Fri, 16 Aug 2024 03:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F41FB235F2
	for <lists+linux-block@lfdr.de>; Fri, 16 Aug 2024 01:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342151D69E;
	Fri, 16 Aug 2024 01:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grPcC2GI"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32F29CEF
	for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772726; cv=none; b=pLNg29cxsx8v1MxgR8plUvzhibC8DzKxLg5q9Kf5aI6Ulfr07Yk3Im6KMDJAaCkl2Oq3Vsfr5ZuP/sfZxHDz4nZ+jOBihxowbdWSwA5ytNTzLX0BDrLipw7xYCJsbcFFdtBt0m4i3JFSnYfAzdgl+zsTkcLotnEFFHWv4F6qVDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772726; c=relaxed/simple;
	bh=s/nwH08NlRsAyxnKAea0guN+gj5xC4Yb7Z1jzGw+MO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9wICveyt7f7qJdZzzrEPYb6blXpGrqY/T4jA8u1hs8RMgGsmqEhVZ1OCQHtFq3UcT9LIZqLAZZNLt/myVN8HWkfWj8yidqrmDjaOn2tOmzZyBJwQnNKM73glN06pH3Pvnm+nc3XwwruTeT7/u1AF0k+5g3dweMIo2J9Cmu+Wkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grPcC2GI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723772723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mxy0rtdNdtcD3NoIzzm3sQ/N1TTdvcPBZq39L7HnMHg=;
	b=grPcC2GIzUaxBP+pG7UpfGIDNLa8rk056GC6x6unqoWhL2ab7n8U2AW19tqHcy3jHmwHlh
	jIUDLhzq5SL37jxu7eucGMCaa8Y3hOL3RdfeTewkinrHuU5Aj3ywJwsCaVI3R7aJMm1+fJ
	2dpKFi1svM8bAiBVKxItXZ//JoJUNBI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-Uz1QAaw1Ni6II1qQQ0QGBQ-1; Thu,
 15 Aug 2024 21:45:18 -0400
X-MC-Unique: Uz1QAaw1Ni6II1qQQ0QGBQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E4FD1955D52;
	Fri, 16 Aug 2024 01:45:17 +0000 (UTC)
Received: from fedora (unknown [10.72.116.112])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FD6C19560AA;
	Fri, 16 Aug 2024 01:45:11 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:45:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
	Conrad Meyer <conradmeyer@meta.com>, linux-block@vger.kernel.org,
	linux-mm@kvack.org, ming.lei@redhat.com
Subject: Re: [RFC 5/5] block: implement io_uring discard cmd
Message-ID: <Zr6vIt1uSe9/xguH@fedora>
References: <cover.1723601133.git.asml.silence@gmail.com>
 <6ecd7ab3386f63f1656dc766c1b5b038ff5353c2.1723601134.git.asml.silence@gmail.com>
 <CAFj5m9+CXS_b5kgFioFHTWivb6O+R9HytsSQEHcEzUM5SqHfgw@mail.gmail.com>
 <fd357721-7ba7-4321-88da-28651754f8a4@kernel.dk>
 <e06fd325-f20f-44d8-8f72-89b97cf4186f@gmail.com>
 <Zr6S4sHWtdlbl/dd@fedora>
 <4d016a30-d258-4d0e-b3bc-18bf0bd48e32@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d016a30-d258-4d0e-b3bc-18bf0bd48e32@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Aug 15, 2024 at 07:24:16PM -0600, Jens Axboe wrote:
> On 8/15/24 5:44 PM, Ming Lei wrote:
> > On Thu, Aug 15, 2024 at 06:11:13PM +0100, Pavel Begunkov wrote:
> >> On 8/15/24 15:33, Jens Axboe wrote:
> >>> On 8/14/24 7:42 PM, Ming Lei wrote:
> >>>> On Wed, Aug 14, 2024 at 6:46?PM Pavel Begunkov <asml.silence@gmail.com> wrote:
> >>>>>
> >>>>> Add ->uring_cmd callback for block device files and use it to implement
> >>>>> asynchronous discard. Normally, it first tries to execute the command
> >>>>> from non-blocking context, which we limit to a single bio because
> >>>>> otherwise one of sub-bios may need to wait for other bios, and we don't
> >>>>> want to deal with partial IO. If non-blocking attempt fails, we'll retry
> >>>>> it in a blocking context.
> >>>>>
> >>>>> Suggested-by: Conrad Meyer <conradmeyer@meta.com>
> >>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >>>>> ---
> >>>>>   block/blk.h             |  1 +
> >>>>>   block/fops.c            |  2 +
> >>>>>   block/ioctl.c           | 94 +++++++++++++++++++++++++++++++++++++++++
> >>>>>   include/uapi/linux/fs.h |  2 +
> >>>>>   4 files changed, 99 insertions(+)
> >>>>>
> >>>>> diff --git a/block/blk.h b/block/blk.h
> >>>>> index e180863f918b..5178c5ba6852 100644
> >>>>> --- a/block/blk.h
> >>>>> +++ b/block/blk.h
> >>>>> @@ -571,6 +571,7 @@ blk_mode_t file_to_blk_mode(struct file *file);
> >>>>>   int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
> >>>>>                  loff_t lstart, loff_t lend);
> >>>>>   long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
> >>>>> +int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
> >>>>>   long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
> >>>>>
> >>>>>   extern const struct address_space_operations def_blk_aops;
> >>>>> diff --git a/block/fops.c b/block/fops.c
> >>>>> index 9825c1713a49..8154b10b5abf 100644
> >>>>> --- a/block/fops.c
> >>>>> +++ b/block/fops.c
> >>>>> @@ -17,6 +17,7 @@
> >>>>>   #include <linux/fs.h>
> >>>>>   #include <linux/iomap.h>
> >>>>>   #include <linux/module.h>
> >>>>> +#include <linux/io_uring/cmd.h>
> >>>>>   #include "blk.h"
> >>>>>
> >>>>>   static inline struct inode *bdev_file_inode(struct file *file)
> >>>>> @@ -873,6 +874,7 @@ const struct file_operations def_blk_fops = {
> >>>>>          .splice_read    = filemap_splice_read,
> >>>>>          .splice_write   = iter_file_splice_write,
> >>>>>          .fallocate      = blkdev_fallocate,
> >>>>> +       .uring_cmd      = blkdev_uring_cmd,
> >>>>
> >>>> Just be curious, we have IORING_OP_FALLOCATE already for sending
> >>>> discard to block device, why is .uring_cmd added for this purpose?
> >>
> >> Which is a good question, I haven't thought about it, but I tend to
> >> agree with Jens. Because vfs_fallocate is created synchronous
> >> IORING_OP_FALLOCATE is slow for anything but pretty large requests.
> >> Probably can be patched up, which would  involve changing the
> >> fops->fallocate protot, but I'm not sure async there makes sense
> >> outside of bdev (?), and cmd approach is simpler, can be made
> >> somewhat more efficient (1 less layer in the way), and it's not
> >> really something completely new since we have it in ioctl.
> > 
> > Yeah, we have ioctl(DISCARD), which acquires filemap_invalidate_lock,
> > same with blkdev_fallocate().
> > 
> > But this patch drops this exclusive lock, so it becomes async friendly,
> > but may cause stale page cache. However, if the lock is required, it can't
> > be efficient anymore and io-wq may be inevitable, :-)
> 
> If you want to grab the lock, you can still opportunistically grab it.
> For (by far) the common case, you'll get it, and you can still do it
> inline.

If the lock is grabbed in the whole cmd lifetime, it is basically one sync
interface cause there is at most one async discard cmd in-flight for each
device.

Meantime the handling has to move to io-wq for avoiding to block current
context, the interface becomes same with IORING_OP_FALLOCATE?


thanks,
Ming


