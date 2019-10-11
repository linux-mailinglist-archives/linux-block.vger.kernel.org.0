Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D84D4512
	for <lists+linux-block@lfdr.de>; Fri, 11 Oct 2019 18:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfJKQKI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Oct 2019 12:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbfJKQKH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Oct 2019 12:10:07 -0400
Subject: Re: [GIT PULL] Block fixes for 5.4-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570810207;
        bh=JxFFtqo/YuSYmy8RdBWkksycM56jNO95sl4IbO6eyvM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x+9GiNFk4KZKg2rNg9c6h2+aIP7JdCBX5ltsBp1xo0m5P9hZFST2wKXs4VfjHUUHr
         lc8r4NwrTwp00a4Itb9NlxV4E32Jvpy+i0K1PuRBEMcrt8KS+57akbQBnOgrm7ryzk
         76rJMIVM52aB+JkghihsfGLT7OQ6mBe2eMJEZHLg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <da741fa2-7db4-95f4-18ee-5932fbd4b00a@kernel.dk>
References: <da741fa2-7db4-95f4-18ee-5932fbd4b00a@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <da741fa2-7db4-95f4-18ee-5932fbd4b00a@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20191010
X-PR-Tracked-Commit-Id: 862488105b84ca744b3d8ff131e0fcfe10644be1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 297cbcccc23d4eefbc3043cd2fa5cf577930e695
Message-Id: <157081020727.21776.13783764129068913518.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Oct 2019 16:10:07 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 10 Oct 2019 20:15:31 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20191010

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/297cbcccc23d4eefbc3043cd2fa5cf577930e695

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
