Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7381278B053
	for <lists+linux-block@lfdr.de>; Mon, 28 Aug 2023 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjH1MbY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Aug 2023 08:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjH1Max (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Aug 2023 08:30:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6389107;
        Mon, 28 Aug 2023 05:30:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 981DA68D05; Mon, 28 Aug 2023 14:30:25 +0200 (CEST)
Date:   Mon, 28 Aug 2023 14:30:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 03/12] filemap: update ki_pos in generic_perform_write
Message-ID: <20230828123023.GA11084@lst.de>
References: <20230601145904.1385409-1-hch@lst.de> <20230601145904.1385409-4-hch@lst.de> <20230827194122.GA325446@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827194122.GA325446@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 27, 2023 at 08:41:22PM +0100, Al Viro wrote:
> That part is somewhat fishy - there's a case where you return a positive value
> and advance ->ki_pos by more than that amount.  I really wonder if all callers
> of ->write_iter() are OK with that.  Consider e.g. this:

This should not exist in the latest version merged by Jens.  Can you
check if you still  see issues in the version in the block tree or
linux-next.

> Suppose ->write_iter() ends up doing returning a positive value smaller than
> the increment of kiocb.ki_pos.  What do we get?  ret is positive, so
> kiocb.ki_pos gets copied into *ppos, which is ksys_write's pos and there
> we copy it into file->f_pos.
> 
> Is it really OK to have write() return 4096 and advance the file position
> by 16K?  AFAICS, userland wouldn't get any indication of something
> odd going on - just a short write to a regular file, with followup write
> of remaining 12K getting quietly written in the range 16K..28K.
> 
> I don't remember what POSIX says about that, but it would qualify as
> nasty surprise for any userland program - sure, one can check fsync()
> results before closing the sucker and see if everything looks fine,
> but the way it's usually discussed could easily lead to assumption that
> (synchronous) O_DIRECT writes would not be affected by anything of that
> sort.

ki_pos should always be updated by the write return value.  Everything
else is a bug.
