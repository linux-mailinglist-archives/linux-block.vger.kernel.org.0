Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D9B1EC54A
	for <lists+linux-block@lfdr.de>; Wed,  3 Jun 2020 00:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbgFBWuJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jun 2020 18:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbgFBWuJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 18:50:09 -0400
Subject: Re: [GIT PULL] Block driver changes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591138209;
        bh=vmWUvX8MVLEKR8/l6Ddp/D1prHdoLqrxdM1tgTZD8U4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Gfpjtng8ZTPaD3S8TL3eXFsqy86UC5jCVSHEwPEopvbTpRU3lN2Mxm4erJZHJ5rin
         E/WzWdv9Bva5yUp8DrEBBhDGwFmdzaEH4rU6OYSpI7UDuwdaeMVKwBuTE+5+8PTqPw
         npfh06DG2UdlDeldGKHhzBUHXyeH/XFCgijUOzek=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <aa7e82d7-9ed6-dbb7-458a-12346e867686@kernel.dk>
References: <aa7e82d7-9ed6-dbb7-458a-12346e867686@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <aa7e82d7-9ed6-dbb7-458a-12346e867686@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.8/drivers-2020-06-01
X-PR-Tracked-Commit-Id: 0c8d3fceade2ab1bbac68bca013e62bfdb851d19
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bce159d734091fe31340976081577333f52a85e4
Message-Id: <159113820928.13730.4338526493746988576.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 22:50:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 11:50:17 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.8/drivers-2020-06-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bce159d734091fe31340976081577333f52a85e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
