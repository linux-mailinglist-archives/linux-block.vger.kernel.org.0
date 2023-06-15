Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA8731A13
	for <lists+linux-block@lfdr.de>; Thu, 15 Jun 2023 15:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbjFONet (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Jun 2023 09:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjFONeO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 09:34:14 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253B30F8
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 06:33:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6664ac3be47so396385b3a.0
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2023 06:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686836027; x=1689428027;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sVR+vT8DdsvA3Z3S0QOP6jSANdRArM8WL8xik+euJ7U=;
        b=DEJZBn0jRo+nrmjAYfVbkW/mbWTo9TPUh5Zk5FdEZ9pNqXulFJpZdIL6dCbj+nxtYS
         zcZv11ORnK6I++2adpuFhjl0ft85vJq3OrXtav0aI4US0+3khl91+a+ZlJDjLB7gWOV3
         TL/LSTeYzjcZht0650UgDtwxgCQToPTz4Uzvkm/KwSKr+RKEp0szPSV+3yrBpWxmz8aF
         BGLXUncI1pi+EeL4aNxttKZJn2qmvi5Hv1XuwsJh3/vCgx6DZU8SLeXeo0PgjwCmr6RU
         lrTtxLpVwmaHEHOVBQTylSMH/9Qk0C2lntzNe91kKp6XtrlCCXay1JBOj9YToZZZ+RIj
         MWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686836027; x=1689428027;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVR+vT8DdsvA3Z3S0QOP6jSANdRArM8WL8xik+euJ7U=;
        b=d/66j3kFjL7YjKaP8x0KkpujVMV4Q5YcW8c50anjMzIpCKq773Q0TPGkCxDuCFEqzA
         y/YVnvsb+5oRmgV3mq1B98HY1f5DaxKDcaiDwkJ4ikwmV5XzaJjJp9OYP4k20hxYkhww
         nUJfRowKWorX56+Sa2oUsFmijQx4tKP+PipIMAlWNhlHB3kU2C+Qwzxi1fX/PkhPJmdr
         F3ZAlDuzsyWsvYhLhorp4Jvspw4PYwQceD3mCV/mBXs9h/YTyUxCZVbaC5AxdX4kjmdP
         CoQ0X6DSGoVcbyaIt9cf4ROfG/o6JA2Zu3ctQgNidmfrElj8muhb3vuMT47syjQwoQ73
         AKrw==
X-Gm-Message-State: AC+VfDwTcrjBD/OXqzgkdQ3vKp6btNdGMgjTuJOjJ91hcDNOf77Cutfl
        Hee9dJhfPLEJQGQMm6I2WXFUDA==
X-Google-Smtp-Source: ACHHUZ4hYDWKSnGc0F3oLOsil5ywgqcuGr7h8N6KfecEA3vYODtqH0U/YpLcDAf/Ug39JuiuTrNGXw==
X-Received: by 2002:a05:6a20:8e19:b0:11a:efaa:eb88 with SMTP id y25-20020a056a208e1900b0011aefaaeb88mr15781079pzj.3.1686836026892;
        Thu, 15 Jun 2023 06:33:46 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x17-20020aa793b1000000b00640dbf177b8sm12062928pff.37.2023.06.15.06.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 06:33:45 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20230615121223.22502-1-colyli@suse.de>
References: <20230615121223.22502-1-colyli@suse.de>
Subject: Re: [PATCH 0/6] bcache-next 20230615
Message-Id: <168683602549.2139966.16055841086380737489.b4-ty@kernel.dk>
Date:   Thu, 15 Jun 2023 07:33:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 15 Jun 2023 20:12:17 +0800, Coly Li wrote:
> I start to follow Song Liu's -next style to submit bcache patches to
> you. This series are minor fixes I tested for a while, and generated
> based on top of the for-6.5/block branch from linux-block tree.
> 
> The patch from Mingzhe Zou fixes a race in bcache initializaiton time,
> rested patches from Andrea, Thomas, Zheng and Ye are code cleanup and
> good to have them in.
> 
> [...]

Applied, thanks!

[1/6] bcache: Convert to use sysfs_emit()/sysfs_emit_at() APIs
      commit: a301b2deb66cd93bae0f676702356273ebf8abb6
[2/6] bcache: make kobj_type structures constant
      commit: b98dd0b0a596fdeaca68396ce8f782883ed253a9
[3/6] bcache: Remove dead references to cache_readaheads
      commit: ccb8c3bd6d93e7986b702d1f66d5d56d08abc59f
[4/6] bcache: Remove some unnecessary NULL point check for the return value of __bch_btree_node_alloc-related pointer
      commit: 028ddcac477b691dd9205c92f991cc15259d033e
[5/6] bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent
      commit: 80fca8a10b604afad6c14213fdfd816c4eda3ee4
[6/6] bcache: fixup btree_cache_wait list damage
      commit: f0854489fc07d2456f7cc71a63f4faf9c716ffbe

Best regards,
-- 
Jens Axboe



