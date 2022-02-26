Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED174C5604
	for <lists+linux-block@lfdr.de>; Sat, 26 Feb 2022 14:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiBZNBK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 26 Feb 2022 08:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiBZNBK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Feb 2022 08:01:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD02266DB8;
        Sat, 26 Feb 2022 05:00:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79672B80139;
        Sat, 26 Feb 2022 13:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C0DC340E8;
        Sat, 26 Feb 2022 13:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645880433;
        bh=frJylF/+FxLOI5G318Rhg4DUZhcG4+0AAN7L8S41CrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9uipyOymCTqT+EbivBEe4AYc+pBeKqN0BSGP+jOPZRHR2OiD2rwOvm9KUdsYjT40
         YEq1e+CpFHFgcTmq/111wY3ZVIRzl8bLMce+2D8qX5amd+ftsK6nBbLzAzjLNihvBg
         MgkmuMkSmKWC5GsneQ3FUxu2zB6DZI1iFdsMnnpI=
Date:   Sat, 26 Feb 2022 14:00:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, rostedt@goodmis.org, mingo@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] blktrace: Revert "blktrace: remove debugfs file dentries
 from struct blk_trace"
Message-ID: <Yhokbid+ForZROCn@kroah.com>
References: <20220226095343.1121256-1-yukuai3@huawei.com>
 <Yhn2UD7nY3poWzkN@kroah.com>
 <09fd48a2-77b1-f4fb-87d8-704fba9d754b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09fd48a2-77b1-f4fb-87d8-704fba9d754b@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 26, 2022 at 05:57:44PM +0800, yukuai (C) wrote:
