Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D9F4CF269
	for <lists+linux-block@lfdr.de>; Mon,  7 Mar 2022 08:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiCGHLO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Mar 2022 02:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbiCGHLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 02:11:13 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C08541BD
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 23:10:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6A2168AA6; Mon,  7 Mar 2022 08:10:16 +0100 (CET)
Date:   Mon, 7 Mar 2022 08:10:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 3/6] blk-mq: reconfigure poll after queue map is
 changed
Message-ID: <20220307071016.GA32227@lst.de>
References: <20220307064401.30056-1-ming.lei@redhat.com> <20220307064401.30056-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307064401.30056-4-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 07, 2022 at 02:43:58PM +0800, Ming Lei wrote:
> queue map can be changed when updating nr_hw_queues, so we need to
> reconfigure queue's poll capability. Add one helper for doing this job.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Eventually we'd want to reuse this for nvme-multipath as already pointed
out.  But I'm fine with just fixing this up later, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>
