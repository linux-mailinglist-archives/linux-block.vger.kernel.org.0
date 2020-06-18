Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DD51FF5B0
	for <lists+linux-block@lfdr.de>; Thu, 18 Jun 2020 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbgFROuX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jun 2020 10:50:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:46956 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbgFROuX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 10:50:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 30632AD63;
        Thu, 18 Jun 2020 14:50:21 +0000 (UTC)
Date:   Thu, 18 Jun 2020 16:50:21 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 02/12] blk-mq: factor out a helper to reise the block
 softirq
Message-ID: <20200618145021.7bl7naiix5gf5bag@beryllium.lan>
References: <20200611064452.12353-1-hch@lst.de>
 <20200611064452.12353-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611064452.12353-3-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 11, 2020 at 08:44:42AM +0200, Christoph Hellwig wrote:
> Add a helper to deduplicate the logic that raises the block softirq.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
