Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53C0413090
	for <lists+linux-block@lfdr.de>; Tue, 21 Sep 2021 11:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhIUJI5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Sep 2021 05:08:57 -0400
Received: from verein.lst.de ([213.95.11.211]:55558 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229533AbhIUJI5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 05:08:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC52767373; Tue, 21 Sep 2021 11:07:26 +0200 (CEST)
Date:   Tue, 21 Sep 2021 11:07:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 4/4] block: keep q_usage_counter in atomic mode after
 del_gendisk
Message-ID: <20210921090726.GA336@lst.de>
References: <20210920112405.1299667-1-hch@lst.de> <20210920112405.1299667-5-hch@lst.de> <cc552293-f203-5d0a-b39b-94502bb1ec16@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc552293-f203-5d0a-b39b-94502bb1ec16@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 08:29:49PM -0700, Bart Van Assche wrote:
>>   	blk_mq_unfreeze_queue(q);
>>     	if (!(disk->flags & GENHD_FL_HIDDEN)) {
>
> I don't see any code that passes 'true' as second argument to
> __blk_mq_unfreeze_queue()? Did I perhaps overlook something?

No, I did not finish actually implementing the suggestion from
Ming properly, sorry.
