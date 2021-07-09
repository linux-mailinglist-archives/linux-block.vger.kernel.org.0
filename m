Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE163C2985
	for <lists+linux-block@lfdr.de>; Fri,  9 Jul 2021 21:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhGITXi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 9 Jul 2021 15:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbhGITXi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Jul 2021 15:23:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 38E4D613C5;
        Fri,  9 Jul 2021 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625858454;
        bh=UtBLEuZqQAoGcRxBT9Tj32PuJYLkOT8KB66WApJ3BjI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tIcohmw4Y7w0iW6Efx7vSumicWOtrg5yu877dHMV1Ff/QrQsRRrWhD3HhOJfHF044
         D3SaSoLus32jmoBETuGmqZlz5A66cxY7sb+9Npe76BGna/IPUMb9p95Cjl5gjAVjMv
         ZQhxlPJCFMUDFuZG2bP1eGMWAgIb7p82TmgFRvVKQFZ09C/fddeNKhszneZclNBzYk
         sIu8M2WZfRL2K9+43s/djR5hh75+wMMqibvIl6fwFxC/UVL5KylfIoYlIJNqxyVmHg
         6+8dvjrhAUQ5hP7cm4cWr4pHCJEq4wVwiu5KAzGfei6vMnbpda1qHu2NsbsiVqjynN
         71ZXg1jUKfUug==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 31F1E609AD;
        Fri,  9 Jul 2021 19:20:54 +0000 (UTC)
Subject: Re: [GIT PULL] Followup block changes for 5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <80e0449b-eb7a-35e2-4d49-517c744fa371@kernel.dk>
References: <80e0449b-eb7a-35e2-4d49-517c744fa371@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <80e0449b-eb7a-35e2-4d49-517c744fa371@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-08
X-PR-Tracked-Commit-Id: a731763fc479a9c64456e0643d0ccf64203100c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a022f7d575bb68c35be0a9ea68860411dec652fe
Message-Id: <162585845419.13664.9694136429967901648.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jul 2021 19:20:54 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 8 Jul 2021 09:36:58 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.14-2021-07-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a022f7d575bb68c35be0a9ea68860411dec652fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
