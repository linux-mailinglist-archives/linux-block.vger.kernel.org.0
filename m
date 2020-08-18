Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54F247EE5
	for <lists+linux-block@lfdr.de>; Tue, 18 Aug 2020 09:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHRHA4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Aug 2020 03:00:56 -0400
Received: from verein.lst.de ([213.95.11.211]:60417 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgHRHAo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 03:00:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 20B3A68B02; Tue, 18 Aug 2020 09:00:11 +0200 (CEST)
Date:   Tue, 18 Aug 2020 09:00:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Coly Li <colyli@suse.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Vlastimil Babka <vbabka@suse.com>
Subject: Re: [PATCH v5 1/3] net: introduce helper sendpage_ok() in
 include/linux/net.h
Message-ID: <20200818070010.GA2365@lst.de>
References: <20200816071518.6964-1-colyli@suse.de> <CAM_iQpUFtZdrhfUbuYYODNeSVqPOqx8mio6Znp6v3Q5iDZeyqg@mail.gmail.com> <20200817054538.GA11705@lst.de> <CAM_iQpWnzm=cQZvZMcjKXez1L55tSVfWyadP3d0CUaT=D4nOhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpWnzm=cQZvZMcjKXez1L55tSVfWyadP3d0CUaT=D4nOhw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 12:12:12PM -0700, Cong Wang wrote:
> 
> So netdev people will have to understand and support PageSlab() or
> page_count()?

Yes.  As they came up with that contrived rule what is acceptable
for sendpage.  No one else really knows and other subsystems like the
block layer are perfectly fine with it.

> 
> If it is unusual even for mm people, how could netdev people suppose
> to understand this unusual mm bug? At least not any better.

It is not a mm bug, it is a networking quirk.
