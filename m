Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878E15A9D8
	for <lists+linux-block@lfdr.de>; Sat, 29 Jun 2019 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfF2JaZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 29 Jun 2019 05:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfF2JaH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jun 2019 05:30:07 -0400
Subject: Re: [GIT PULL] Fixes for 5.2-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561800606;
        bh=uBX6X2ImnJJiwlkMhwc9N2nO9Akh9qCA6Kwawd2U5Oo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yOFMmE5M7SrzMyq6pTCxjpXnRR1+npalc8VqVTDrh3WMLqfZErCrdLFTju8+7/YTo
         +j87lzdzI7NXr7T48g/lnhiva/XA1g1vBwDT75w56e0zduuEYhjfgrLAedTAqoqedI
         zCnUxXYw/ZpERS8ii5pud5h40mamxtudaQ6e5Ovw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bed3d400-fe9b-6016-5332-1c663912fbb6@kernel.dk>
References: <bed3d400-fe9b-6016-5332-1c663912fbb6@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <bed3d400-fe9b-6016-5332-1c663912fbb6@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190628
X-PR-Tracked-Commit-Id: e6feaf215f07dd98d03ee783c9dd4c7f7e55b74d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9dda12b6fa0eba6b1fd32399b599d05765893dae
Message-Id: <156180060674.8003.14825423240559880311.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Jun 2019 09:30:06 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 28 Jun 2019 09:37:30 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190628

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9dda12b6fa0eba6b1fd32399b599d05765893dae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
