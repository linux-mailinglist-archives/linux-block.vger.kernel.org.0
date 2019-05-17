Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC9921200
	for <lists+linux-block@lfdr.de>; Fri, 17 May 2019 04:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfEQCZg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 May 2019 22:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfEQCZf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 22:25:35 -0400
Subject: Re: [GIT PULL] Followup block changes for 5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558059934;
        bh=UCfTRcM3ZkW+WFVYbPkAif9eSySwSFcybw/SvKQnBEc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oB6AaAXJaSt99tjAxkRM0xxyVuxJgGXlYQ76mW4lKrazxeXYsYt4EqX5/hKj/Ldv/
         x/E+JFAz96pzBGyYrv2c6aqY2pBgjRSiyDg7yLB9w9nWGeQzRL2sf8K0WRCUeEE2Cv
         0sLxfkCGH+9aIDf20RBeLmYEVICGHGIZ6RWsrtfo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <da4fdf69-a8dc-1e69-f3de-f0accaed544e@kernel.dk>
References: <da4fdf69-a8dc-1e69-f3de-f0accaed544e@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <da4fdf69-a8dc-1e69-f3de-f0accaed544e@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.2/block-post-20190516
X-PR-Tracked-Commit-Id: 7a102d9044e720ac887c0cd82b6d5cad236f6d71
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1718de78e6235c04ecb7f87a6875fdf90aafe382
Message-Id: <155805993493.6110.16251431006201688702.pr-tracker-bot@kernel.org>
Date:   Fri, 17 May 2019 02:25:34 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 16 May 2019 17:12:18 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.2/block-post-20190516

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1718de78e6235c04ecb7f87a6875fdf90aafe382

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
