Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48A18212F86
	for <lists+linux-block@lfdr.de>; Fri,  3 Jul 2020 00:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGBWaM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Jul 2020 18:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgGBWaL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Jul 2020 18:30:11 -0400
Subject: Re: [GIT PULL] Block fixes for 5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593729011;
        bh=fs5x2iuusTFQA1FO/XXkeZ6ZkpMa2NTHaua2aMR2AwE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R6r9HdRteUHCftJN1AisIwcVrfKFxL9YXTK4LeUywzbVG0UyElWxogEwy7NgbypWp
         B5bFvx44zcQDZLi/6JavOfXqssZwoSap/Fm7UwmgyXfsFAP9aHDdm1cJyGVE3mGW+g
         5FZ5bE5+ZfMrhRKky108rGEtWS1Xp26nguY89SOY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <70c99f08-5396-92d3-ff45-091a56216452@kernel.dk>
References: <70c99f08-5396-92d3-ff45-091a56216452@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <70c99f08-5396-92d3-ff45-091a56216452@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git
 tags/block-5.8-2020-07-01
X-PR-Tracked-Commit-Id: e7eea44eefbdd5f0345a0a8b80a3ca1c21030d06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cc2a8ea104820dd9e702202621e8fd4d9f6c8cf
Message-Id: <159372901107.6563.14124092494857442078.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Jul 2020 22:30:11 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Wed, 1 Jul 2020 22:31:45 -0600:

> git://git.kernel.dk/linux-block.git tags/block-5.8-2020-07-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cc2a8ea104820dd9e702202621e8fd4d9f6c8cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
