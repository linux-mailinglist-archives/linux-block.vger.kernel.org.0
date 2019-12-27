Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFEB12BAC6
	for <lists+linux-block@lfdr.de>; Fri, 27 Dec 2019 20:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfL0TpK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Dec 2019 14:45:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfL0TpK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Dec 2019 14:45:10 -0500
Subject: Re: [GIT PULL] Block fixes for 5.5-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577475909;
        bh=lB7IjHJQ8z1+hs8J/Gfr4HB4tr/vjAD7I/Ry2b5LdxY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rwERnuAu67dmoPBDihAHTwPgSH/QNSEUlLGkz6YUgLxuuJFZBKCAkWgsKOkv1zi1M
         ki1RAFgeI6NQSejOCrnFCMK3iqLXkH1jTWpWMR10zSoZH7XMR1TevJ/Wvt4E9PEXxU
         O2XuI9jCmuZzGArna7dHv3H7wl9PbZvjUzTikz+g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1f9f9707-dc6a-38bd-d8fe-0ab67b1f9a03@kernel.dk>
References: <1f9f9707-dc6a-38bd-d8fe-0ab67b1f9a03@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <1f9f9707-dc6a-38bd-d8fe-0ab67b1f9a03@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.5-20191226
X-PR-Tracked-Commit-Id: b2c0fcd28772f99236d261509bcd242135677965
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ae40a6951a72c59f2f6a0b721ce0e43bbcffcab
Message-Id: <157747590975.1730.10764164034470811829.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Dec 2019 19:45:09 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 26 Dec 2019 11:17:04 -0700:

> git://git.kernel.dk/linux-block.git tags/block-5.5-20191226

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ae40a6951a72c59f2f6a0b721ce0e43bbcffcab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
