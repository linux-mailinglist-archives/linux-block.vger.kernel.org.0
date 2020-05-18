Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D581D7973
	for <lists+linux-block@lfdr.de>; Mon, 18 May 2020 15:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgERNQj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 May 2020 09:16:39 -0400
Received: from verein.lst.de ([213.95.11.211]:38470 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgERNQj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 09:16:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 555F968B02; Mon, 18 May 2020 15:16:35 +0200 (CEST)
Date:   Mon, 18 May 2020 15:16:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 5/9] blk-mq: don't set data->ctx and data->hctx in
 blk_mq_alloc_request_hctx
Message-ID: <20200518131634.GA645@lst.de>
References: <20200518093155.GB35380@T590> <87imgty15d.fsf@nanos.tec.linutronix.de> <20200518115454.GA46364@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518115454.GA46364@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 18, 2020 at 07:54:54PM +0800, Ming Lei wrote:
> 
> I guess I misunderstood your point, sorry for that.
> 
> The requirement is just that the request needs to be allocated on one online
> CPU after INACTIVE is set, and we can use a workqueue to do that.

I've looked over the code again, and I'm really not sure why we need that.
Presumable the CPU hotplug code ensures tasks don't get schedule on the
CPU running the shutdown state machine, so if we just do a retry of the
tag allocation we can assume we are on a different CPU now (Thomas,
correct me if that assumption is wrong).  So I think we can do entirely
with the preempt_disable and the smp calls.  Something like this branch,
which has only survived basic testing (the last patch is the pimary
interesting one, plus maybe the last 3 before that):

    git://git.infradead.org/users/hch/block.git blk-mq-hotplug.2

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug.2
