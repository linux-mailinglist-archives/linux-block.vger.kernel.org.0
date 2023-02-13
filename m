Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BD7694755
	for <lists+linux-block@lfdr.de>; Mon, 13 Feb 2023 14:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjBMNrO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Feb 2023 08:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBMNrN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 08:47:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F374893FE
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 05:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676295987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jpj+Hi64Ov256tSq+vKlLJQsr7J0tYvdjVC2kndFEfc=;
        b=ZW2eBBPWs3tlnR6F/v7PxPtbrJ+vO0RvdPbRuyNsJ8nFMX8SmsUmiTHVYGYfBsc9IPrqxW
        jFmuYqXeQWkNg3JGFMTu/Gq1aInp/DSpHG2IP0PnR7op/V+pnLF+cNopJFiNssWoUxoWe7
        tv+5E2Sfoc5iX9Am2GVKzRUYGTFkEvw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-7ekccTIgNjWw5z9w3Wxjfg-1; Mon, 13 Feb 2023 08:46:24 -0500
X-MC-Unique: 7ekccTIgNjWw5z9w3Wxjfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DDF0811E6E;
        Mon, 13 Feb 2023 13:46:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E51E040C83B6;
        Mon, 13 Feb 2023 13:46:20 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 0/4] iov_iter: Adjust styling/location of new splice functions
Date:   Mon, 13 Feb 2023 13:46:15 +0000
Message-Id: <20230213134619.2198965-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens, Al, Christoph,

Here are patches to make some changes that Christoph requested[1] to the
new generic file splice functions that I implemented[2].  Apart from one
functional change, they just altering the styling and move one of the
functions to a different file:

 (1) Rename the main functions:

	generic_file_buffered_splice_read() -> filemap_splice_read()
	generic_file_direct_splice_read()   -> direct_splice_read()

 (2) Abstract out the calculation of the location of the head pipe buffer
     into a helper function in linux/pipe_fs_i.h.

 (3) Use init_sync_kiocb() in filemap_splice_read().

     This is where the functional change is.  Some kiocb fields are then
     filled in where they were set to 0 before, including setting ki_flags
     from f_iocb_flags.  I've filtered out IOCB_NOWAIT as the function is
     supposed to be synchronous.

 (4) Move filemap_splice_read() to mm/filemap.c.  filemap_get_pages() can
     then be made static again.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-extract-3

I've also updated worked the changes into the commits on my iov-extract
branch if that would be preferable, though that means Jens would need to
update his for-6.3/iov-extract again.

David

Link: https://lore.kernel.org/r/Y+n0n2UE8BQa/OwW@infradead.org/ [1]
Link: https://lore.kernel.org/r/20230207171305.3716974-1-dhowells@redhat.com/ [2]

David Howells (4):
  splice: Rename new splice functions
  splice: Provide pipe_head_buf() helper
  splice: Use init_sync_kiocb() in filemap_splice_read()
  splice: Move filemap_read_splice() to mm/filemap.c

 fs/splice.c               | 146 ++------------------------------------
 include/linux/pagemap.h   |   2 -
 include/linux/pipe_fs_i.h |  20 ++++++
 include/linux/splice.h    |   4 ++
 mm/filemap.c              | 138 +++++++++++++++++++++++++++++++++--
 5 files changed, 163 insertions(+), 147 deletions(-)

