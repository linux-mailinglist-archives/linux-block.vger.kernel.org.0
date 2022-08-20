Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44EA59AF51
	for <lists+linux-block@lfdr.de>; Sat, 20 Aug 2022 19:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiHTRzk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 20 Aug 2022 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiHTRzj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Aug 2022 13:55:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54412543C4
        for <linux-block@vger.kernel.org>; Sat, 20 Aug 2022 10:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 332F360D45
        for <linux-block@vger.kernel.org>; Sat, 20 Aug 2022 17:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 984E2C433C1;
        Sat, 20 Aug 2022 17:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661018137;
        bh=AhewupLB5dPmf98QW/esUSsJUsoDVcfWcwq+cSaPTck=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NNmEINX8B8zmKtQdBlCHyDWEw9bZyIHwqQ+WrcOZhlX1zyDsTrQQkfb+/hoPj6cJI
         wlym+0yA2ONUZ3xAKBFFHZk9xE9sKWbG1c+5fIpy8YdgDrjf0/t+ZK0aNrlF4upPNQ
         EfRq9/ilwJqgeg03CZjcBknOjnAXe2KAtw1phYXDeV0FENmY6QDLcHQMHlq9437NhB
         4bJ7DNftQhHOh0BD/Bnmg0Oy34488X27sbOG/el7Qd9HFNDliUNMkUb7qFQXSgLikv
         cNxaxa292WMBt0ny/jiPBZzX6kEn/ChXZv83q0eku0s+3f2HfEhPO9KRH2C/7MdOr1
         RiYYUFUzGQ0LA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 855D0E2A052;
        Sat, 20 Aug 2022 17:55:37 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <5934f325-077a-8786-2873-4cea178641ab@kernel.dk>
References: <5934f325-077a-8786-2873-4cea178641ab@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <5934f325-077a-8786-2873-4cea178641ab@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-6.0-2022-08-19
X-PR-Tracked-Commit-Id: d3b38596875dbc709b4e721a5873f4663d8a9ea2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9bce6e5533a08e0223d629541b4f39ffea48333
Message-Id: <166101813753.10395.7470520216202062650.pr-tracker-bot@kernel.org>
Date:   Sat, 20 Aug 2022 17:55:37 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 19 Aug 2022 11:22:52 -0600:

> git://git.kernel.dk/linux-block.git tags/block-6.0-2022-08-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9bce6e5533a08e0223d629541b4f39ffea48333

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
