Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC14EFD40
	for <lists+linux-block@lfdr.de>; Sat,  2 Apr 2022 01:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbiDAXqx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 1 Apr 2022 19:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353532AbiDAXqY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 19:46:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075991FAA28
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 16:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3823AB8268C
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 23:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6198C3410F;
        Fri,  1 Apr 2022 23:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648856636;
        bh=Zyi8NgCmQ666vasYy4YkjNiHr77XUVkvikil6Bhn6f0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=i14g/e/nKgXPduFshDjCdxZgYIGtEVd3IRgfHbj3uPVQqH1RREid0iZyzVxQnN6Gg
         05eZJS4Nq/WjpjStK36ULAD7R5H5SdhdZcpb9dyMADQSu57OvpdyRP6pmInHhqP+F1
         N+7Q/3rTSauQ1+ltA4qFa/hRfJ/tvwaZ0RngYk87NB61jRpuCGR3HCEJAZ+o3MjJC/
         4ehOOYU5e+a0Nx1ZC0dh2tTkBRcrnGnOs8rIVxIQkW1Bp0kPkVOdW4LufqYvsv0a6P
         l9DPEj6rw9VLn3Eqj+lY4A7kl3UouV9EYG7hqnVywVzvX4JwQMDe3KF6hIuvzrMxdt
         wFZceQ9HtGnJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5BFFE6BBCA;
        Fri,  1 Apr 2022 23:43:56 +0000 (UTC)
Subject: Re: [GIT PULL] Block driver fixes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d5869c35-c548-a84a-6355-8dfa0bf6eced@kernel.dk>
References: <d5869c35-c548-a84a-6355-8dfa0bf6eced@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <d5869c35-c548-a84a-6355-8dfa0bf6eced@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux-block.git tags/for-5.18/drivers-2022-04-01
X-PR-Tracked-Commit-Id: 2651ee5ae43241831ca63d7158bb2b151a6a0e1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8467b0ed6ce37f7e3f87aa3826627dc9cc55ecb2
Message-Id: <164885663680.32259.18141769834542296288.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Apr 2022 23:43:56 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 1 Apr 2022 13:38:30 -0600:

> git://git.kernel.dk/linux-block.git tags/for-5.18/drivers-2022-04-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8467b0ed6ce37f7e3f87aa3826627dc9cc55ecb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
