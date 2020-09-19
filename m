Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE25270B4D
	for <lists+linux-block@lfdr.de>; Sat, 19 Sep 2020 08:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgISG6V (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 19 Sep 2020 02:58:21 -0400
Received: from verein.lst.de ([213.95.11.211]:35058 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgISG6V (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Sep 2020 02:58:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9D9B768BEB; Sat, 19 Sep 2020 08:58:16 +0200 (CEST)
Date:   Sat, 19 Sep 2020 08:58:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 03/12] drbd: remove RB_CONGESTED_REMOTE
Message-ID: <20200919065816.GA8237@lst.de>
References: <20200910144833.742260-1-hch@lst.de> <20200910144833.742260-4-hch@lst.de> <20200917095507.GJ7347@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917095507.GJ7347@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 17, 2020 at 11:55:07AM +0200, Jan Kara wrote:
> On Thu 10-09-20 16:48:23, Christoph Hellwig wrote:
> > This case isn't ever used.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Are you sure it's never used? As far as I'm reading drdb code the contents
> of the disk_conf structure seems to be received through netlink (that code
> is really a macro hell) and so read_balancing attribute passed to
> remote_due_to_read_balancing() can have any value userspace passed to it.

You are right, looking at how disk_conf is used I can't convince myself
that it is indeed not set through netlink and I've thus dropped the
patch.
