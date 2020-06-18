Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555ED1FF8E8
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 18:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgFRQMw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 12:12:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:33804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgFRQMv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 12:12:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E25F4AC9F;
        Thu, 18 Jun 2020 16:12:49 +0000 (UTC)
Date:   Thu, 18 Jun 2020 18:12:49 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 06/12] blk-mq: merge the softirq vs non-softirq IPI logic
Message-ID: <20200618161249.aixopr52bnxugjvp@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-7-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 08:44:46AM +0200, Christoph Hellwig wrote:
> Both the softirq path for single queue devices and the multi-queue
> completion handler share the same logic to figure out if we need an
> IPI for the completion and eventually issue it.  Merge the two
> versions into a single unified code path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
