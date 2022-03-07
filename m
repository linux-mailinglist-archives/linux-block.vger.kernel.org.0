Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740654CF26E
	for <lists+linux-block@lfdr.de>; Mon,  7 Mar 2022 08:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbiCGHLo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Mar 2022 02:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbiCGHLo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 02:11:44 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5ED60AB9
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 23:10:50 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C60368AA6; Mon,  7 Mar 2022 08:10:48 +0100 (CET)
Date:   Mon, 7 Mar 2022 08:10:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 5/6] blk-mq: prepare for implementing hctx table via
 xarray
Message-ID: <20220307071048.GB32227@lst.de>
References: <20220307064401.30056-1-ming.lei@redhat.com> <20220307064401.30056-6-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307064401.30056-6-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Even if I still think this would make more sense as part of the next
patch, the mechanical changes do look fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
