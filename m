Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E522B56C0FD
	for <lists+linux-block@lfdr.de>; Fri,  8 Jul 2022 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbiGHSfd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 8 Jul 2022 14:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbiGHSfc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jul 2022 14:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA981EAFE
        for <linux-block@vger.kernel.org>; Fri,  8 Jul 2022 11:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE5D762588
        for <linux-block@vger.kernel.org>; Fri,  8 Jul 2022 18:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D766C341C0;
        Fri,  8 Jul 2022 18:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657305330;
        bh=uefvd4r2ESGTUBSDqs3/5Ogyj4ZQysr4rdxi7PaI/z0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hyg8Ehm698LwOzARnBEwfzFukVDY4shDtyu7hmmQSAwKKpN7bk31na69hTlaw+eO/
         njd3+g/CzPj9h5cr+HP9J9Ci67U1aGfEx3ZJr8P4i3Ani0PKrhYIKPt55FL9z6iznq
         EDjfFFIr0Z/aihdBheahw3OZRzgaBmNK7NNqnRwi9LtuQvEUkznfpeTDdWfcIIig4I
         jokZzEKRde3BLyCfqJhFOOThCxEVPoujA3hRVdYmHC9PDAftxKzX8I1Ebxsx2KaYp6
         KbPockw3xT8BIeKj6kPIw7bG9PWRUcbYrDH09hDNU8yBmUfPMZUSLP0/O2gIBjwwCp
         rCQOrI1RI5ZSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B1D9E45BDA;
        Fri,  8 Jul 2022 18:35:30 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.19-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1b53ba18-b689-f192-a7e9-19062b3bbafa@kernel.dk>
References: <1b53ba18-b689-f192-a7e9-19062b3bbafa@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1b53ba18-b689-f192-a7e9-19062b3bbafa@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-08
X-PR-Tracked-Commit-Id: 6b0de7d0f3285df849be2b3cc94fc3a0a31987bf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a471da3100ef2e8feb8449d378a52e29dd1e9ae1
Message-Id: <165730533016.9073.211125946167755687.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Jul 2022 18:35:30 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 8 Jul 2022 06:47:40 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.19-2022-07-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a471da3100ef2e8feb8449d378a52e29dd1e9ae1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
