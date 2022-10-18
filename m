Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB1602F6A
	for <lists+linux-block@lfdr.de>; Tue, 18 Oct 2022 17:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJRPQz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Oct 2022 11:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJRPQy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 11:16:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15D586F98;
        Tue, 18 Oct 2022 08:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DAF44CE1E55;
        Tue, 18 Oct 2022 15:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C047C433D6;
        Tue, 18 Oct 2022 15:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666106210;
        bh=Jojqx8JmIXM8eX+9+/gLAMgo92LjQnmaGRkIZSiWd0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPjinHnLX6amH9fmO1CVFvKAW++ZJ7bxjK1h8STCygeyFBEkM3lTNO6VdZc8No5oD
         o4cv2fILT7O6tBsgp8+0CDpoHgk8pLVF6VtOOV0ZS9WF8cWDR63cOA9EB/YMHi2l9b
         vHYFGplWUR5l8pGcIBoinfAkKeWm8IBXKd9trGAqmYCG88PCUZDbZIOKmiiP7ahVGJ
         BnJqaFRIMRlV9DQnjNej1YvN5IpXK3Y48QgMsmMJAAktcwt4lfGt3NVSb7b9cH+/kp
         ROAac6dg+n2qqjSHUiBAbl9eKe8Uk/ahT1AAPBacyPyrCfHWW/0gYADoNUtAK9JNt5
         nmy8nDM9xskBg==
Date:   Tue, 18 Oct 2022 09:16:46 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: don't drop the queue reference in blk_mq_destroy_queue
Message-ID: <Y07DXuShbjGx1a8x@kbusch-mbp.dhcp.thefacebook.com>
References: <20221018135720.670094-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018135720.670094-1-hch@lst.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Series looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
