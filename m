Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CC263C276
	for <lists+linux-block@lfdr.de>; Tue, 29 Nov 2022 15:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiK2O2h (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Nov 2022 09:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbiK2O2d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 09:28:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945FD2AE0
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:28:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3472A61761
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 14:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191BDC433D6;
        Tue, 29 Nov 2022 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669732111;
        bh=HkEU1+9tgYVEGam9m2b9sn+qf1Iht+T/ZI36+M1KNWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXBEppicUuEOxUYAyZbyMLqN6XTvu8wNTnv2nrCgOSGync0rca16SCEJ8yIXciE9d
         JjB0QtEZ0NekSE8xKTflRtaTP/YqtAUHg3hMz9wSRu02kcpuCoj27A2qSUuu3zYi6/
         C5d8OhAGU90gVeYaoEq2sdMzuCZYLROtkJWEzFx9Yd1vl2cBPHggZg1JesANIlVGyH
         ZFJvrny/nTfuBmtapYaeljv2WzmpOJaNu4Bc3ToIOEqNi2/zPehT8fg9XNuZwLRtSo
         0NFlUWul1wgWbVN4C90fbgyuoX3aXNId1oecztxPevrghA5XNHh2Zu8NMNKI6R1JLK
         iCwMu8aUGZBog==
Date:   Tue, 29 Nov 2022 07:28:28 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme: introduce nvme_start_request
Message-ID: <Y4YXDAZDZQbnLIbF@kbusch-mbp.dhcp.thefacebook.com>
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003094344.242593-2-sagi@grimberg.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 03, 2022 at 12:43:43PM +0300, Sagi Grimberg wrote:
>  
> +void nvme_start_request(struct request *rq)
> +{
> +	blk_mq_start_request(rq);
> +}
> +EXPORT_SYMBOL_GPL(nvme_start_request);

Looks good, other than I feel this should be a static inline function in
nvme.h instead.

Reviewed-by: Keith Busch <kbusch@kernel.org>
