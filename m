Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B425591CC6
	for <lists+linux-block@lfdr.de>; Sat, 13 Aug 2022 23:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiHMVsG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 13 Aug 2022 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbiHMVsF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Aug 2022 17:48:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FA91EECB
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 14:48:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B4EB60684
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 21:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D8B9C433B5;
        Sat, 13 Aug 2022 21:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660427283;
        bh=a6wsv/DFNkulLQbTNo3bSQImsLoXwTk48YZvbLNKb20=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ny7jAtFx+Q4UQpwpQD9Y2S8skVgu7wWsDqUjbBHdm06U9A9c7zvQqVszren/JE15f
         iLP6uK6kQPaCrhgNsGgbN65mzsaaUOxOqOgiztNqJ6UkSgGdRfH65X9Iz8nl1UjfsZ
         m5NrulCb/sb3fYW/ZUh2o8I6G77CZiD8zihVTIfp7oCUakVON1vtrsuj3mgnZTN94q
         dAw70MnKBWzRbvaD8l5CJNGEbWgOSdv2KzQc10yJVdu/gSEeeBMqfJTy7rbPDC9z0f
         AaNZ906k6KhAN2UxsL9AVErVD0TKnFHlrxkYWZPRfLAjEXM+m4PU1Rd0nlL8HYi0bA
         T5nwfelgksy8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D420C43141;
        Sat, 13 Aug 2022 21:48:03 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b244d065-93f3-cc44-19a1-801b301875f5@kernel.dk>
References: <b244d065-93f3-cc44-19a1-801b301875f5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <b244d065-93f3-cc44-19a1-801b301875f5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-6.0-2022-08-12
X-PR-Tracked-Commit-Id: aa0c680c3aa96a5f9f160d90dd95402ad578e2b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abe7a481aac9c277798661f846222f8ad7a6aed5
Message-Id: <166042728337.29926.6668648881550998837.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Aug 2022 21:48:03 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 12 Aug 2022 06:48:53 -0600:

> git://git.kernel.dk/linux-block.git tags/block-6.0-2022-08-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abe7a481aac9c277798661f846222f8ad7a6aed5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
