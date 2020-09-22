Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0290274BE8
	for <lists+linux-block@lfdr.de>; Wed, 23 Sep 2020 00:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVWPV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 22 Sep 2020 18:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIVWPV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 18:15:21 -0400
Subject: Re: [GIT PULL] Block fixes for 5.9-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600812920;
        bh=9pBie0zCInyagyW8yj4tSVmVixNYTS+PB/lQeAAQs5g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XrBxmglqGcGX2okvbO3op8VBcbgXfwPn4QLmi6Q5WMdr9oK9/U4NoZLW925m+ydQX
         ZHPAXiwkd0LtR9+nmq+CiMTtF+ajzDHAJJXMY9TEWDARCuPxLldbvSVgrDIPyC9zdM
         1aeTa8p4J0lCoss2+KscLIKEehBOTHTaIMn3+Xhk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ba52c998-b99a-e8bc-c78f-583e5e09e045@kernel.dk>
References: <ba52c998-b99a-e8bc-c78f-583e5e09e045@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ba52c998-b99a-e8bc-c78f-583e5e09e045@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-22
X-PR-Tracked-Commit-Id: 4a2dd2c798522859811dd520a059f982278be9d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c37b7189228cf972b5f899e0fedd89a83009ae25
Message-Id: <160081292070.1950.9963397165837885262.pr-tracker-bot@kernel.org>
Date:   Tue, 22 Sep 2020 22:15:20 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Tue, 22 Sep 2020 11:05:51 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.9-2020-09-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c37b7189228cf972b5f899e0fedd89a83009ae25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
