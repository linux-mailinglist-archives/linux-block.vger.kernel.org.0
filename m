Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705C4614B84
	for <lists+linux-block@lfdr.de>; Tue,  1 Nov 2022 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKANSi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Nov 2022 09:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiKANSh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 09:18:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B14C60
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 06:18:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1501D6732D; Tue,  1 Nov 2022 14:18:31 +0100 (CET)
Date:   Tue, 1 Nov 2022 14:18:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 7/7] block: store the holder kobject in bd_holder_disk
Message-ID: <20221101131830.GA16341@lst.de>
References: <20221030153120.1045101-1-hch@lst.de> <20221030153120.1045101-8-hch@lst.de> <fd409996-e5e1-d7af-b31d-87db943eaa25@huaweicloud.com> <20221101104927.GA13823@lst.de> <d3f6ec1d-8141-19d1-ce4c-d42710f4a636@huaweicloud.com> <20221101112131.GA14379@lst.de> <57465370-99fe-d8a5-e150-a1057640e972@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57465370-99fe-d8a5-e150-a1057640e972@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 01, 2022 at 07:28:17PM +0800, Yu Kuai wrote:
> What if bd_holder_dir is already freed here, then uaf can be triggered.
> Thus bd_holder_dir need to be resed in del_gendisk() if it's reference
> is dropped to 0, however, kobject apis can't do that...

Indeed.  I don't think we can simply move the dropping of the reference
as you suggested as that also implies taking it earlier, and the
device in the disk is only initialized in add_disk.

Now what I think we could do is:

 - hold open_mutex in bd_link_disk_holder as you suggested
 - check that the bdev inode is hashed inside open_mutex before doing
   the kobject_get
