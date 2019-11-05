Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15B9AEF1CE
	for <lists+linux-block@lfdr.de>; Tue,  5 Nov 2019 01:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfKEASe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 Nov 2019 19:18:34 -0500
Received: from verein.lst.de ([213.95.11.211]:42135 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729607AbfKEASe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 19:18:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1ADB068BE1; Tue,  5 Nov 2019 01:18:31 +0100 (CET)
Date:   Tue, 5 Nov 2019 01:18:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] block: skip the split micro-optimization for devices
 with chunk size
Message-ID: <20191105001830.GA27112@lst.de>
References: <20191105000617.26923-1-hch@lst.de> <2ac3f0c3-1454-3246-37a5-695a13319b8c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac3f0c3-1454-3246-37a5-695a13319b8c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 04, 2019 at 04:14:10PM -0800, Bart Van Assche wrote:
> On 11/4/19 4:06 PM, Christoph Hellwig wrote:
>> If the devices sets a chunk size we might have to split I/O that is
>> smaller than a page size if it crosses the chunk boundary.  Skip the
>> micro-optimization for small I/Os in that case.
>>
>> Fixes: b072e20f0084 ("block: merge invalidate_partitions into rescan_partitions")
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/blk-merge.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 06eb38357b41..f22cb6251d06 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -317,7 +317,8 @@ void __blk_queue_split(struct request_queue *q, struct bio **bio,
>>   		 * are cloned, but compared to the performance impact of cloned
>>   		 * bios themselves the loop below doesn't matter anyway.
>                                        ^^^^
> Did you perhaps mean "test" instead of "loop"?

No. I did mean the loop in blk_bio_segment_split.
