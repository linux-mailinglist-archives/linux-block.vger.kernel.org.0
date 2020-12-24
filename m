Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4DAB2E28EA
	for <lists+linux-block@lfdr.de>; Thu, 24 Dec 2020 23:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgLXV77 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Dec 2020 16:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgLXV77 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Dec 2020 16:59:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2D14720E65;
        Thu, 24 Dec 2020 21:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608847159;
        bh=VJt5Eck5g/OB+FPtQ2DQf5ADRs+o8W7pVXZjWbaA2F4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=InPLe8+UsyG5plZYCPxGVgx7Y2863OZRT97e0oc4JpEPfYoj8loHApagoFlRaYP+e
         1E7xQk4pjPcdmV0jRaDBk2UvSRaq0w23GyGS6KWXlusSIE3JQb0e8C/4MMHfQGVOR4
         kFu4R/5xpgh8S/MjQRafz0WJI58Op2ddKQnVo62QCVWVuhiXGv/hXtx9axoi7qMtu8
         tNIvj3rw233gadiwG5rPUrl+dfYxQKZnACO/IKvFvyA5agrEvWKq5i+lFsEj29Q5uE
         XfrLVbYCGeJGF4eTCwi4P5lJnRkenlO9mPJKIYAE5aZk19NqS0D27I0D2+qCL4UWAu
         xRS/8nKrlfXUQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 1B79A60159;
        Thu, 24 Dec 2020 21:59:19 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 5.11-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <151f83d5-5ba0-fb66-d455-16e987bca00a@kernel.dk>
References: <151f83d5-5ba0-fb66-d455-16e987bca00a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <151f83d5-5ba0-fb66-d455-16e987bca00a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.11-2020-12-23
X-PR-Tracked-Commit-Id: 46926127d76359b46659c556df7b4aa1b6325d90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 771e7e4161053e606592b9cd056ef7e2ea2316d5
Message-Id: <160884715904.31605.10716563789247588671.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Dec 2020 21:59:19 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 23 Dec 2020 22:08:03 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.11-2020-12-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/771e7e4161053e606592b9cd056ef7e2ea2316d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
