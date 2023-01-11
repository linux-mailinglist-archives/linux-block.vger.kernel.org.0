Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FFC6653F9
	for <lists+linux-block@lfdr.de>; Wed, 11 Jan 2023 06:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjAKFpx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Jan 2023 00:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjAKFpu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2023 00:45:50 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5792A127;
        Tue, 10 Jan 2023 21:45:49 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C335068BFE; Wed, 11 Jan 2023 06:45:45 +0100 (CET)
Date:   Wed, 11 Jan 2023 06:45:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v3 10/14] blk-mq: simplify flush check in
 blk_mq_dispatch_rq_list
Message-ID: <20230111054545.GB17158@lst.de>
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com> <20230111130159.3741753-11-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111130159.3741753-11-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if ((!list_empty(list) || ret != BLK_STS_OK))

Plase drop the double braces.
