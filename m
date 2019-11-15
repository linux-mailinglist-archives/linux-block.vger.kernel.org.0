Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EACF1FE7B0
	for <lists+linux-block@lfdr.de>; Fri, 15 Nov 2019 23:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKOWUQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 Nov 2019 17:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:55246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfKOWUQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 17:20:16 -0500
Subject: Re: [GIT PULL] Fixes for 5.4-rc8/final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573856412;
        bh=3uLI4EUqoefSkEPBmc0bfQnNI1loibFA4G0oZ7DoSD4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=T4wQVYDBu2n3pKWqXl0solnibUkPp2BNMkkFNFuyunkRzXMCNf6+BkcIx998sbqlU
         F0PJKfjlLzBpge5UlP0MBATR794Ey9bFohap4vqK5Wo5GXPX02pEQur9xbPHED0nJo
         3H2jAm+3gSjixJXX7CkPxiP13jbjpvXX+34w4EwM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <749566df-9390-2b57-ca8e-7f3b6493eae8@kernel.dk>
References: <749566df-9390-2b57-ca8e-7f3b6493eae8@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <749566df-9390-2b57-ca8e-7f3b6493eae8@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20191115
X-PR-Tracked-Commit-Id: dcb77e4b274b8f13ac6482dfb09160cd2fae9a40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b226c9e1f4cb23bf6fa6c74af361e5136cb5804c
Message-Id: <157385640596.25240.3607385863192737284.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Nov 2019 22:20:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        io-uring@vger.kernel.org
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 15 Nov 2019 12:40:46 -0700:

> git://git.kernel.dk/linux-block.git tags/for-linus-20191115

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b226c9e1f4cb23bf6fa6c74af361e5136cb5804c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
