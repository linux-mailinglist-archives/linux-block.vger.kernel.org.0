Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4073E0E7C
	for <lists+linux-block@lfdr.de>; Thu,  5 Aug 2021 08:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhHEGjg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Aug 2021 02:39:36 -0400
Received: from verein.lst.de ([213.95.11.211]:49348 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhHEGjg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Aug 2021 02:39:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 87C9C67373; Thu,  5 Aug 2021 08:39:19 +0200 (CEST)
Date:   Thu, 5 Aug 2021 08:39:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Martijn Coenen <maco@android.com>
Subject: Re: [PATCH v2 2/3] loop: Select I/O scheduler 'none' from inside
 add_disk()
Message-ID: <20210805063919.GA32686@lst.de>
References: <20210803182304.365053-1-bvanassche@acm.org> <20210803182304.365053-3-bvanassche@acm.org> <20210804053527.GA5711@lst.de> <c6337526-8f25-7efc-96ff-fbfe054fe9c0@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6337526-8f25-7efc-96ff-fbfe054fe9c0@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 04, 2021 at 10:58:01AM -0700, Bart Van Assche wrote:
> On 8/3/21 10:35 PM, Christoph Hellwig wrote:
>> On Tue, Aug 03, 2021 at 11:23:03AM -0700, Bart Van Assche wrote:
>>> We noticed that the user interface of Android devices becomes very slow
>>> under memory pressure. This is because Android uses the zram driver on top
>>> of the loop driver for swapping,
>>
>> Sorry, but that is just amazingly stupid.  If you really want to swap
>> to compressed files introduce that support in the swap code instead of
>> coming up with dumb driver stacks from hell.
>
> Hi Christoph,
>
> That's an interesting suggestion. We can look into adding compression 
> support in the swap code.

As a short term fix you might also just look into having a file
backing for the zram writeback mode, which should not need more than
100-200 lines of code.

> Independent of the use case of this patch, is it acceptable to change the 
> default I/O scheduler of loop devices from mq-deadline into none (patches 1 
> and 2 of this series)?

Yes, that might not be a bad idea in general.
