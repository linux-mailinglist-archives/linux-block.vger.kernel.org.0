Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE0E1AE3FA
	for <lists+linux-block@lfdr.de>; Fri, 17 Apr 2020 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgDQRpb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 17 Apr 2020 13:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbgDQRpa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 13:45:30 -0400
Subject: Re: [GIT PULL] Block fixes for 5.7-rc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587145529;
        bh=aNYaOxxB1m0g7coZTESdvIulaLbkpvpjC8dst6hi9sE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AZsxINB5yqHeM3wBj4Z8Cnk5tknuSSGZXaqJ8Oyg6GXHeX0qDEbmg6RnxH8C/N6on
         kbLlOrxSThP5IVtHxH5sqNIKPTvXffW08TFpgij251yC46nujBV22zVGMljYfvmlwE
         YZ4XMQHHQGkoXC15B4Xc79iJDt+v+v5A6WIbjitg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <26613a68-19f0-e588-d9d8-da8f5a1f95f9@kernel.dk>
References: <26613a68-19f0-e588-d9d8-da8f5a1f95f9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <26613a68-19f0-e588-d9d8-da8f5a1f95f9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.7-2020-04-17
X-PR-Tracked-Commit-Id: 3f22037d382b45710248b6faa4d5bd30d169c4ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf9196d51f7d7222875916c685653981088668b1
Message-Id: <158714552979.1625.13505670253634285544.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 17:45:29 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 09:13:28 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.7-2020-04-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf9196d51f7d7222875916c685653981088668b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
