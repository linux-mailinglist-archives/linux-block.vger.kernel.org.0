Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58517245C50
	for <lists+linux-block@lfdr.de>; Mon, 17 Aug 2020 08:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgHQGPX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Aug 2020 02:15:23 -0400
Received: from verein.lst.de ([213.95.11.211]:55156 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgHQGPX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 02:15:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D9D667357; Mon, 17 Aug 2020 08:15:20 +0200 (CEST)
Date:   Mon, 17 Aug 2020 08:15:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de,
        baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/5] block: Move bio merge related functions
 into blk-merge.c
Message-ID: <20200817061519.GA12248@lst.de>
References: <cover.1597637287.git.baolin.wang@linux.alibaba.com> <2382836ce9fe3329d01758b67d779e598e093c55.1597637287.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2382836ce9fe3329d01758b67d779e598e093c55.1597637287.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 17, 2020 at 12:09:15PM +0800, Baolin Wang wrote:
> It's better to move bio merge related functions into blk-merge.c,
> which contains all merge related functions.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  block/blk-core.c  | 156 -----------------------------------------------------
>  block/blk-merge.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 157 insertions(+), 156 deletions(-)

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
