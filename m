Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E751D6665
	for <lists+linux-block@lfdr.de>; Sun, 17 May 2020 09:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgEQHI5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 17 May 2020 03:08:57 -0400
Received: from verein.lst.de ([213.95.11.211]:34209 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726956AbgEQHI5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 May 2020 03:08:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 23CA468C4E; Sun, 17 May 2020 09:08:54 +0200 (CEST)
Date:   Sun, 17 May 2020 09:08:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/6] blk-mq: improvement CPU hotplug(simplified version)
Message-ID: <20200517070853.GA30271@lst.de>
References: <20200515014153.2403464-1-ming.lei@redhat.com> <20200516123555.GA13448@lst.de> <CACVXFVNou_dMjzxYs-4KvbKmBnrqaBk2sG2pqWuJeLeh_tZoug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACVXFVNou_dMjzxYs-4KvbKmBnrqaBk2sG2pqWuJeLeh_tZoug@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, May 17, 2020 at 12:08:40PM +0800, Ming Lei wrote:
> On Sat, May 16, 2020 at 8:37 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > I took at stab at the series this morning, and fixed the fabrics
> > crash (blk_mq_alloc_request_hctx passed the cpumask of a NULL hctx),
> > and pre-loaded a bunch of cļeanups to let your changes fit in better.
> >
> > Let me know what you think, the git branch is here:
> >
> >     git://git.infradead.org/users/hch/block.git blk-mq-hotplug
> >
> > Gitweb:
> >
> >     http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug
> >
> 
> I think the approach is fine, especially the driver tag related
> change, that was in my mind too, :-)
> 
> I guess you will post them all soon, and I will take a close look
> after they are out.

Let me know what you prefer - either I can send it out or you can
pick the series up.
