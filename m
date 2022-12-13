Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D2D64BC9D
	for <lists+linux-block@lfdr.de>; Tue, 13 Dec 2022 20:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiLMTD1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Dec 2022 14:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiLMTDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2022 14:03:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA0FBEC
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 11:02:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A30EB815B1
        for <linux-block@vger.kernel.org>; Tue, 13 Dec 2022 19:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCFC8C433EF;
        Tue, 13 Dec 2022 19:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670958156;
        bh=bqBetgiIfsNO84i1qW2/dVkckEDh8U9rezo0MFNdsY0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gAjfQAyGmv4X9jz3YXVgU8UDu72BwrfnDBHg2yDsDF4QZ1wOW6izJ4eVo8S9GNJJ+
         mBZLesPLNIXl4BTHtKcsU/CiYSyrbJtEIv0QZapKWh88IgKUUQODBCcxcAOEL+5n1B
         TnDg8bYutau+QvyPqekMapNLy1XoXBg3HZbsv0hO+wghXnURd+evap4e235ZhXN1Gx
         Z+W1vh9GrIIc1nvuH18/o/eHg5lB7qOe8aEuhUc7UvDz2SApeaXYM8F57OoayhNevY
         4HMoKzgCiJNVnd4SCkWOOaJcLsNpKNe3D7gu4vdEKygAKTF4muHZvCzq4FIi1Je5AY
         5FI/Q0vihl8kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9828C00445;
        Tue, 13 Dec 2022 19:02:36 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] device mapper changes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5es3Sf0DU0QEHPP@redhat.com>
References: <Y5es3Sf0DU0QEHPP@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <Y5es3Sf0DU0QEHPP@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.2/dm-changes
X-PR-Tracked-Commit-Id: 7991dbff6849f67e823b7cc0c15e5a90b0549b9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8715c6d3100fc7c6edddf29af4a399a1c12d028c
Message-Id: <167095815675.20557.4629416317881565086.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 19:02:36 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Luo Meng <luomeng12@huawei.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        Alasdair G Kergon <agk@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 17:36:13 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.2/dm-changes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8715c6d3100fc7c6edddf29af4a399a1c12d028c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
