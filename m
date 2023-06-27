Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9283373FFCE
	for <lists+linux-block@lfdr.de>; Tue, 27 Jun 2023 17:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjF0Pft (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Jun 2023 11:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjF0Pfs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 11:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7049F297D
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687880094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ou2xGh6t3Up2IrWkudK4YJRKKfn0b5GKukgcNLUdYxo=;
        b=Utuysmua7M7iFoSwIIPwREC6kmsGhShELMTzJEfa4M13oO5DEShSHlP0BkqAZXzIjj14yT
        mJ9Gu3Z42q0o+pooymqbRbv64BNKLM1H/fSzrGrN35N7PruGKmL0COk6QZzS2zpQB7jw/J
        Zap1FdInTosK7kBfxGUvVTso/dhwiTE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-cm9xpWogOuegEP3IkKEGTQ-1; Tue, 27 Jun 2023 11:34:10 -0400
X-MC-Unique: cm9xpWogOuegEP3IkKEGTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 241C28EDD29;
        Tue, 27 Jun 2023 15:31:13 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16DD4C00049;
        Tue, 27 Jun 2023 15:31:13 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 00E9F30C045B; Tue, 27 Jun 2023 15:31:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id F12C73FB76;
        Tue, 27 Jun 2023 17:31:12 +0200 (CEST)
Date:   Tue, 27 Jun 2023 17:31:12 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, Marc Smith <msmith626@gmail.com>
Subject: Re: [PATCH] block: flush the disk cache on BLKFLSBUF
In-Reply-To: <1a33ace-57f9-9ef9-b967-d6617ca33089@redhat.com>
Message-ID: <f9e830ef-adf7-4196-a46f-ba4e65cbb54d@redhat.com>
References: <1a33ace-57f9-9ef9-b967-d6617ca33089@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> On Mon, 26 Jun 2023, Mikulas Patocka wrote:
> 
> > The BLKFLSBUF ioctl doesn't send the flush bio to the block device, thus
> > flushed data may be lurking in the disk cache and they may not be really
> > flushed to the stable storage.
> > 
> > This patch adds the call to blkdev_issue_flush to blkdev_flushbuf.
> 
> Umm, why?  This is an ioctl no one should be using, and we certainly
> should not add new functionality to it.  Can you explain what you're
> trying to do here?

Marc Smith reported a bug where he wrote to the dm-writecache target using 
O_DIRECT, then reset the machine without proper shutdown and the freshly 
written data were lost. It turned out that he didn't use the fsync or 
fdatasync syscall (and dm-writecache makes its metadata persistent on a 
FLUSH bio).

When I was analyzing this issue, it turned out that there is no easy way 
how to send the FLUSH bio to a block device from a command line.

The sync command synchronizes only filesystems, it doesn't flush cache for 
unmounted block devices (do you think that it should flush block devices 
too?).

The "blockdev --flushbufs" command also doesn't send the FLUSH bio, but I 
would expect it to send it. Without sending the FLUSH bio, "blockdev 
--flushbufs" doesn't really guarantee anything.

Mikulas

