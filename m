Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF61767594
	for <lists+linux-block@lfdr.de>; Fri, 28 Jul 2023 20:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjG1Sj1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Jul 2023 14:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjG1Sj0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 14:39:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE91423B
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 11:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88FBA621DA
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 18:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6659C433C8;
        Fri, 28 Jul 2023 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569565;
        bh=5ck0T7GcUUUcyKceqYUMI9puT5CLRiZaq1dO4YyhqhQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P149NRT060ljm7Xxt1JllCLFz+blsFwpKKGiZ/RYH49MZZVhuNJHbtrXMkyEZsw5x
         5F5xgVOIjzq8W7QaY6+DfHtYCSquWdgfHXYdW+Sk63ZAmdPJz19Wh+f45WDScPZYYo
         2xDwyonVWogq9b0KJNUvVrRndegVGV2V3g4cuqFKWbUbardCyyt+kweOy6y85mI98j
         B0F6uSp1x9zw9DzEE3CKjlHFz5+qQhtXtsyGvUaNMTICgt7TKCd7brAPGZPhdpj/L5
         +lpG454WR5j2U+JgAvTkPA1hPqo0wQn96FFabav3cC+5IZu51B2nXOh/ERIbeodEwy
         wEt+QCu8UbgZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2661C43169;
        Fri, 28 Jul 2023 18:39:24 +0000 (UTC)
Subject: Re: [git pull] device mapper fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMLWgk816vYI3j11@redhat.com>
References: <ZMLWgk816vYI3j11@redhat.com>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZMLWgk816vYI3j11@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.5/dm-fixes
X-PR-Tracked-Commit-Id: 1e4ab7b4c881cf26c1c72b3f56519e03475486fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c75981a1be350f14dbfca56e62bea077dafdad96
Message-Id: <169056956485.21363.11768008607343065923.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jul 2023 18:39:24 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Joe Thornber <ejt@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Yu Kuai <yukuai3@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 27 Jul 2023 16:41:38 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.5/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c75981a1be350f14dbfca56e62bea077dafdad96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
