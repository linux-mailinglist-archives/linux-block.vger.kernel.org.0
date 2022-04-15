Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF9503183
	for <lists+linux-block@lfdr.de>; Sat, 16 Apr 2022 01:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356423AbiDOXHf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 Apr 2022 19:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356439AbiDOXH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 19:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF49C2F3A2
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 16:04:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E03162253
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 23:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAE43C385A4;
        Fri, 15 Apr 2022 23:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650063898;
        bh=T35nquFlEiY19jbPKx0AsaOyzkU6IIgWzrg1UU8NsY0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GrMXLkrClAKluBrxT89B20bIKnKHqbLVcMsnJQAUWlsnL1s3Uym3RA8u21vkIyZuV
         vxT4Q3CoFdsjRA0xQhXokCz3BSwQQ0GBWxr5AvzQIqwKnLr5xZ6XkyJcjdHk2j+7y7
         ibX51vkzb/PYM/AcAwhDxWunNkeaDgtmwUPO3+6fbgQLTfeQztuO92QLYaRTjOsEGO
         htKQvAycUWXZAHAEVtaQGNr7/4mnbEsPq4/pjM/4v8DYVye++M2kPcq6A5azatr3if
         mx8IxddGgMJKxa3ie/85jA8/GvhH+t4tAhJfRbvSXFCLTJo93G/HHZUIo1QeULgHfr
         vrr3gsi0FII2Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 974C7E8DBD4;
        Fri, 15 Apr 2022 23:04:58 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] device mapper fixes for 5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YlnZCHVZNRobAvPZ@redhat.com>
References: <YlnZCHVZNRobAvPZ@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <YlnZCHVZNRobAvPZ@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.18/dm-fixes-2
X-PR-Tracked-Commit-Id: 92b914e29af3e99589f2d2876616c0b534892ed4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce673f630c097ec87391335308184bc907184fbf
Message-Id: <165006389861.20086.14780895718165366464.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Apr 2022 23:04:58 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Alasdair G Kergon <agk@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 15 Apr 2022 16:43:52 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.18/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce673f630c097ec87391335308184bc907184fbf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
