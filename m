Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7F07762C
	for <lists+linux-block@lfdr.de>; Sat, 27 Jul 2019 05:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfG0DFV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 26 Jul 2019 23:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfG0DFV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jul 2019 23:05:21 -0400
Subject: Re: [GIT PULL] Block DMA segment fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564196719;
        bh=fS9Eb7cR4XmTiNiZze10IhFHrsLE4tEHsHmxat6Wkmw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kef1GAm3Hs7C+aO88FpeVC1UEg9C2ooeujfChWq4TayL7iCViKD2uDlKYxbuwImX6
         jFMW51+z68hiMzxMynXeEN4wMKxz1pHUBwSEH6MegRsbC95aURjph90cMYgXsK7qBn
         8Y2eqExJWuQ9fIfKe7cIVrjbsvClgKkQQ+Ikbpvs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <71d2d2b5-77fa-e984-b417-bbfd24ad0309@kernel.dk>
References: <71d2d2b5-77fa-e984-b417-bbfd24ad0309@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <71d2d2b5-77fa-e984-b417-bbfd24ad0309@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/for-linus-20190726-2
X-PR-Tracked-Commit-Id: c6c84f78e2f77be37b9a150ed33be992198741f0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5168afe6ef596eaf2ff7a533b780c79ce14445e4
Message-Id: <156419671945.31249.5885146622143661974.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jul 2019 03:05:19 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 26 Jul 2019 18:53:01 -0600:

> git://git.kernel.dk/linux-block.git tags/for-linus-20190726-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5168afe6ef596eaf2ff7a533b780c79ce14445e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
