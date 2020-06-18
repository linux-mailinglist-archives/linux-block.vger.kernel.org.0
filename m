Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272F01FF7FB
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgFRPuD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 11:50:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:33378 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbgFRPuC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 11:50:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50604AF4C;
        Thu, 18 Jun 2020 15:50:01 +0000 (UTC)
Date:   Thu, 18 Jun 2020 17:50:01 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 04/12] blk-mq: complete polled requests directly
Message-ID: <20200618155001.anayfvmkhrejxtc4@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-5-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 08:44:44AM +0200, Christoph Hellwig wrote:
> Even for single queue devices there is no point in offloading a polled
> completion to the softirq, given that blk_mq_force_complete_rq is called
> from the polling thread in that case and thus there are no starvation
> issues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
