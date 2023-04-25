Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C994C6EE392
	for <lists+linux-block@lfdr.de>; Tue, 25 Apr 2023 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjDYOCn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Apr 2023 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjDYOCl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Apr 2023 10:02:41 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B575E3C15
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 07:02:40 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-763af6790a3so21219939f.0
        for <linux-block@vger.kernel.org>; Tue, 25 Apr 2023 07:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682431360; x=1685023360;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbSmchhnLqoxBBOB9jzlLo4OdNnltqZ5Dw4f7dze7p4=;
        b=VgEuSmnVeGcFhD19eLG2aJIJQKvz4ZPWM0hMuDNYNq+BKxR75DmV5/xn7GqmhsoYMR
         WxPr6zdb2B6WHF3Srj18a7fj3uKE0Nc2cCn+sobzPy7QQsk1C5FJm37J+eF86s2hPa0M
         avlbNfWyo1stoqb/j+8unWJYG66Q2wM6E1O4RVCgc+ACxLwpwnoE9DybYkOnRTUFL3ja
         mBJOlYaECuiA293Dj+LDq9Y2SLOzXvsdu5NnBx3hvBLS2M9C9heBknpYyUp6DXajK+Wf
         mdcOD5l9GrnmS90TgmSmtPdljLBOpNWCG4Od2I9QsoDhtL+V05ejsQKG+fv5s2h0S2UG
         DmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682431360; x=1685023360;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbSmchhnLqoxBBOB9jzlLo4OdNnltqZ5Dw4f7dze7p4=;
        b=OaFreaoLJqVSIyaLCqVf4y7AZrUE3r8uScVzpOGs3ddnfJfByt8p1MPGNDL28ntF3a
         pqzvovy01NAbETuwJU4spnhU0VX/dKzlfdq+M+65IBBYNrnBp+blkzXQc4IIOUt2Ll2h
         JEAPSvsCWcUkpdns+CJFBMrQVHeWqQcNXsPgksD2/cl7/XRii09t4bq0QXi6LhufBWSz
         2XrAQBZYXdIYnuFMXEUPaOHw+8uGYLnbqEAM1tvRtzgHwQYlSp4Z1aEFmOLd0faFBeDB
         RyqpGxtdjhTgCVcgRNFu9EJXQhep62/zamPl+peos+JMJ28P7mruaajJ7CVYOffjV8BJ
         OR8w==
X-Gm-Message-State: AC+VfDx38Wl5on530hT74zhER6gKTi+F/5amLGawTGj2GvTHGTjM2S+Z
        s1wLvRMGSO6T1+WfcIj9p7SD0Q==
X-Google-Smtp-Source: ACHHUZ7tihl5IcLne+etz9KF/64OCuhsafJExlla/uPvJwVFetjytc1OomzoQU7CPrNfKKdk5Du9zw==
X-Received: by 2002:a05:6e02:de5:b0:32a:d83e:491e with SMTP id m5-20020a056e020de500b0032ad83e491emr928945ilj.0.1682431359436;
        Tue, 25 Apr 2023 07:02:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t32-20020a05663836e000b0041284223319sm306309jau.88.2023.04.25.07.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 07:02:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     josef@toxicpanda.com, minchan@kernel.org, senozhatsky@chromium.org,
        colyli@suse.de, kent.overstreet@gmail.com, dlemoal@kernel.org,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        vincent.fu@samsung.com, akinobu.mita@gmail.com,
        shinichiro.kawasaki@wdc.com, nbd@other.debian.org
In-Reply-To: <20230424234628.45544-1-kch@nvidia.com>
References: <20230424234628.45544-1-kch@nvidia.com>
Subject: Re: [PATCH V2 0/1] block/drivers: remove dead clear of random flag
Message-Id: <168243135820.8048.11023111731807520461.b4-ty@kernel.dk>
Date:   Tue, 25 Apr 2023 08:02:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 24 Apr 2023 16:46:27 -0700, Chaitanya Kulkarni wrote:
> The drivers in this patch-series clear QUEUE_FLAG_ADD_RANDOM that is
> not set at all in the queue allocation path in :-
> 
> drivers/block/mtip32xx/mtip32xx.c:	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, dd->queue);
> drivers/block/null_blk/main.c:	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
> drivers/block/rbd.c:	/* QUEUE_FLAG_ADD_RANDOM is off by default for blk-mq */
> drivers/block/zram/zram_drv.c:	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, zram->disk->queue);
> drivers/block/nbd.c:	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
> drivers/block/brd.c:	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, disk->queue);
> drivers/md/bcache/super.c:	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, d->disk->queue);
> drivers/md/dm-table.c:	 * Clear QUEUE_FLAG_ADD_RANDOM if any underlying device does not
> drivers/md/dm-table.c:		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
> drivers/mmc/core/queue.c:	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
> drivers/mtd/mtd_blkdevs.c:	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, new->rq);
> drivers/s390/block/scm_blk.c:	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, rq);
> drivers/scsi/sd.c:		blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
> drivers/scsi/sd.c:		blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
> include/linux/blkdev.h:#define QUEUE_FLAG_ADD_RANDOM	10	/* Contributes to random pool */
> include/linux/blkdev.h:#define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
> 
> [...]

Applied, thanks!

[1/1] block/drivers: remove dead clear of random flag
      commit: 3f89ac587baa0c0460c977d1596e16f950815f05

Best regards,
-- 
Jens Axboe



