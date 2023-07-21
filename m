Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9202C75C4D2
	for <lists+linux-block@lfdr.de>; Fri, 21 Jul 2023 12:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjGUKkd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Jul 2023 06:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGUKk0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 06:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EA61701
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 03:40:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 825C560C74
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FC0C433C8;
        Fri, 21 Jul 2023 10:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689936024;
        bh=lbY2BvmhAbRpBV+VqE0aeWXR/GxnLzJi5ImdL4n74fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/VR4NG5my3xoS12c/bv4v5KEhtmq5gMvnKUbICIpu52vXf+L3Yf7D22yCOxrzlKw
         ghwXOLF1OM/GufsQXKXyxhDOBg4RTh/jeUxA1MVfcCVh6plpOphrSveOIRjhLmOgiW
         Iq9EtQfn8dwclGp6oeDNvnxj1bvhdAH0g6Mplt023i0r/54qGyZIlm4rfk4IEPj04P
         lMgknkHDbowX69uQNQz/TgG43MV1qg8O+3tdhnOFEz/xnGdBEQljbhVkb8nRIyNIDm
         aHv99sOBEln2NFdQScGsrP9cd/Ph7ZCY6ebBpCiZ9f2K0kv5/SXsvVAbvgdHnCsV3F
         b5CAUf9/uWVQQ==
Date:   Fri, 21 Jul 2023 12:40:19 +0200
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        David Jeffery <djeffery@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
Message-ID: <ZLpgk95AQSnKWg+o@kbusch-mbp.dhcp.thefacebook.com>
References: <20230721095715.232728-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721095715.232728-1-ming.lei@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 21, 2023 at 05:57:15PM +0800, Ming Lei wrote:
> From: David Jeffery <djeffery@redhat.com>

...
 
> Cc: David Jeffery <djeffery@redhat.com>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: Gabriel Krisman Bertazi <krisman@suse.de>
> Cc: Chengming Zhou <zhouchengming@bytedance.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Shouldn't the author include their sign off? Or is this supposed to be
from you?
