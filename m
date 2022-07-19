Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482C25793ED
	for <lists+linux-block@lfdr.de>; Tue, 19 Jul 2022 09:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiGSHOj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 19 Jul 2022 03:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiGSHOi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Jul 2022 03:14:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A991D319;
        Tue, 19 Jul 2022 00:14:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 765DA68AA6; Tue, 19 Jul 2022 09:14:34 +0200 (CEST)
Date:   Tue, 19 Jul 2022 09:14:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 09/10] md: only delete entries from all_mddevs when the
 disk is freed
Message-ID: <20220719071434.GA28668@lst.de>
References: <20220718063410.338626-1-hch@lst.de> <20220718063410.338626-10-hch@lst.de> <b8521a53-fb41-279c-dc43-580e8d0de045@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8521a53-fb41-279c-dc43-580e8d0de045@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 09:17:42AM +0200, Hannes Reinecke wrote:
> Why can't we use 'atomic_inc_unless_zero' here and do away with the 
> additional 'deleted' flag?

See my previous reply.

>> @@ -3338,6 +3342,8 @@ static bool md_rdev_overlaps(struct md_rdev *rdev)
>>     	spin_lock(&all_mddevs_lock);
>>   	list_for_each_entry(mddev, &all_mddevs, all_mddevs) {
>> +		if (mddev->deleted)
>> +			continue;
>
> Any particular reason why you can't use the 'mddev_get()' / 'mddev_put()' 
> sequence here?

Mostly because it would be pretty mess.  mdev_put takes all_mddevs_lock,
so we'd have to add an unlock/relock cycle for each loop iteration.

> After all, I don't think that 'mddev' should vanish while being in this 
> loop, no?

It won't, at least without the call to mddev_put.  Once mddev_put is
in the game things aren't that easy, and I suspect the exising and
new code might have bugs in that area in the reboot notifier and
md_exit for extreme corner cases.