> 在 2022/02/26 17:43, Greg KH 写道:
> > On Sat, Feb 26, 2022 at 05:53:43PM +0800, Yu Kuai wrote:
> > > This reverts commit c0ea57608b691d6cde8aff23e11f9858a86b5918.
> > > 
> > > When tracing the whole disk, 'dropped' and 'msg' will be created
> > > under 'q->debugfs_dir' and 'bt->dir' is NULL, thus blk_trace_free()
> > > won't remove those files. What's worse, the following UAF can be
> > > triggered because of stale 'dropped' and 'msg':
> > 
> > Only root has access to these files, right?
> 
> Hi,
> 
> Yes, usually user will use blktrace to access these files.
> > 
> > > 
> > > ==================================================================
> > > BUG: KASAN: use-after-free in blk_dropped_read+0x89/0x100
> > > Read of size 4 at addr ffff88816912f3d8 by task blktrace/1188
> > > 
> > > CPU: 27 PID: 1188 Comm: blktrace Not tainted 5.17.0-rc4-next-20220217+ #469
> > > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-4
> > > Call Trace:
> > >   <TASK>
> > >   dump_stack_lvl+0x34/0x44
> > >   print_address_description.constprop.0.cold+0xab/0x381
> > >   ? blk_dropped_read+0x89/0x100
> > >   ? blk_dropped_read+0x89/0x100
> > >   kasan_report.cold+0x83/0xdf
> > >   ? blk_dropped_read+0x89/0x100
> > >   kasan_check_range+0x140/0x1b0
> > >   blk_dropped_read+0x89/0x100
> > >   ? blk_create_buf_file_callback+0x20/0x20
> > >   ? kmem_cache_free+0xa1/0x500
> > >   ? do_sys_openat2+0x258/0x460
> > >   full_proxy_read+0x8f/0xc0
> > >   vfs_read+0xc6/0x260
> > >   ksys_read+0xb9/0x150
> > >   ? vfs_write+0x3d0/0x3d0
> > >   ? fpregs_assert_state_consistent+0x55/0x60
> > >   ? exit_to_user_mode_prepare+0x39/0x1e0
> > >   do_syscall_64+0x35/0x80
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > RIP: 0033:0x7fbc080d92fd
> > > Code: ce 20 00 00 75 10 b8 00 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 1
> > > RSP: 002b:00007fbb95ff9cb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000000
> > > RAX: ffffffffffffffda RBX: 00007fbb95ff9dc0 RCX: 00007fbc080d92fd
> > > RDX: 0000000000000100 RSI: 00007fbb95ff9cc0 RDI: 0000000000000045
> > > RBP: 0000000000000045 R08: 0000000000406299 R09: 00000000fffffffd
> > > R10: 000000000153afa0 R11: 0000000000000293 R12: 00007fbb780008c0
> > > R13: 00007fbb78000938 R14: 0000000000608b30 R15: 00007fbb780029c8
> > >   </TASK>
> > > 
> > > Allocated by task 1050:
> > >   kasan_save_stack+0x1e/0x40
> > >   __kasan_kmalloc+0x81/0xa0
> > >   do_blk_trace_setup+0xcb/0x410
> > >   __blk_trace_setup+0xac/0x130
> > >   blk_trace_ioctl+0xe9/0x1c0
> > >   blkdev_ioctl+0xf1/0x390
> > >   __x64_sys_ioctl+0xa5/0xe0
> > >   do_syscall_64+0x35/0x80
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > 
> > > Freed by task 1050:
> > >   kasan_save_stack+0x1e/0x40
> > >   kasan_set_track+0x21/0x30
> > >   kasan_set_free_info+0x20/0x30
> > >   __kasan_slab_free+0x103/0x180
> > >   kfree+0x9a/0x4c0
> > >   __blk_trace_remove+0x53/0x70
> > >   blk_trace_ioctl+0x199/0x1c0
> > >   blkdev_common_ioctl+0x5e9/0xb30
> > >   blkdev_ioctl+0x1a5/0x390
> > >   __x64_sys_ioctl+0xa5/0xe0
> > >   do_syscall_64+0x35/0x80
> > >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > 
> > > The buggy address belongs to the object at ffff88816912f380
> > >   which belongs to the cache kmalloc-96 of size 96
> > > The buggy address is located 88 bytes inside of
> > >   96-byte region [ffff88816912f380, ffff88816912f3e0)
> > > The buggy address belongs to the page:
> > > page:000000009a1b4e7c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0f
> > > flags: 0x17ffffc0000200(slab|node=0|zone=2|lastcpupid=0x1fffff)
> > > raw: 0017ffffc0000200 ffffea00044f1100 dead000000000002 ffff88810004c780
> > > raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
> > > page dumped because: kasan: bad access detected
> > > 
> > > Memory state around the buggy address:
> > >   ffff88816912f280: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > >   ffff88816912f300: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > > ffff88816912f380: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > >                                                      ^
> > >   ffff88816912f400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > >   ffff88816912f480: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > ==================================================================
> > > 
> > > Fixes: c0ea57608b69 ("blktrace: remove debugfs file dentries from struct blk_trace")
> > > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > > ---
> > >   include/linux/blktrace_api.h | 2 ++
> > >   kernel/trace/blktrace.c      | 8 ++++++--
> > >   2 files changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
> > > index 22501a293fa5..f288d229727c 100644
> > > --- a/include/linux/blktrace_api.h
> > > +++ b/include/linux/blktrace_api.h
> > > @@ -23,6 +23,8 @@ struct blk_trace {
> > >   	u32 pid;
> > >   	u32 dev;
> > >   	struct dentry *dir;
> > > +	struct dentry *dropped_file;
> > > +	struct dentry *msg_file;
> > 
> > No need to save these dentries.  Just look them up when you want to
> > remove the files.
> 
> Ok, I'll do this in the v2 patch.
> > 
> > >   	struct list_head running_list;
> > >   	atomic_t dropped;
> > >   };
> > > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > > index 19514edc44f7..13152a17fdb3 100644
> > > --- a/kernel/trace/blktrace.c
> > > +++ b/kernel/trace/blktrace.c
> > > @@ -312,6 +312,8 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
> > >   static void blk_trace_free(struct blk_trace *bt)
> > >   {
> > > +	debugfs_remove(bt->msg_file);
> > > +	debugfs_remove(bt->dropped_file);
> > >   	relay_close(bt->rchan);
> > >   	debugfs_remove(bt->dir);
> > 
> > Why not just move this line up above relay_close()?
> > 
> > Then you the whole directory is properly removed, along with the files
> > in it.
> 
> In the case tracing the whole disk, bt->dir is NULL, if dentries are not
> saved, they should be looked up from 'q->debugfs_dir'. Perhaps the
> following:
> 
> if (bt->dir) {
> 	debugfs_remove(bt->dir);
> } else {
> 	/* lookup from q->debugfs_dir and remove */
> }

The check for bt->dir is odd, as aren't the msg_file in the bt->dir
directory?

Ah, ick, that's not obvious at all that there is two different cases
happening here.

Yes, your code will work, but please comment the heck out of it as
normally when I see a "check if we have a file/directory before we
remove it" for debugfs I want to optimize it away to just call the
debugfs function as debugfs doesn't care about invalid parameters like
this.  But you are using it as a test if this is in full disk mode or
not, which isn't obvious at all (hence my confusion when I wrote the
original patch, sorry.)

thanks,

greg k-h
