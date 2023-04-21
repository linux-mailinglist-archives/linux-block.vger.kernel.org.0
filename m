Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30806EB03F
	for <lists+linux-block@lfdr.de>; Fri, 21 Apr 2023 19:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjDURIs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Apr 2023 13:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbjDURIq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 13:08:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D4D15A00
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 10:08:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFBAD63ABD
        for <linux-block@vger.kernel.org>; Fri, 21 Apr 2023 17:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64AC2C433D2;
        Fri, 21 Apr 2023 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682096880;
        bh=cNgoZaTMyqcFgs+GXp8pClEJ3nBez+iTYsX2ZuBlV+o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DiIir1u++kNxt6Dgc2+HjZBd/IePr1l8xzxGmLqetnjoQqkmhATLBW0UYo3JkacOL
         LwE61Ha4E6BZHHyGeCAnXdrUxNjrpEuHtVIQxQliM+Z+2dwvVfFDpq6VITqXh9LQHr
         GWxhSRHJgmnymx1VlHLrEGF4oS7pnJvm/+TT9z9fzpA9s08WnaQivuoSzWDdm0L0je
         qbkx44lEHWnV+QEArUsBAeeQVzeOXwoz9t7ATUWBv8d2sdF9r+FW9w6aextdfBqYwn
         If2rZsFRB5OryEJ+0TCXgPgxEI0R7vg87Sa8XjGGVPVKg88QSyoCgpw7I2WnmCWNnl
         qo+wvr33fW4pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50BD7C561EE;
        Fri, 21 Apr 2023 17:08:00 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.3-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <0afbb007-a1d5-ed34-9304-04bb91264d7c@kernel.dk>
References: <0afbb007-a1d5-ed34-9304-04bb91264d7c@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <0afbb007-a1d5-ed34-9304-04bb91264d7c@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.3-2023-04-21
X-PR-Tracked-Commit-Id: 81ea1222f2fa5006f4b9759c2fe1ec154109622d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 334e5a8206af93818fd384300666cc203f08f035
Message-Id: <168209688032.21086.7129576324425823668.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Apr 2023 17:08:00 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 09:01:54 -0600:

> git://git.kernel.dk/linux.git tags/block-6.3-2023-04-21

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/334e5a8206af93818fd384300666cc203f08f035

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
