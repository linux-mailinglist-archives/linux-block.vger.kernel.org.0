Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B4853D1DA
	for <lists+linux-block@lfdr.de>; Fri,  3 Jun 2022 20:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348030AbiFCSuz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Jun 2022 14:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349077AbiFCSuH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 14:50:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0387286FC
        for <linux-block@vger.kernel.org>; Fri,  3 Jun 2022 11:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68B1FB82462
        for <linux-block@vger.kernel.org>; Fri,  3 Jun 2022 18:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CD35C36AE7;
        Fri,  3 Jun 2022 18:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654282203;
        bh=WeP5Iwt4BCXAVRxs65xrz9WDAvfdAFIbGfxxh6MWK0w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fqBJlA/kJ88rbZZEjGHcfqp/63+kafq9L/7y+X9/s1mpk76bTDL7a7+4VoKqFYcz+
         JuCiHFejAFvr/s9TKn4ORl3FEwZYAv03VUpEdaXuTAJ0wEEiPojktMaNQqh3G6GwZv
         k3AycL/j1EDftg/3U4DPnSq1GSkCZ1gp5YyXInuFwGJHRJ+DhA7+zXKm+n40tYEonC
         VWukMu+MIhL6Ri7nmX85KJ64qFQzuHFFzne2wTpLruDJ4L1/8eNDvazDXQBqjzgiwc
         qwKhZvecZ6HQYYqwVwxOem40QtL+faBCm6GkTIQisSdD/h3VJLoGMjxDjCdp513oNn
         qmoEapRf4sQ0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04096F03950;
        Fri,  3 Jun 2022 18:50:03 +0000 (UTC)
Subject: Re: [GIT PULL] Follow up block core changes and fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d6400df1-3a34-b17a-0647-a7f0bb63d559@kernel.dk>
References: <d6400df1-3a34-b17a-0647-a7f0bb63d559@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d6400df1-3a34-b17a-0647-a7f0bb63d559@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.19/block-2022-06-02
X-PR-Tracked-Commit-Id: 41e46b3c2aa24f755b2ae9ec4ce931ba5f0d8532
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34845d92bca527b5c2cf8b2293b71b9c746c79ca
Message-Id: <165428220299.10974.1098726587578972079.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 18:50:02 +0000
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

The pull request you sent on Thu, 2 Jun 2022 23:30:28 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.19/block-2022-06-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34845d92bca527b5c2cf8b2293b71b9c746c79ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
