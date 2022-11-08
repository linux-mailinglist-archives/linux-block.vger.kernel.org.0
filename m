Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C108620985
	for <lists+linux-block@lfdr.de>; Tue,  8 Nov 2022 07:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiKHGU6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Nov 2022 01:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiKHGUh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 01:20:37 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24774419AA
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 22:20:34 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E884E68C7B; Tue,  8 Nov 2022 07:20:30 +0100 (CET)
Date:   Tue, 8 Nov 2022 07:20:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: remove blk_mq_alloc_tag_set_tags
Message-ID: <20221108062030.GA19853@lst.de>
References: <20221107061706.1269999-1-hch@lst.de> <97c6c6b7-1de5-a341-e24c-f18e62aeaae7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c6c6b7-1de5-a341-e24c-f18e62aeaae7@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 07, 2022 at 09:20:37PM -0700, Jens Axboe wrote:
> Getting rid of the helper is nice, but the realloc one is badly
> named imho. Can we rename that while at it? There are only 1
> caller after this anyway.

Tell me your preferred name and I'll do it.
