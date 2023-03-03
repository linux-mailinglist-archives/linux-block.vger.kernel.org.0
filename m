Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC6F6A9F7B
	for <lists+linux-block@lfdr.de>; Fri,  3 Mar 2023 19:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjCCSqy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 Mar 2023 13:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjCCSqu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Mar 2023 13:46:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA45678F
        for <linux-block@vger.kernel.org>; Fri,  3 Mar 2023 10:46:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C06618C4
        for <linux-block@vger.kernel.org>; Fri,  3 Mar 2023 18:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F111EC433EF;
        Fri,  3 Mar 2023 18:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677869077;
        bh=yUsTLQcyY3DWODmeT3jZxo2EH5RATPwKxZ/SsTVmdR8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jlEu28sXmi3rEQMfJtEGErN7bf4k8Micd1aKKc9FNvs855NAd+ylyg+mcDF7bWhfK
         ze0ASZOuJEEj53O02L700oUrb6diTZb8o2MJ17JHPhubFnCjVv6IxXnaHvfrf+68cR
         bEOCiS4MRw/qOWdKXE7cEqnJYC+XfyJFnIuA2wF2UC8c34/HYOptDoNHF7ub67wSu8
         tOtjTd6Oxcn5Zgs1ZIilpHmYvAVVBs7/9VpsSW1OxY2JKqTk3gv/sMmaLjBNQ1Ax/1
         /yyr9wULGKQs01pyrtpRl4RbdAhNnRIVMD8yPc0kAeU/wZyYp6RRdsNR5pwADcknrR
         rr5j2wj9dU9xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8843C41679;
        Fri,  3 Mar 2023 18:44:36 +0000 (UTC)
Subject: Re: [GIT PULL] Followup block fixes/changes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9d8fd1ba-c96c-667b-daf6-9971958b955a@kernel.dk>
References: <9d8fd1ba-c96c-667b-daf6-9971958b955a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <9d8fd1ba-c96c-667b-daf6-9971958b955a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.3-2023-03-03
X-PR-Tracked-Commit-Id: 49d24398327e32265eccdeec4baeb5a6a609c0bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d0281b56be5d90117a75065f4edc27b25b14c8c
Message-Id: <167786907688.30023.15395643614867178151.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Mar 2023 18:44:36 +0000
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

The pull request you sent on Fri, 3 Mar 2023 05:45:30 -0700:

> git://git.kernel.dk/linux.git tags/block-6.3-2023-03-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d0281b56be5d90117a75065f4edc27b25b14c8c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
