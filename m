Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0E16593F1
	for <lists+linux-block@lfdr.de>; Fri, 30 Dec 2022 02:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiL3BBM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Dec 2022 20:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiL3BBL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 20:01:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44ED62D1
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 17:01:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 751DCB81AB8
        for <linux-block@vger.kernel.org>; Fri, 30 Dec 2022 01:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F875C433F0;
        Fri, 30 Dec 2022 01:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672362068;
        bh=2pz0LcaOPDGcm76H27kZdim4DwcirkpsKuXE6JG9+3U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=D+efappkVtLRJ37NA6rA+qOW2KxVA5TrnvyWbkGKjqTfkQaAYFS78Gog8HMDqzrgy
         hwT4FPMCbxnZajzg5g1PuNKT9jBfrhB8VVKglDLme/lLiNAiTV5W6wJ94bq30XFQe3
         Im0YmuOGRG+i+UplILlGMJHo+vEDt5sT8Xh+bOQBrSKskVIOCwBjoz2SDj2kFYXvxn
         wAThoEojhHBBUx/04+qgQOcevez9RxioRRNFiAsrfR4rqaHvQQPpx7xkFYjgGyGN7/
         ugYB5XOtOxESgAcwalI23ssbsMJo+OKWzSl1lYLbwFQqVfWJI8w34TQt3qf0ABA3B0
         TXXnHSIzMzLZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D6E8C43141;
        Fri, 30 Dec 2022 01:01:08 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.2-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <66ad5fb6-f9de-e47f-336c-7ab14424732f@kernel.dk>
References: <66ad5fb6-f9de-e47f-336c-7ab14424732f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <66ad5fb6-f9de-e47f-336c-7ab14424732f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.2-2022-12-29
X-PR-Tracked-Commit-Id: 1551ed5a178ca030adc92b1eb29157b5e92bf134
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bff687b3dad6e0e56b27f4d3ed8a9695f35c7b1a
Message-Id: <167236206805.9684.17957880617362968279.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Dec 2022 01:01:08 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Thu, 29 Dec 2022 16:36:29 -0700:

> git://git.kernel.dk/linux.git tags/block-6.2-2022-12-29

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bff687b3dad6e0e56b27f4d3ed8a9695f35c7b1a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
