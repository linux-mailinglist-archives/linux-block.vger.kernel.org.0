Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B57FA164A83
	for <lists+linux-block@lfdr.de>; Wed, 19 Feb 2020 17:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBSQfR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Feb 2020 11:35:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34202 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgBSQfR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6fFwnchNTtoJZdymIq2kDBwwx7ctCqVhWsC6gdwe7fk=; b=KJMG4yMGCmTHDzMcMOvAJi/XsT
        SgH48vqxcLehIbrqJRYN9enIh4YFwtyLkoAblPHAs8rMSApphSp69cHLhZyxfw9BSJweZRsB+jerj
        H3azxMjN3zf/FFd5AVd/60a61O1B9jdJEZ68FDBHFiXxOHOoC4kYAEzx+5pUUAzLHTtot3XzrRS8J
        9LqPaGqoy4r5ajKP06O5MPs5+Lc3Pr6BwJvo6UrzIuBu9j6dJgyxJVGJq7ZS4RlKAGjMycWvMfim8
        IOC12aUCnz6nxHBtzW6q7qOWAsoC9/6ffnmz1igTWCwHcjDn0aLaH9WxPW9zBFygZXLNmG3ce/CPu
        DnfDQf7w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SJh-00072U-1s; Wed, 19 Feb 2020 16:35:17 +0000
Date:   Wed, 19 Feb 2020 08:35:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH] null_blk: fix spurious IO errors after failed past-wp
 access
Message-ID: <20200219163517.GD18377@infradead.org>
References: <20200212202320.GA2704@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212202320.GA2704@avx2>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 12, 2020 at 11:23:20PM +0300, Alexey Dobriyan wrote:
> Steps to reproduce:
> 
> 	BLKRESETZONE zone 0
> 
> 	// force EIO
> 	pwrite(fd, buf, 4096, 4096);
> 
> 	[issue more IO including zone ioctls]
> 
> It will start failing randomly including IO to unrelated zones because of
> ->error "reuse". Trigger can be partition detection as well if test is not
> run immediately which is even more entertaining.
> 
> The fix is of course to clear ->error where necessary.
> 
> Signed-off-by: Alexey Dobriyan (SK hynix) <adobriyan@gmail.com>
> ---
> 
>  drivers/block/null_blk_main.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -605,6 +605,7 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
>  	if (tag != -1U) {
>  		cmd = &nq->cmds[tag];
>  		cmd->tag = tag;
> +		cmd->error = BLK_STS_OK;

I'd place this line in null_queue_bio to match the blk-mq patch
more closely.

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you add your testcase to blktests?
