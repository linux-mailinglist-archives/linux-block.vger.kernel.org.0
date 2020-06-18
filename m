Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE7F1FF90C
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 18:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgFRQSb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 12:18:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:42348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbgFRQSa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 12:18:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BA944AC9F;
        Thu, 18 Jun 2020 16:18:28 +0000 (UTC)
Date:   Thu, 18 Jun 2020 18:18:28 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infrdead.org
Subject: Re: [PATCH 07/12] blk-mq: move failure injection out of
 blk_mq_complete_request
Message-ID: <20200618161828.lwrtsd7ba2g2alxy@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-8-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 08:44:47AM +0200, Christoph Hellwig wrote:
> Move the call to blk_should_fake_timeout out of blk_mq_complete_request
> and into the drivers, skipping call sites that are obvious error
> handlers, and remove the now superflous blk_mq_force_complete_rq helper.
> This ensures we don't keep injecting errors into completions that just
> terminate the Linux request after the hardware has been reset or the
> command has been aborted.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
