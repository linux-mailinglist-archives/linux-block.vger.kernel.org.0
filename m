Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202B673C4F4
	for <lists+linux-block@lfdr.de>; Sat, 24 Jun 2023 01:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjFWXxa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Jun 2023 19:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjFWXx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Jun 2023 19:53:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCF310F1
        for <linux-block@vger.kernel.org>; Fri, 23 Jun 2023 16:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E3B060B54
        for <linux-block@vger.kernel.org>; Fri, 23 Jun 2023 23:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82597C433CD;
        Fri, 23 Jun 2023 23:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687564406;
        bh=3Q9zDxeGA5JYZBffJc0C3zESYpx6ksvvU1Z7H8AviS0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G8zJbdSVO5SPcomA3l5kJbGWTD9dJoNXlX7ZnSCyFvDho9vpaN6F8eIuzNALNnHu+
         RFvfhkc4FnT5hwX7y6ktu1UNaoST1pB6e+/iHRT/w0vvGcFFAZyg8Siv6RXLd4MSvn
         Yc4zZofHxUQ7//hLWpuan/yq5EsDBcpmzTt7I8dA7XYIMMJGw8afycJ96Lj4NUPM1K
         oBYc2VZXu/PpVuRCYRiG4aTqrEOpiyY93hXj49SGqKh6iagX5GoNIQtdmw34F7A7J/
         dF6Ci16WcQkaES3SIOfYNuK1eksR5cQ6PwhyncPA7GDPXXdkTc3HmZgxE7JCYudpUT
         PcEDVjHlUX4Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 703AAC43143;
        Fri, 23 Jun 2023 23:53:26 +0000 (UTC)
Subject: Re: [GIT PULL] Block fix for 6.4-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <19981b0a-f3e2-ec8a-f413-5a9697472750@kernel.dk>
References: <19981b0a-f3e2-ec8a-f413-5a9697472750@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <19981b0a-f3e2-ec8a-f413-5a9697472750@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.4-2023-06-23
X-PR-Tracked-Commit-Id: 9c39b7a905d84b7da5f59d80f2e455853fea7217
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9cb38381bac9f629fd4e7eafef27066c23c3eaf9
Message-Id: <168756440645.22934.1718570757634474636.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 23:53:26 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Fri, 23 Jun 2023 12:52:04 -0600:

> git://git.kernel.dk/linux.git tags/block-6.4-2023-06-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9cb38381bac9f629fd4e7eafef27066c23c3eaf9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
