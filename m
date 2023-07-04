Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFD5746726
	for <lists+linux-block@lfdr.de>; Tue,  4 Jul 2023 04:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGDCHQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 3 Jul 2023 22:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjGDCHP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jul 2023 22:07:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0603E54
        for <linux-block@vger.kernel.org>; Mon,  3 Jul 2023 19:07:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 752456105A
        for <linux-block@vger.kernel.org>; Tue,  4 Jul 2023 02:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE953C433C7;
        Tue,  4 Jul 2023 02:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688436433;
        bh=wrrzEm6ANoHSdiDF3cqjB7b3TkH7b3reJwfU7hyTK7g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q/SATwid0S/s0+c/EUYX8KaajQtaVD7yTy6QCyXfkGDD0bds3OaCohNBI68/YtYSw
         zRRFV9LWkOjj5TzrfNOhOqKKEW5g4jp3tk3sAAIZ/OuarveIjmrbVsYCjZ5rzIjIHE
         SXa95iy2YRSehhLk3BpDOzKaMaaLgOAeiOeCetHSTZ600KyyznFOa5z9yFZnkoFcV/
         BayEjFO8jMfiJYF3OAJSX82XZ4hOjw3ys76hs1DerNJCU6a3vgsDe7s4idppgaYrtN
         SPb/dZQrUiSkWAo/4jr/fgcgnvsDamGtqknKPUmFv2IZEzGlK61gwt2ZYajj/05LUJ
         XPSDBXxCFWeoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB144C04E32;
        Tue,  4 Jul 2023 02:07:13 +0000 (UTC)
Subject: Re: [GIT PULL] Block fixes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <23c4b3f1-9a66-5a30-dc94-defe37d4ef7f@kernel.dk>
References: <23c4b3f1-9a66-5a30-dc94-defe37d4ef7f@kernel.dk>
X-PR-Tracked-List-Id: <linux-block.vger.kernel.org>
X-PR-Tracked-Message-Id: <23c4b3f1-9a66-5a30-dc94-defe37d4ef7f@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/block-6.5-2023-07-03
X-PR-Tracked-Commit-Id: 3c2f765c81be1c85782ba09f492800a99f765a2c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e50df24979fd02f920aa7baada714a58bc61bfd9
Message-Id: <168843643382.21068.14423723235154664498.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Jul 2023 02:07:13 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 14:14:50 -0600:

> git://git.kernel.dk/linux.git tags/block-6.5-2023-07-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e50df24979fd02f920aa7baada714a58bc61bfd9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
