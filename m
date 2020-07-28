Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FFC22FDF8
	for <lists+linux-block@lfdr.de>; Tue, 28 Jul 2020 01:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgG0Xco (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Jul 2020 19:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:41120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0Xco (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 19:32:44 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A203D20809;
        Mon, 27 Jul 2020 23:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892764;
        bh=nKW56Q6BNIKHv+MQ+ujARc43W9v1hzOqKRZunVSdth0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DstyR3C2B3OCwIoZ/pcQIHgqjrstS0tWunDJnFBhM+bboTiuiDhJo0++zHLD+J4lK
         x9jqt+t8owg+UgJM3SFyRHBaCiByZR6XYje7WZMAQrlZmjoi1GMbEnIBGLghEI9C1z
         l5wp+2BLv41TIAtAOZEwVP3nMjrnNFzfoXLKcJUE=
Date:   Mon, 27 Jul 2020 16:32:41 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lin <mlin@kernel.org>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200727233241.GA797782@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727231022.307602-2-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 27, 2020 at 04:10:21PM -0700, Sagi Grimberg wrote:
> +static void blk_mq_quiesce_blocking_queue_async_wait(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	unsigned int i;
> +
> +	queue_for_each_hw_ctx(q, hctx, i) {
> +		WARN_ON_ONCE(!(hctx->flags & BLK_MQ_F_BLOCKING));
> +		if (!hctx->rcu_sync) {
> +			synchronize_srcu(hctx->srcu);
> +			continue;
> +		}
> +		wait_for_completion(&hctx->rcu_sync->completion);
> +		destroy_rcu_head(&hctx->rcu_sync->head);

Leaking rcu_sync, and not clearing it across quiesce contexts. Needs:

		kfree(hctx->rcu_sync);
		hctx->rcu_sync = NULL;
