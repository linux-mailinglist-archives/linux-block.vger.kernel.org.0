Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6D73748E
	for <lists+linux-block@lfdr.de>; Tue, 20 Jun 2023 20:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjFTSvH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Jun 2023 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjFTSvG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 14:51:06 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DD110DA
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 11:51:05 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-760dff4b701so66699039f.0
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 11:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687287065; x=1689879065;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PH9U1GciLcffQVM1V+VcYCG1trbS8e6bKZdDd69R6dI=;
        b=ATqqGY9AdErY3+V3xe8TN6ttF0o+pvdPmlUkdxyCa5io+mq0rg7bRw2Xy4jgO0opMA
         QBaB7RQ6ZuCQOeJ/HF9a5H23Q5uh01/37miwin2YumX1MfZLsr6YlXqHG7w/cXzxjvNo
         IHv0Njxrp9WnJ749bL31QSGfo5Xfjt4RwlBj89aMZyIAvU6Ll5qXaU2Lk/Ka5OZUjxjE
         l8mGM7WejTahIq1+Riluhwk5Y+gdjWQ+5TtdkKLd0zAQ18Ot1NQAR0Sp7foI0gI8OIKW
         sahO7zFw+SHCFOUByd72fRNlxx6sURBT16n0dGag083QfuPvnYPfM+FrSBm10bcKz/ah
         Ub8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687287065; x=1689879065;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PH9U1GciLcffQVM1V+VcYCG1trbS8e6bKZdDd69R6dI=;
        b=QzSlD/+EmIT7Eub3js00UI43sH3hkl8smvpMPsDDJAPjj58NktuKLJRDQWcsE8sC/p
         c1SJeRx1WY0BAJvqmGkBlwPkP2nY5VBqPHc9nWiM4s6LKVpN5ISYHJYZjL8RkfxjDqtN
         UcurKkn7WfZkrXtybuU0WOlmhQUWh5VV5sF7slBz5ROtAexyCKY7JfJvSHlqdRUsbK6o
         hFA14qIqS4os2oz9OokwPJlERZ2B02InNdt0aTLvSix8/0xqvXJk8hCMVwDXYBoOjLbt
         BxXAHdlxp409Zm2MKuV7xIQE/IUmoLJRKO4C2uqT8QBO9lvKdZApNfVNS/n4Nvy59awc
         YnBw==
X-Gm-Message-State: AC+VfDwgyH47I2AOxFF/Kc0jcc5p155aGvL+MmJZNwFsgIctS216yfPe
        u9js1tGfFWnhpCt4hOrXXXe/wQ==
X-Google-Smtp-Source: ACHHUZ6JcQYt1gY7JT3gA7kSkbAThh9BGtFH2gcTnYfHW79Lppn2Jl2PykBaiFcfADGq3gF8n0bqnQ==
X-Received: by 2002:a6b:b744:0:b0:77e:23a7:c9eb with SMTP id h65-20020a6bb744000000b0077e23a7c9ebmr10423206iof.0.1687287065127;
        Tue, 20 Jun 2023 11:51:05 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g8-20020a02c548000000b004266ca33533sm781009jaj.108.2023.06.20.11.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 11:51:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, linux-block@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com,
        xiang@kernel.org, casey@schaufler-ca.com
In-Reply-To: <20230613084008.93795-1-jefflexu@linux.alibaba.com>
References: <20230613084008.93795-1-jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v3 0/2] block: fine-granular CAP_SYS_ADMIN for
 Persistent Reservation ioctl
Message-Id: <168728706409.3766608.15899699355172012689.b4-ty@kernel.dk>
Date:   Tue, 20 Jun 2023 12:51:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 13 Jun 2023 16:40:06 +0800, Jingbo Xu wrote:
> changes since v2:
> - patch 1: disallow reservations on partitions entirely and make it into
>   a separate patch (hch)
> - patch 2: rebase to hch's series of converting fmode_t to blk_mode_t
>   and execute permission check upon blk_mode_t (hch)
> 
> changes since RFC:
> - only allow unprivileged reservations if the file descriptor is open
>   for write (Christoph Hellwig)
> - refuse the unprivileged reservations on partitions (Christoph Hellwig)
>   (maybe this checking shall also be done when CAP_SYS_ADMIN is set?)
> 
> [...]

Applied, thanks!

[1/2] block: disallow Persistent Reservation on partitions
      commit: 12629621669b239445727256d1a5dab616b30deb
[2/2] block: fine-granular CAP_SYS_ADMIN for Persistent Reservation
      commit: 9a72a02456a839676fe8f220a44ef00951596047

Best regards,
-- 
Jens Axboe



