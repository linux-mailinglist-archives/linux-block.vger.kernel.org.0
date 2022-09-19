Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37275BD369
	for <lists+linux-block@lfdr.de>; Mon, 19 Sep 2022 19:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiISROG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Sep 2022 13:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiISRNR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 13:13:17 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F122DB6
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 10:12:52 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id x13so5739259ilp.3
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=isFqxYJS0Ih2m1cQEE/2UjOIr1qkpqnToPzi0naES18=;
        b=cRgoJ9/zZiUayTqe5THraccN+zuECYLtzSk2ttJDhyPy4lH49fbFQu/z5Lqby4K4GZ
         RSZ8gMuUcx0iSNtbi3bjMoguFrgdEV+bh3rqLdADfaXyHJ9zIXVrdOM/iMmJ66GB+qyH
         7wxp86wjzPTK9UrCsdW0Cfirwcw7SdQl6RCtTwY7ZMOJsYJnt0aSb1ue76BPfd/7vx4K
         KwYF0P/jpLEUFBbzygxeClTgAsYdtB2mxByA3nfuK+QufrneoqSV9aX8x7c6XTd+stH2
         dLYsFbB6te9SBTJ3L8qDRZRNC+pN3v4HIYB9YEwB64Km6ZjFJblmrrSllnPI50CGhK+H
         kEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=isFqxYJS0Ih2m1cQEE/2UjOIr1qkpqnToPzi0naES18=;
        b=4PWQetk7AVVs1U3aIpsfkos5iH6G3czb33fsZ43bjMUlAwPkq3ls8Xd5KnKyDhtFJw
         RclMMdvGnG5p3Zqevb1ybVvKcWZYSO8k/sLRVYF106Ue97AEVASaNAEMiLhcr+SECNJ/
         5Mhq7DiFVwSqDwgteHehXTMfKc0IHv3cgYXl/W1MZmEEKblu8LDGgxo/ijteJ7brBQH/
         utIG1R6Z3/m/Jt89nUJxZwiRWCjQjoAAvnG2icX36WgiEGsm9KhLjk4786ArInj/k1Do
         l3rchuWHtfRwDE8JHQdQIuvdgzE7qYwG5rXCCEjrw62JdD2aFxJE8LrVSxTfpf6iSgmb
         J+Ow==
X-Gm-Message-State: ACrzQf0G5DJzH/aX4EDSLsEJZMwQb169bh05UMFz8qsV9Dw0riZVbGsZ
        xtDNnDTpeIhaZbFghQaU1xIKtgsI6tWkqA==
X-Google-Smtp-Source: AMsMyM4VKFA6gmD9GzgAsEzHhgIdT3ZLUDquZvpLKy03aFVmB1pIVeBLkFenBtK2NZ0b5tjh7f2TlA==
X-Received: by 2002:a05:6e02:ec7:b0:2f5:4c1:5208 with SMTP id i7-20020a056e020ec700b002f504c15208mr6060138ilk.178.1663607571422;
        Mon, 19 Sep 2022 10:12:51 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n2-20020a056638110200b003580ab611a2sm5662875jal.93.2022.09.19.10.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:12:50 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Coly Li <colyli@suse.de>
Cc:     linux-block@vger.kernel.org, linux-bcache@vger.kernel.org
In-Reply-To: <20220919161647.81238-1-colyli@suse.de>
References: <20220919161647.81238-1-colyli@suse.de>
Subject: Re: [PATCH 0/5] bcache patches for Linux v6.1
Message-Id: <166360757047.16805.18160063101665809906.b4-ty@kernel.dk>
Date:   Mon, 19 Sep 2022 11:12:50 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-355bd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 20 Sep 2022 00:16:42 +0800, Coly Li wrote:
> This is the 1st wave bcache patches for Linux v6.1.
> 
> The patch from me fixes a calculation mistake reported by Mingzhe Zou,
> now the idle time to wait before setting maximum writeback rate can be
> increased when more backing devices attached.
> 
> And we also have other code cleanup patches from Jilin Yuan,
> Jules Maselbas, Lei Li and Lin Feng.
> 
> [...]

Applied, thanks!

[1/5] bcache: remove unnecessary flush_workqueue
      commit: 97d26ae764a43bfaf870312761a0a0f9b49b6351
[2/5] bcache: remove unused bch_mark_cache_readahead function def in stats.h
      commit: d86b4e6dc88826f2b5cfa90c4ebbccb19a88bc39
[3/5] bcache: bset: Fix comment typos
      commit: 11e529ccea33f24af6b54fe10bb3be9c1c48eddb
[4/5] bcache:: fix repeated words in comments
      commit: 6dd3be6923eec2c49860e7292e4e2783c74a9dff
[5/5] bcache: fix set_at_max_writeback_rate() for multiple attached devices
      commit: d2d05b88035d2d51a5bb6c5afec88a0880c73df4

Best regards,
-- 
Jens Axboe


