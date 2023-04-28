Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE666F1016
	for <lists+linux-block@lfdr.de>; Fri, 28 Apr 2023 03:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjD1BmV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 27 Apr 2023 21:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjD1BmU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Apr 2023 21:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512DC1FC0
        for <linux-block@vger.kernel.org>; Thu, 27 Apr 2023 18:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682646093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DAggdfiCq2i+jGMt/hx+W9dG2SinJfHBtiVgLfXz2w8=;
        b=T6zvQBbkcAApoP0CFATrNewbzvWTVo2+bSM89NGazNHqbIp//PwkT80I1ezHSgKfKzOmcf
        B/b7HsjWm8iX2dfo6+74/0AueOgWLXPZywSjygFnsy/Q/L2L0ZhoUDc/gM8AJRY3UB5WAD
        gMaPOVQQo+s4KBOwMATdn0DYqxiFYJs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-X7zBevW-NnOvO2-CBXNroA-1; Thu, 27 Apr 2023 21:41:29 -0400
X-MC-Unique: X7zBevW-NnOvO2-CBXNroA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9C6529A9D40;
        Fri, 28 Apr 2023 01:41:28 +0000 (UTC)
Received: from ovpn-8-24.pek2.redhat.com (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBB96492C3E;
        Fri, 28 Apr 2023 01:41:20 +0000 (UTC)
Date:   Fri, 28 Apr 2023 09:41:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>, ming.lei@redhat.com
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
 <ZEny7Izr8iOc/23B@casper.infradead.org>
 <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com>
 <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com>
 <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com>
 <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com>
 <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 27, 2023 at 07:27:04PM +0800, Ming Lei wrote:
> On Thu, Apr 27, 2023 at 07:19:35PM +0800, Baokun Li wrote:
> > On 2023/4/27 18:01, Ming Lei wrote:
> > > On Thu, Apr 27, 2023 at 02:36:51PM +0800, Baokun Li wrote:
> > > > On 2023/4/27 12:50, Ming Lei wrote:
> > > > > Hello Matthew,
> > > > > 
> > > > > On Thu, Apr 27, 2023 at 04:58:36AM +0100, Matthew Wilcox wrote:
> > > > > > On Thu, Apr 27, 2023 at 10:20:28AM +0800, Ming Lei wrote:
> > > > > > > Hello Guys,
> > > > > > > 
> > > > > > > I got one report in which buffered write IO hangs in balance_dirty_pages,
> > > > > > > after one nvme block device is unplugged physically, then umount can't
> > > > > > > succeed.
> > > > > > That's a feature, not a bug ... the dd should continue indefinitely?
> > > > > Can you explain what the feature is? And not see such 'issue' or 'feature'
> > > > > on xfs.
> > > > > 
> > > > > The device has been gone, so IMO it is reasonable to see FS buffered write IO
> > > > > failed. Actually dmesg has shown that 'EXT4-fs (nvme0n1): Remounting
> > > > > filesystem read-only'. Seems these things may confuse user.
> > > > 
> > > > The reason for this difference is that ext4 and xfs handle errors
> > > > differently.
> > > > 
> > > > ext4 remounts the filesystem as read-only or even just continues, vfs_write
> > > > does not check for these.
> > > vfs_write may not find anything wrong, but ext4 remount could see that
> > > disk is gone, which might happen during or after remount, however.
> > > 
> > > > xfs shuts down the filesystem, so it returns a failure at
> > > > xfs_file_write_iter when it finds an error.
> > > > 
> > > > 
> > > > ``` ext4
> > > > ksys_write
> > > >   vfs_write
> > > >    ext4_file_write_iter
> > > >     ext4_buffered_write_iter
> > > >      ext4_write_checks
> > > >       file_modified
> > > >        file_modified_flags
> > > >         __file_update_time
> > > >          inode_update_time
> > > >           generic_update_time
> > > >            __mark_inode_dirty
> > > >             ext4_dirty_inode ---> 2. void func, No propagating errors out
> > > >              __ext4_journal_start_sb
> > > >               ext4_journal_check_start ---> 1. Error found, remount-ro
> > > >      generic_perform_write ---> 3. No error sensed, continue
> > > >       balance_dirty_pages_ratelimited
> > > >        balance_dirty_pages_ratelimited_flags
> > > >         balance_dirty_pages
> > > >          // 4. Sleeping waiting for dirty pages to be freed
> > > >          __set_current_state(TASK_KILLABLE)
> > > >          io_schedule_timeout(pause);
> > > > ```
> > > > 
> > > > ``` xfs
> > > > ksys_write
> > > >   vfs_write
> > > >    xfs_file_write_iter
> > > >     if (xfs_is_shutdown(ip->i_mount))
> > > >       return -EIO;    ---> dd fail
> > > > ```
> > > Thanks for the info which is really helpful for me to understand the
> > > problem.
> > > 
> > > > > > balance_dirty_pages() is sleeping in KILLABLE state, so kill -9 of
> > > > > > the dd process should succeed.
> > > > > Yeah, dd can be killed, however it may be any application(s), :-)
> > > > > 
> > > > > Fortunately it won't cause trouble during reboot/power off, given
> > > > > userspace will be killed at that time.
> > > > > 
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > Ming
> > > > > 
> > > > Don't worry about that, we always set the current thread to TASK_KILLABLE
> > > > 
> > > > while waiting in balance_dirty_pages().
> > > I have another concern, if 'dd' isn't killed, dirty pages won't be cleaned, and
> > > these (big amount)memory becomes not usable, and typical scenario could be USB HDD
> > > unplugged.
> > > 
> > > 
> > > thanks,
> > > Ming
> > Yes, it is unreasonable to continue writing data with the previously opened
> > fd after
> > the file system becomes read-only, resulting in dirty page accumulation.
> > 
> > I provided a patch in another reply.
> > Could you help test if it can solve your problem?
> > If it can indeed solve your problem, I will officially send it to the email
> > list.
> 
> OK, I will test it tomorrow.

Your patch can avoid dd hang when bs is 512 at default, but if bs is
increased to 1G and more 'dd' tasks are started, the dd hang issue
still can be observed.

The reason should be the next paragraph I posted.

Another thing is that if remount read-only makes sense on one dead
disk? Yeah, block layer doesn't export such interface for querying
if bdev is dead. However, I think it is reasonable to export such
interface if FS needs that.

> 
> But I am afraid if it can avoid the issue completely because the
> old write task hang in balance_dirty_pages() may still write/dirty pages
> if it is one very big size write IO.


thanks,
Ming

