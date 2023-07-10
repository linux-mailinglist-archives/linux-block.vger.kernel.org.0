Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7332E74D968
	for <lists+linux-block@lfdr.de>; Mon, 10 Jul 2023 17:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjGJPB1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Jul 2023 11:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjGJPB0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 11:01:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1662C7
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 08:01:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 583B96104B
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 15:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB4CC433C7;
        Mon, 10 Jul 2023 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689001282;
        bh=fRniq925/5zOlOsSs3vy00RTNDr5SQ90nOWzhxQwy44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=goIqko9ctMkpwlHwPBBnArM5z7bEJy+aEkxJEa0sj0f28/6tmmbSnmeWOqhVGEKx4
         blerIqBKU53ucaBr6UM852wojaFiujKGFl6XKW+ytyOh1enfu6LQ8Sr6m6kM6/M2xA
         LW2dyijuq3MySWPH/RFFMypJQlXbgbE1+dcGdUaf/wiRQ0+vhbkWB2Ltjoli734L7o
         7snAA5m0JRC1YVups9uhmtFgNJUULP9OqvlI3bCCUqNJJmnbTlund8pcBZvQz4U4BH
         RuHEnnwVbdkaIEoen6H+VuZlybCSCvb7LIIBIfYtwn/mebuXRYqZZHE1daUDNVBfV5
         e+zHMsegSXwPA==
Date:   Mon, 10 Jul 2023 09:01:20 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] block: don't unconditionally set max_discard_sectors
 in blk_queue_max_discard_sectors
Message-ID: <ZKwdQJB3X9OGjr9Y@kbusch-mbp.dhcp.thefacebook.com>
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707094616.108430-2-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 07, 2023 at 11:46:13AM +0200, Christoph Hellwig wrote:
>  {
>  	q->limits.max_hw_discard_sectors = max_discard_sectors;
> -	q->limits.max_discard_sectors = max_discard_sectors;
> +	if (!q->limits.max_discard_sectors ||
> +	     q->limits.max_discard_sectors > max_discard_sectors)
> +		q->limits.max_discard_sectors = max_discard_sectors;

Could simplify to min_not_zero().

But this only allows you to make the limit smaller. If the user never
set max_discard_sectors before, and a firmware update allows a larger
max_hw_discard_sectors, the subsequent rescan won't use the new limit.
