Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D98DD633
	for <lists+linux-block@lfdr.de>; Sat, 19 Oct 2019 04:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfJSCfG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Oct 2019 22:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbfJSCfG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 22:35:06 -0400
Subject: Re: [GIT PULL] Block fixes for 5.4-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571452506;
        bh=IhmYnTuEfgIqvXhmYfOJvFOKglJdLE8mKQwzcWZK/Qk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QVMnf2sPmiwK1gIwlg46EYQE80iYRrtJrEWTTU9RTPU4HunmvDkCsd2gRUNK3BhZZ
         SKD1Gujjk8Mtz9MF00Bu5KTUVWWD2aeqNMmEjG7G01qr9QnljhKhY+BCnbIZmDNtzq
         hwFRr+cDTFdB4FnRMKi4WRJuWcwralc1nwB01HhQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <10411f93-6c87-7332-1d62-03498b7fff17@kernel.dk>
References: <10411f93-6c87-7332-1d62-03498b7fff17@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <10411f93-6c87-7332-1d62-03498b7fff17@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-2019-10-18
X-PR-Tracked-Commit-Id: b55f0097ae1da2520108bc426275c1ec5f857b78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d418d070057c45fd6f21567278f95452bfe690d1
Message-Id: <157145250599.6008.9043045630078984547.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Oct 2019 02:35:05 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 18 Oct 2019 19:56:20 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-2019-10-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d418d070057c45fd6f21567278f95452bfe690d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
