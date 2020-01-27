Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C281E14AB85
	for <lists+linux-block@lfdr.de>; Mon, 27 Jan 2020 22:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgA0VUG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Jan 2020 16:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgA0VUF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jan 2020 16:20:05 -0500
Subject: Re: [GIT PULL] Block driver changes for 5.6-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580160005;
        bh=spuPCKQ1Xqo4oDBXSUvDMhX23CZyFXuevbpsIRzxGts=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CXhrpPyYhK+G6cWBpkhDOdlucUAwfGwXctCyrgtUU26ixtG0HuNIsML7b0cFfLiCM
         xE2BBKX+QeYgBss2+2HIdURaNME4Z/xtg1GvmI7nSne9SAPV6/FEq7U41W26MtvKwG
         lOwezXvD5Ap5Qsw+8iXXTWJ1KZO1xd5Y3p9EIgak=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d6948ecb-b1c2-9822-307a-a2dd52cf6759@kernel.dk>
References: <d6948ecb-b1c2-9822-307a-a2dd52cf6759@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d6948ecb-b1c2-9822-307a-a2dd52cf6759@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-5.6/drivers-2020-01-27
X-PR-Tracked-Commit-Id: e3de04469a49ee09c89e80bf821508df458ccee6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22a8f39c520fc577c02b4e5c99f8bb3b6017680b
Message-Id: <158016000509.13304.15992342777635630638.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 21:20:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 12:38:13 -0700:

> git://git.kernel.dk/linux-block.git tags/for-5.6/drivers-2020-01-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22a8f39c520fc577c02b4e5c99f8bb3b6017680b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
