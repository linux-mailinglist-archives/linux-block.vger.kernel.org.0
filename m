Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9D261DBD8
	for <lists+linux-block@lfdr.de>; Sat,  5 Nov 2022 17:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiKEQEf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 5 Nov 2022 12:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiKEQEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Nov 2022 12:04:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75BC1007B
        for <linux-block@vger.kernel.org>; Sat,  5 Nov 2022 09:04:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50B9360B78
        for <linux-block@vger.kernel.org>; Sat,  5 Nov 2022 16:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3D37C433D6;
        Sat,  5 Nov 2022 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667664271;
        bh=tncHKehNGx9eVcNe9G0EtoliI2A71HBbbZpa4BjswBk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=c3Np6BW56c4nhFmHH9+HdLsfpOAzfk6OWxUtFZfOi8k2yuJnnkqcMjJIf9XHSfI5n
         0vGxKLcOtKEmMy/jUVoq3upmh8y5a80tYoeLLCEu7rdZrkIpTyUJrwrENGdEArZ1Et
         iNrwFmKUfeP1szuyr5LsE54QKXsTnaoYVJXIkb9MG4iDx5fsMenxUzUSBHSlOpwsDK
         B3dbfvSgQqOLBjAppkSfn6XkSPYqKTxkpJcs4IoTzGp7AQpgLdML7bOD3J0TOTtUDf
         LVEmVJKsO6bak/cUtXGztyciXo8v2EdGOJIl8veNB0UPTAZFcL7NGNj9kpOV+NF85E
         t9G90GkwFHjzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0F97C395FF;
        Sat,  5 Nov 2022 16:04:31 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.1-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7ecce2b9-6a43-5597-5f7d-2679ebaff4e5@kernel.dk>
References: <7ecce2b9-6a43-5597-5f7d-2679ebaff4e5@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <7ecce2b9-6a43-5597-5f7d-2679ebaff4e5@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.1-2022-11-05
X-PR-Tracked-Commit-Id: 878eb6e48f240d02ed1c9298020a0b6370695f24
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4869f5750afdb10a0e9cfa0252fce33e53ab681e
Message-Id: <166766427165.28959.17352437864722684076.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Nov 2022 16:04:31 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Sat, 5 Nov 2022 08:44:36 -0600:

> git://git.kernel.dk/linux.git tags/block-6.1-2022-11-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4869f5750afdb10a0e9cfa0252fce33e53ab681e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
