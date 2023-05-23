Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB570D4DB
	for <lists+linux-block@lfdr.de>; Tue, 23 May 2023 09:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235226AbjEWHXY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 May 2023 03:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjEWHXW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:23:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FF11B5
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:22:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4E7AA6732D; Tue, 23 May 2023 09:22:31 +0200 (CEST)
Date:   Tue, 23 May 2023 09:22:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com
Subject: Re: [PATCH v3 6/7] dm: Inline __dm_mq_kick_requeue_list()
Message-ID: <20230523072230.GF8758@lst.de>
References: <20230522183845.354920-1-bvanassche@acm.org> <20230522183845.354920-7-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522183845.354920-7-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
