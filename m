Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647F61D631B
	for <lists+linux-block@lfdr.de>; Sat, 16 May 2020 19:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgEPRbx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 May 2020 13:31:53 -0400
Received: from verein.lst.de ([213.95.11.211]:32929 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgEPRbx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 13:31:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1902368B05; Sat, 16 May 2020 19:31:51 +0200 (CEST)
Date:   Sat, 16 May 2020 19:31:50 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] blk-mq: remove a pointless queue enter pair in
 blk_mq_alloc_request_hctx
Message-ID: <20200516173150.GA21867@lst.de>
References: <20200516153430.294324-1-hch@lst.de> <20200516153430.294324-4-hch@lst.de> <87513e5c-270c-41cf-51d8-9106351449b5@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87513e5c-270c-41cf-51d8-9106351449b5@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 16, 2020 at 09:28:22AM -0700, Bart Van Assche wrote:
> This change looks wrong to me. blk_mq_update_nr_hw_queues() modifies
> q->queue_hw_ctx so q_usage_counter must be incremented before that
> pointer is dereferenced.

True, I'll drop that part.
