Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370E1578331
	for <lists+linux-block@lfdr.de>; Mon, 18 Jul 2022 15:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiGRNIY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Jul 2022 09:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235254AbiGRNIX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 09:08:23 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7C26110
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 06:08:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 87B9E68AA6; Mon, 18 Jul 2022 15:08:08 +0200 (CEST)
Date:   Mon, 18 Jul 2022 15:08:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: call blk_mq_exit_queue from disk_release
 for never added disks
Message-ID: <20220718130808.GB19204@lst.de>
References: <20220718062928.335399-1-hch@lst.de> <YtUJXGhFBw5yrf7N@T590> <YtUa3f2Z3xra9gTG@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtUa3f2Z3xra9gTG@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 04:33:33PM +0800, Ming Lei wrote:
> > Request queue is allocated successfully, but disk allocation may fail,
> > so blk_mq_exit_queue still may be missed in this case.
> 
> Or we do have request queue uses without disk attached, such as nvme
> admin/connection queue.

All these need to call blk_mq_destroy_queue anyway, and as far as I
can tell do that already.
