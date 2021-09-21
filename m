Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4B4413093
	for <lists+linux-block@lfdr.de>; Tue, 21 Sep 2021 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhIUJJl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Sep 2021 05:09:41 -0400
Received: from verein.lst.de ([213.95.11.211]:55564 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhIUJJl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 05:09:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A235367373; Tue, 21 Sep 2021 11:08:11 +0200 (CEST)
Date:   Tue, 21 Sep 2021 11:08:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: tear down file system I/O in del_gendisk
Message-ID: <20210921090811.GB336@lst.de>
References: <20210920112405.1299667-1-hch@lst.de> <89982489-a063-0536-2a35-7420d71fc939@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89982489-a063-0536-2a35-7420d71fc939@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 08:38:31PM -0700, Bart Van Assche wrote:
> On 9/20/21 04:24, Christoph Hellwig wrote:
>> Ming reported that for SCSI we have a lifetime problem now that
>> the BDI moved from the request_queue to the disk as del_gendisk
>> doesn't finish all outstanding file system I/O.  It turns out
>> this actually is an older problem, although the case where it could
>> be hit before was very unusual (unbinding of a SCSI upper driver
>> while the scsi_device stays around).  This series fixes this by
>> draining all I/O in del_gendisk.
>
> Several failures are reported when running blktests against Jens' for-next
> branch if KASAN and lockdep are enabled. Is this patch series sufficient
> to make blktests pass again?

I don't see any new failures (I have a few consistent ones due to the
fact that blktests is completly fucked up and wants to load modules
everywhere which doesn't exactly work with builtin drivers).  Care
to post your issues?

