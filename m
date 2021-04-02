Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9877635316E
	for <lists+linux-block@lfdr.de>; Sat,  3 Apr 2021 01:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbhDBXSh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 2 Apr 2021 19:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231406AbhDBXSh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Apr 2021 19:18:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id EEE6461178;
        Fri,  2 Apr 2021 23:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617405516;
        bh=xycpL1OsPFS0xjOwesmFS8g4sgsnS0oNa3SqKv6jy9g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W6Nx5ga9ncFVcxy0VOD95PGV8ZhqbEndW4ku1ecgFkZBuXsRhOAbleMfQXWVdnHPb
         +cvv103SqQh10+S9XJiHgf8Qr5lGfTpe0xnVeyPmML5F+19rK7VMc1NbEjVJxrS1YH
         OsFWDa6/pkKMqT3SLqpqhFVSV3VPH8hdDXg75R+MpouUjSwe29FwPOy0KytH+ZhMND
         H+ycEwnzkE6jsQoUEG82Y/ltWjLejBECVpUOwTxjIikP1aPdJT5ZLUJJE14gr8ynmp
         lUrUV43FCbLGAx66VN7sowr8Wjjq+UJcQGrcKf+BTEcuA1NrdCD/kAmOwZ2EFfC0dv
         Mf/IB3EuYcgHg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id DE875609D2;
        Fri,  2 Apr 2021 23:18:35 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.12-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <979a3929-25ec-0b24-20fa-6803e6dfbe30@kernel.dk>
References: <979a3929-25ec-0b24-20fa-6803e6dfbe30@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <979a3929-25ec-0b24-20fa-6803e6dfbe30@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.12-2021-04-02
X-PR-Tracked-Commit-Id: f06c609645ecd043c79380fac94145926603fb33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d93a0d43e3d0ba9e19387be4dae4a8d5b175a8d7
Message-Id: <161740551585.12783.13803003532301160113.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Apr 2021 23:18:35 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 2 Apr 2021 15:28:15 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.12-2021-04-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d93a0d43e3d0ba9e19387be4dae4a8d5b175a8d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
