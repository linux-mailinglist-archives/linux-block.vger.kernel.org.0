Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B437754673
	for <lists+linux-block@lfdr.de>; Sat, 15 Jul 2023 05:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGODIb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 14 Jul 2023 23:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjGODI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2023 23:08:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71913A84
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2023 20:08:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A12C61DEF
        for <linux-block@vger.kernel.org>; Sat, 15 Jul 2023 03:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4D11C433C7;
        Sat, 15 Jul 2023 03:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689390506;
        bh=JA7HkTd1WCZJoNKUFtFbQyfUoLeXPofIcxXFndjT7HI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KZuIcpNYhWyR6Uxa4S8xZMkVv+KmElNgcBox4VR/vQJvCIzae+M4bzg0lGnQPb3xK
         Z9Tkzqxs8xP7Bjww4IdUv86ufFVk9V6pW80n0l/uN3Uvir4eyHY2MLK1L1uDjvMguu
         QNnZ/Whdhn9Jadoubu+0ekMtg06eM2L58ISC+qh9GZiv5RNj9MXhr+p1phMpvNG8GE
         mKbQogqKxjnRnwag7rIDRjgdvW7t5PZsGS8R6CDRb7Ju7ZX4qFiWNjn93L86Unyr2G
         K2Jv+3SWORVNt0xUxh5s0jyQcTnmDThwgcHOr6/DstwonGW/UvUU2L0Anj0xLGMFUA
         QwR5lpE+zMZaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1205E1B4D6;
        Sat, 15 Jul 2023 03:08:26 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cdb24723-26a4-3634-024f-239f380db6bf@kernel.dk>
References: <cdb24723-26a4-3634-024f-239f380db6bf@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <cdb24723-26a4-3634-024f-239f380db6bf@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.5-2023-07-14
X-PR-Tracked-Commit-Id: 9f87fc4d72f52b26ac3e19df5e4584227fe6740c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3bd86a0496565272ee1fc003b4b75ddb2f6427f
Message-Id: <168939050665.3346.13893835966863880885.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jul 2023 03:08:26 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 14 Jul 2023 13:43:09 -0600:

> git://git.kernel.dk/linux.git tags/block-6.5-2023-07-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3bd86a0496565272ee1fc003b4b75ddb2f6427f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
