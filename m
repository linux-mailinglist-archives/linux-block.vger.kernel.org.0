Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CF760D7CE
	for <lists+linux-block@lfdr.de>; Wed, 26 Oct 2022 01:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJYXVC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Oct 2022 19:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJYXVA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 19:21:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B6C04
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 16:20:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56145B81DA1
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 23:20:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE70C433D6;
        Tue, 25 Oct 2022 23:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666740057;
        bh=gO/ynOO7i2b5Qqhbc/HkiA7PIk+9ylGQ51MJQUxPP2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qj4K39Qg/LnS2s5Q/ft8SG3WuAZqA305YbqfmLUr9wn/n7J4uV3uXLD90/E9FCFJy
         Ce4caosJT9jMRtc7SbKlUYx3PzU6rDUyVlD3zkdoSAhEd9vcAuazOdlmrhoUvcGUqI
         rW3yFIe09smk3l88+yaDLp7xvopugAqcsbSrx+f+1aMSuYGu2v12s2SOjdvOP9r+bb
         0Q5j1aXyXaPll48qX38PY1FOCWJ14uWfkIOtDad05v0xiNXwy+BjStTSK9JOWff8I2
         jkqsOOxTV3QBdafE61CKsN8GkSy8TdYGxsjjfJY58ru1OHMZA7EVWMtIuCNfRiwX74
         a1qxbgKcpyb/w==
Date:   Tue, 25 Oct 2022 17:20:54 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        oren@nvidia.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Message-ID: <Y1hvVpQcK1hxEKS2@kbusch-mbp.dhcp.thefacebook.com>
References: <20221002082851.13222-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002082851.13222-1-mgurtovoy@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 02, 2022 at 11:28:51AM +0300, Max Gurtovoy wrote:
> This makes the code more readable.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
