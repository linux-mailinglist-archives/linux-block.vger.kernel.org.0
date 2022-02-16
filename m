Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04D44B8C92
	for <lists+linux-block@lfdr.de>; Wed, 16 Feb 2022 16:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbiBPPhk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Feb 2022 10:37:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiBPPhj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 10:37:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89CC286B47
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 07:37:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 774D3B81F31
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 15:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EDBC004E1;
        Wed, 16 Feb 2022 15:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645025845;
        bh=I+IHN3QtzQgKlFIznUtesTPsmN7eEeSUDNFEEEklp9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MuGqmnIb7BpYuRfUZZSdFx8Ua5Yt89S2MSLSXX76BqSbl8l/bBGnXSwcuE7eggss1
         bxSZHfnAqPffhQgRM1Id6AT2bNhZhrill7s/0wc6fOo9uUveH2gUl3UXSzvEn0er92
         Rn6u1UJSIydpWFPUvZAuhq3q7YdfYnCVdoT1VoWB1YxdVIgQ7NKdW7hsBc1MUqlakM
         kOJ+ezZ637As5qiZQ78ZUWD2y6MW7DrOy3TbuQWK9LFUMkdm+NRwwTWXUB1fBEX9pB
         L1nzgT0OjFoUmMwPDRGjgRYrlc0LVawmggLGQNYQ7l8asoZo0WDd03hbGXOUtY81M7
         N4bbHD9S/xGIw==
Date:   Wed, 16 Feb 2022 07:37:22 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, markus.bloechl@ipetronik.com,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: skip the fsync_bdev call in del_gendisk for
 surprise removals
Message-ID: <20220216153722.GB1936276@dhcp-10-100-145-180.wdc.com>
References: <20220216150901.4166235-1-hch@lst.de>
 <20220216150901.4166235-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216150901.4166235-2-hch@lst.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 04:09:01PM +0100, Christoph Hellwig wrote:
> -	fsync_bdev(disk->part0);
> +	/*
> +	 * If this is not a surprise removal see if there is a file system
> +	 * mounted on this device and sync it (although this won't work for
> +	 * partitions).  For surprise removals that have already marked the
> +	 * disk dead skip this call as no I/O is possible anyway.
> +	 */
> +	if (!test_bit(GD_DEAD, &disk->state))
> +		fsync_bdev(disk->part0);
>  	__invalidate_device(disk->part0, true);

It used to be that any dirty pages would attempt to write, and get an
error on a surprise removal. Now that you're skipping the fsync_bdev(),
is something else taking responsibility to error those pages?
