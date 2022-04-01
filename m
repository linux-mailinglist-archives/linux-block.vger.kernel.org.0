Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335784EFD3E
	for <lists+linux-block@lfdr.de>; Sat,  2 Apr 2022 01:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353639AbiDAXqc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 1 Apr 2022 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353666AbiDAXqX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 19:46:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0881F685A
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 16:43:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDA42B8267C
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 23:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99141C3410F;
        Fri,  1 Apr 2022 23:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648856633;
        bh=huMUrCG/E77GxsRvqB2CgFQ6JDBUKjk9ZN4jZjgWdjs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y2n9lHWcGPlC4Uy8DjhsaHJYJGaHBrizB6q903Munnedud/2mmx0IuGtlEloTqyGe
         peXhYvAzmwJVpCb2aQSBAlVuXINMolRL4y8yrGvmIt0BNHt5KFbCnmG37J5Da9+HFY
         /35W305465Oo4/kttLV/wOMXWPH5TnbPG0qaDRDG0ohUIuL0m8OMU5FxytY0IKAubW
         c/Sj6oGkzOnB1UvasYBokmIbcrtgw6hvYlWbCxJam8SP/C8/hTjZyzS1AfUyup1oqW
         +/mBYcSLBp+wN9kLknwImgexcEQ6VV366kuA3U4FaLQd8gk6DvVFduquWrjuq/iuNr
         D4hTy9eR5PNyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 802FEEAC09C;
        Fri,  1 Apr 2022 23:43:53 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] device mapper fixes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YkdSBEf1PpU9w2qs@redhat.com>
References: <YkdSBEf1PpU9w2qs@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <YkdSBEf1PpU9w2qs@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.18/dm-fixes
X-PR-Tracked-Commit-Id: 5291984004edfcc7510024e52eaed044573b79c7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe35fdb30511f845608571f7c09062ebb94d96c2
Message-Id: <164885663351.32259.4414926419646916830.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 23:43:53 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 15:27:00 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.18/dm-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe35fdb30511f845608571f7c09062ebb94d96c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
