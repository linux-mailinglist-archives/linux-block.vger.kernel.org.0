Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E38767595
	for <lists+linux-block@lfdr.de>; Fri, 28 Jul 2023 20:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjG1Sj2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Jul 2023 14:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjG1Sj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jul 2023 14:39:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B6423C
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 11:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCAC4621DD
        for <linux-block@vger.kernel.org>; Fri, 28 Jul 2023 18:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 308F6C433C9;
        Fri, 28 Jul 2023 18:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690569565;
        bh=PPXD+1IpFMaf04lizdH1J9hZ2lEd6A9GIQmYlPZucPU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cBU5Vfs1wFz8uNNbK2Cpd92IGnisswfOOSGDM/oQU5KivDR67IYDQ3wjTelIoEzgy
         WlHU2/kNp+dFub1FeaTD8ZLzMrz+NJv43KPotAoV+REs9T56nca6I5HseR4FBoXuJ+
         2QAoCklaKLZiL8qjXqocGuAZhvAYZB/fCSkhjki9uBf1lYU4rcpmDNN+ySZeya7OwC
         SCV0Ooa8a8/EsE6gRVyQhiUnyKV4NR2Emt/BUioEiBXGz2bEKrnzZkbqzOetwKESWj
         ABtiNbV/IqMerkY6q31IvH+9qwrQGau9G8cDF5sEU70wymeHhzyP+bleuTI/gtYbiq
         JmCzMJuOWOIzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 19DA6C43169;
        Fri, 28 Jul 2023 18:39:25 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7ffe03ab-339e-be10-c6e8-7294e4c35bb4@kernel.dk>
References: <7ffe03ab-339e-be10-c6e8-7294e4c35bb4@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7ffe03ab-339e-be10-c6e8-7294e4c35bb4@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.5-2023-07-28
X-PR-Tracked-Commit-Id: 3e9dce80dbf91972aed972c743f539c396a34312
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 818680d154170b4e41dc0c1a10e20bc03ca14a00
Message-Id: <169056956510.21363.16449823541247932697.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Jul 2023 18:39:25 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 28 Jul 2023 09:08:56 -0600:

> git://git.kernel.dk/linux.git tags/block-6.5-2023-07-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/818680d154170b4e41dc0c1a10e20bc03ca14a00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
