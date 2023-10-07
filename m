Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFCA7BC97F
	for <lists+linux-block@lfdr.de>; Sat,  7 Oct 2023 20:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjJGSMg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 7 Oct 2023 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjJGSMf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Oct 2023 14:12:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD55AB
        for <linux-block@vger.kernel.org>; Sat,  7 Oct 2023 11:12:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2416C433C8;
        Sat,  7 Oct 2023 18:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696702352;
        bh=UwWURvoxkhcwhFDXkCPwTaae8vAWeEt856ynk1fFU/Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hy94FVC/WdKnIEhSn6KbEEggxxAXCL1VyGbalKkQrNu1AeD0fgNxRVpOir+9IoDD0
         Eqy9j9cGOX83KFw+PZsGsZuai/NzFLUj+nWK1+2n1q0bS05hv4rbVHzWARjOwpfngc
         a0cvXISlMBIJkqOyCzvd5yaWJekGGv6GES0wghrhSkoUhAZibAjWhAhvPa9rjr3FDA
         KWoPzyQsa0fZYyF+E36Gv0+n4IoIjrOXXVBdQAvp/CcXF+MiqYeJDW0y+fYIzjL9J0
         zH3ba0yV3jTFX8qpHqWTPbtSoYT6ZBv2yORQogP+vnv4sXO72Y/yEY1Jm91B4jJ3R6
         LkgCLEUsCNv9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 942F3C41671;
        Sat,  7 Oct 2023 18:12:32 +0000 (UTC)
Subject: Re: [dm-devel] [git pull] device mapper fixes for 6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSCVUa3D4BAKGsLL@redhat.com>
References: <ZSCVUa3D4BAKGsLL@redhat.com>
X-PR-Tracked-List-Id: device-mapper development <dm-devel.redhat.com>
X-PR-Tracked-Message-Id: <ZSCVUa3D4BAKGsLL@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.6/dm-fixes-2
X-PR-Tracked-Commit-Id: 3da5d2de92387a8322965c7fb1365f7cae690e5a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4aef108a4d60bb52bf4e8e2ed9444afe2cdfe6a9
Message-Id: <169670235249.17141.917993586452703729.pr-tracker-bot@kernel.org>
Date:   Sat, 07 Oct 2023 18:12:32 +0000
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>,
        Fedor Pchelkin <pchelkin@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 19:16:33 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.6/dm-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4aef108a4d60bb52bf4e8e2ed9444afe2cdfe6a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
