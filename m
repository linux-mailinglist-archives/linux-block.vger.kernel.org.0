Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DD91B811E
	for <lists+linux-block@lfdr.de>; Fri, 24 Apr 2020 22:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDXUuV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 24 Apr 2020 16:50:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgDXUuU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 16:50:20 -0400
Subject: Re: [GIT PULL] Block fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587761420;
        bh=UUgtkvnOQim24JhLqR//M/u0bvA+zxJ/n7G+K54HSL0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=izg8d0XCZ7bQaVpeYtQCm2QKbSyQ7U7cUnOnIb9ZiLd/kh5NbryrxO2vTM1ORzEyE
         GMGO5rscU6i7YggmkqUWevoOsWM5KSJplrAOVJM5iOKNTqMH1eARRS5kmnykk+U3TW
         sOYa8lx64+0L19m34eURD4XYwPmgQcmJex6nGcJk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ba58ee4a-7203-0365-6939-1096c8693cf9@kernel.dk>
References: <ba58ee4a-7203-0365-6939-1096c8693cf9@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <ba58ee4a-7203-0365-6939-1096c8693cf9@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.7-2020-04-24
X-PR-Tracked-Commit-Id: d205bde78fa53e1ce256b1f7f65ede9696d73ee5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d29cb17baec4988bc1505a43138848a670017a3
Message-Id: <158776142052.11860.10910131000018110716.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Apr 2020 20:50:20 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 24 Apr 2020 12:00:42 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.7-2020-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d29cb17baec4988bc1505a43138848a670017a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
