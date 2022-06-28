Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B023955C8E7
	for <lists+linux-block@lfdr.de>; Tue, 28 Jun 2022 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244137AbiF1Et6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jun 2022 00:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244407AbiF1Et5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 00:49:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3885013CEF
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 21:49:51 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BFF7568AA6; Tue, 28 Jun 2022 06:49:39 +0200 (CEST)
Date:   Tue, 28 Jun 2022 06:49:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 8/8] nvme: Enable pipelining of zoned writes
Message-ID: <20220628044939.GA22504@lst.de>
References: <20220627234335.1714393-1-bvanassche@acm.org> <20220627234335.1714393-9-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627234335.1714393-9-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 27, 2022 at 04:43:35PM -0700, Bart Van Assche wrote:
> Enabling pipelining for zoned writes. Increase the number of retries
> for zoned writes to the maximum number of outstanding commands per hardware
> queue.

How is this supposed to work?  NVMe controllers are completely free
to reorder.  It also doesn't make sense as all zoned writes in Linux
either use zone append or block layer based zone locking.
