Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8621E7D25
	for <lists+linux-block@lfdr.de>; Fri, 29 May 2020 14:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgE2M0y (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 29 May 2020 08:26:54 -0400
Received: from verein.lst.de ([213.95.11.211]:32774 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgE2M0x (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 May 2020 08:26:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F0F8468B02; Fri, 29 May 2020 14:26:50 +0200 (CEST)
Date:   Fri, 29 May 2020 14:26:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv2 1/2] blk-mq: export __blk_mq_complete_request
Message-ID: <20200529122650.GA28107@lst.de>
References: <20200528151931.3501506-1-kbusch@kernel.org> <20200528164256.GA25651@lst.de> <20200528181807.GA3504306@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528181807.GA3504306@dhcp-10-100-145-180.wdl.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 28, 2020 at 11:18:07AM -0700, Keith Busch wrote:
> On Thu, May 28, 2020 at 06:42:56PM +0200, Christoph Hellwig wrote:
> > I think this needs a better name.
> 
> blk_mq_do_complete_req()?

do isn't exactly descriptive, is it?

blk_mq_force_complete_request maybe?

And yes, I think for 5.9 we need to lift the error injection into the
callers, this is a mess..
