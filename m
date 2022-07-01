Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E0F5638E9
	for <lists+linux-block@lfdr.de>; Fri,  1 Jul 2022 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiGASCo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 1 Jul 2022 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiGASCl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Jul 2022 14:02:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5AA427EC;
        Fri,  1 Jul 2022 11:02:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 033B3614B3;
        Fri,  1 Jul 2022 18:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 637A6C341D1;
        Fri,  1 Jul 2022 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656698559;
        bh=jBj5WpRVEpG7ZZPbz++WHvh06SuOp5vRCGeHRN7NglM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tk6aXORN7peqHEpcQlYut6Dz47NGyu+TNhk7AJT/21d2NNMJVPRe+/QmWL0DyY9NE
         PZRhOGO+u1wt/17CVuFEMhV8f+83I/xBgouOtD7gpA8RazYSopyYHpn4+K/slahvn3
         GR8feVcrO5nndOaVRXcrwEGZBv/57a466/9rjdJ+/D/9qdlfXFRWh9U431aoXVNVOL
         J1dVA5FQCtSJP9iY8I7iqqGCTRhn9HZ9piKSEq4WWATvixPsBfwz8yRT9kEjx3IF+r
         2OnczRSe02UfIK76Ez7NthHgLZ0jMTA6VUzTeaDE71l6hp9/V8AwdyIHzIG7d/jWsH
         57lqMEKBvJ8+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 461E6E49F60;
        Fri,  1 Jul 2022 18:02:39 +0000 (UTC)
Subject: Re: [git pull] device mapper fixes for 5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yr8gBVNDik5el/n/@redhat.com>
References: <Yr8gBVNDik5el/n/@redhat.com>
X-PR-Tracked-List-Id: <linux-raid.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yr8gBVNDik5el/n/@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-5
X-PR-Tracked-Commit-Id: 617b365872a247480e9dcd50a32c8d1806b21861
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8300d380309a47b4f960379667278bcfa4d901e1
Message-Id: <165669855928.14842.14864430263973874687.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jul 2022 18:02:39 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 1 Jul 2022 12:25:41 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.19/dm-fixes-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8300d380309a47b4f960379667278bcfa4d901e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
