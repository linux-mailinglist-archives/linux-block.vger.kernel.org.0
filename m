Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12F5639359
	for <lists+linux-block@lfdr.de>; Sat, 26 Nov 2022 03:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiKZCZp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 25 Nov 2022 21:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiKZCZo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Nov 2022 21:25:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583A72FC17
        for <linux-block@vger.kernel.org>; Fri, 25 Nov 2022 18:25:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA92F611D5
        for <linux-block@vger.kernel.org>; Sat, 26 Nov 2022 02:25:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EAD5C433B5;
        Sat, 26 Nov 2022 02:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669429539;
        bh=Tr45JbFLxBCN4Lw2zxrydTtks7YnFmPEI3HAgUgr9R0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tahoWcqaqd2nIOelAOgteDKDG+doELyIPeLJXObX4l2aEu4K+fUarJ9hVPHOjhqFn
         MHMHEV84OpK1+sFA6XED2dz6jsb1eNQp6Mg5LW73IlHgozQDOWjzh98S+DHSfu78t6
         OnUGY20btegbHYrilT2htHFc+mrVbhZ/O+RTSzZ/Pqr+1FKI/4aM1jwd0PJm8R/Diz
         Bn2wsjdi4Bza8ohTifVOmRvdoqq3a7Z2hRhqCj4b8rfE9+H1a79OY4B3K9z+4JmrOz
         pWbppAZsMnsdicbINLzrl1LWBFHJS+bBNmShPhPFuRSdwooK/DSzg3auDVaTs9NYp4
         LDXU3+6Tn9W7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CD09C395EC;
        Sat, 26 Nov 2022 02:25:39 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b46333b8-a233-8e8b-c688-2c579868872f@kernel.dk>
References: <b46333b8-a233-8e8b-c688-2c579868872f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b46333b8-a233-8e8b-c688-2c579868872f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.1-2022-11-25
X-PR-Tracked-Commit-Id: 7d4a93176e0142ce16d23c849a47d5b00b856296
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 990f320031209ecfdb1bef33798970506d10dae8
Message-Id: <166942953930.27056.5022038480606801556.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Nov 2022 02:25:39 +0000
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

The pull request you sent on Fri, 25 Nov 2022 17:19:05 -0700:

> git://git.kernel.dk/linux.git tags/block-6.1-2022-11-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/990f320031209ecfdb1bef33798970506d10dae8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
