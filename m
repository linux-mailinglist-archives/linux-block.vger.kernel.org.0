Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2756F2E75
	for <lists+linux-block@lfdr.de>; Mon,  1 May 2023 06:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjEAEfb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 1 May 2023 00:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjEAEfa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 May 2023 00:35:30 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D55E76
        for <linux-block@vger.kernel.org>; Sun, 30 Apr 2023 21:35:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A35D68B05; Mon,  1 May 2023 06:35:27 +0200 (CEST)
Date:   Mon, 1 May 2023 06:35:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v3 7/9] block: mq-deadline: Track the dispatch position
Message-ID: <20230501043526.GB19847@lst.de>
References: <20230424203329.2369688-1-bvanassche@acm.org> <20230424203329.2369688-8-bvanassche@acm.org> <20230428055005.GH8549@lst.de> <393d9f71-da77-a1fe-5b63-d8afa92dad90@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <393d9f71-da77-a1fe-5b63-d8afa92dad90@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 28, 2023 at 01:04:01PM -0700, Bart Van Assche wrote:
> "Track the position (sector_t) of the most recently dispatched request
> instead of tracking a pointer to the next request to dispatch. This
> patch is the basis for patch "Handle requeued requests correctly".
> Without this patch it would me significantly more complicated to start

s/me/be/
