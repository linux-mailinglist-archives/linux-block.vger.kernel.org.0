Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E9D69D6D4
	for <lists+linux-block@lfdr.de>; Tue, 21 Feb 2023 00:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjBTXAR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Feb 2023 18:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjBTXAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Feb 2023 18:00:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2EB1A483
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 15:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD9DC60F4B
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 23:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EEDAC433A7;
        Mon, 20 Feb 2023 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676934013;
        bh=3xrkfcjjBDSsA2aYOjGu3kpBK+UXSm82G3ISQmG525A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uNuXmqTwKjVU54Q8bALjEwH+8jTGpSQ0KhUWfw4updhMaL+u90cjkeqHOUx3DVRv5
         jLMu0QlwShJw4IUj6lHm9IpzRaNDKLjotne6LK3DUqozjU3Q7Ip7igQ7pwdErXL/DH
         vwwkeDe5N7HfKdAHrIOnUc88K2JwRJy0ey/j3QG5lkESKkG7akZcIXflUwxYoB0HkC
         REvs876DN/FaO5zbhLV+KqROY7rXK8nV0DeJthrnmL7MzUbJV/ZdJH3+FQfoGWFQVQ
         6JwM5cFVOho36qHi0Pko0rrJfU6Nvy3soOC5GeOH7cs11iC9NlfKEAbJES3Hcu3P5Y
         DS0yNP/aFB0zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D2A4C43161;
        Mon, 20 Feb 2023 23:00:13 +0000 (UTC)
Subject: Re: Re: [GIT PULL for-6.3] Block updates for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <fbba0347-784e-6b08-2a23-d59c2f1c8e2b@kernel.dk>
References: <5afa0795-775d-f710-7989-4c8e1cd7b56f@kernel.dk> <fbba0347-784e-6b08-2a23-d59c2f1c8e2b@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <fbba0347-784e-6b08-2a23-d59c2f1c8e2b@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/for-6.3/block-2023-02-16
X-PR-Tracked-Commit-Id: 0aa2988e4fd23c0c8b33999d7b47dfbc5e6bf24b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5b0ed5964928b0aaf0d644c17c886c7f5ea4bb3f
Message-Id: <167693401350.6080.13421153609617441075.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 23:00:13 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 12:23:48 -0700:

> git://git.kernel.dk/linux.git tags/for-6.3/block-2023-02-16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5b0ed5964928b0aaf0d644c17c886c7f5ea4bb3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
