Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EEC78D2A2
	for <lists+linux-block@lfdr.de>; Wed, 30 Aug 2023 05:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbjH3D7Q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Aug 2023 23:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238703AbjH3D6s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Aug 2023 23:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E5AEA
        for <linux-block@vger.kernel.org>; Tue, 29 Aug 2023 20:58:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02E8360ACF
        for <linux-block@vger.kernel.org>; Wed, 30 Aug 2023 03:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A92DC433C7;
        Wed, 30 Aug 2023 03:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693367924;
        bh=4fr1+bxxZAZ105E6KiBRzbBcwkFos5erHn4Z2bZiZ8A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CbdI8CzvrPw+EeB4fw8k2VnxgvKabM1VvBB7A7aCy6KBbMElq9U06lZCh8LV1CuHT
         TSyx8uZtH4WjN5fjgMlGiJkl/OZyWOswzyOYuHGFIiToj/pFfU6I3Q9wbFllgFwqeK
         3gNXS/zYxpOKQolC6tm/YSVsrd2WiufXHwVFGaGdsX5cWp+yagmRuDIxsb+RhnMeia
         mhbLP00j+8NcwAkhpXVWbPvNfonBBOqMySNsy8gRk9nH0PmMDEyqhpwCNJHMi8pkUV
         DtdBQEzt5rVFhWPcwkC4SqcRsRgeZOqOGrqxLs+AqP5k2SFprqJzG/QnDg3mUuZa20
         TCePwwI4lm8Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58913E29F34;
        Wed, 30 Aug 2023 03:58:44 +0000 (UTC)
Subject: Re: [GIT PULL] Block updates for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <843290f8-4b62-439a-b2e4-0b71ed20391e@kernel.dk>
References: <843290f8-4b62-439a-b2e4-0b71ed20391e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <843290f8-4b62-439a-b2e4-0b71ed20391e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.6/block-2023-08-28
X-PR-Tracked-Commit-Id: 146afeb235ccec10c17ad8ea26327c0c79dbd968
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d3dfeb3aec7b612d266d500c82054f1fded4980
Message-Id: <169336792435.6268.11481283434602515679.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 03:58:44 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 13:58:17 -0600:

> git://git.kernel.dk/linux.git tags/for-6.6/block-2023-08-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d3dfeb3aec7b612d266d500c82054f1fded4980

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
