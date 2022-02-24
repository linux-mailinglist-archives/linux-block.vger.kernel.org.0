Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58C4C35A2
	for <lists+linux-block@lfdr.de>; Thu, 24 Feb 2022 20:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiBXTSy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Feb 2022 14:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiBXTSv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Feb 2022 14:18:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7310135277
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 11:18:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BF57B828FB
        for <linux-block@vger.kernel.org>; Thu, 24 Feb 2022 19:18:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C24F5C340E9;
        Thu, 24 Feb 2022 19:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645730298;
        bh=oAbco3fCMuYFm43yev1JSQhMCa9GyFB/9cSSmK4NJ+M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pl/y1axeVryjF2lsavl35wHb0HXKfMRpYyGK35CcAZx2drUDk/oLh3ndLGWlCRaX8
         aZzUCiOCeLeRH2x3/xGPH8P0k958xO1jLJz4wThjCjUxwZYWOmLkLaTZFc+XhMnuXj
         B+tn7cEv1/R+SeapLIASvP/s6AZtXd9KxZgSyXwl7qMlDFcHQ5JGxSwTCDgo8KJh0t
         yE/twsqaWXmtPoUxUaFABC9/IXlHJVNikplSc+BUZnoLvFOxXhN8WG71C2T9G6M0bh
         QXSmsyjuJ7Zy4wz9M/YSaePD79I6WMwhcsuK3XmkjMrjVddIQA1EHRzlxAJwDwJpuA
         9GJv2vF+k+fyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEAE9E6D3DE;
        Thu, 24 Feb 2022 19:18:18 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <f2985ee4-cf5a-431e-2d11-8bd9c9d4e8fa@kernel.dk>
References: <f2985ee4-cf5a-431e-2d11-8bd9c9d4e8fa@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <f2985ee4-cf5a-431e-2d11-8bd9c9d4e8fa@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-24
X-PR-Tracked-Commit-Id: b2750f14007f0e1b36caf51058c161d2c93e63b6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73878e5eb1bd3c9656685ca60bc3a49d17311e0c
Message-Id: <164573029871.2860.9028486247441840644.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Feb 2022 19:18:18 +0000
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

The pull request you sent on Thu, 24 Feb 2022 10:30:23 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.17-2022-02-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73878e5eb1bd3c9656685ca60bc3a49d17311e0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
