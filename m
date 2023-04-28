Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9283B6F1D58
	for <lists+linux-block@lfdr.de>; Fri, 28 Apr 2023 19:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjD1RYj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Apr 2023 13:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjD1RYh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Apr 2023 13:24:37 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A58D6181
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 10:24:22 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-763af6790a3so465839f.0
        for <linux-block@vger.kernel.org>; Fri, 28 Apr 2023 10:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682702661; x=1685294661;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w71THNOBoAMfVXYY6waVnBZ0ybumdVZGzSg2o1tNPwU=;
        b=QXHdhIKC5KoITG+RCzA5FgR05xtm2OvzY5RDwtW2Vusq39oPlV1bMgLMiMa4UxzTUG
         HZbfX51L9iURqiqqZEYIuhoubTub+gu1yoZfnIZnozMfuY/ilTLeAqtXEfxwmdWSz/b2
         5d/cjNMV0mB40/ST2hW+b2rnyM84DvBf5cnDBjQgvmD6mxdLeVoUx4U1jBmf39AfbIqm
         qfYkMj3owsgZ3UgTtZe9E2JDrH04oZzDkNrPvfOEPCt3QLxgq9HCVCVg/UR7KaMSKYvR
         TUdflAU74E1vhYOKXmdiVvOO/Zgz4/ljWdAz+dzlzG33qJ6mnCRTCMldwVJBn24A6QE0
         MLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682702661; x=1685294661;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w71THNOBoAMfVXYY6waVnBZ0ybumdVZGzSg2o1tNPwU=;
        b=JvFzYtF6C8Wqzztz3Xd3uoDf0kUmnUHOHxLiPZvfrSnzsbE4t/U4tP89HYy5qqOJpF
         JrFzEX2aoCUdBU+8qMmAX/DNdJvJD5zZrPHvKzqnwpL8yML9NsyPE7932gunCe1MOX40
         OUEt1jBmyOdMxu4H54GQ8cPFCYXNXJ0TXWVEfWmaPF+zEDBjRCh79Y8dPzcatEk+JZez
         vDgPdEVrpmo1jD5oBeBDDQeDn9Zw15GgoqcJZtHo15/r21RJyS2kxz87bbJNeKLVGxZM
         c/q3eQhhhCZHxyEoR0uRfP8KBquid4vguBPfCprDOHtHAjRLsAed6cb68nrXywtUJWF4
         EasA==
X-Gm-Message-State: AC+VfDzoUihaUH+GGtkYGuajZmDlDl+FzLF7LjMEQBvsjMOqXF4dDgba
        qj1lrO1tOntS2o0XdDEfj8RVMQ==
X-Google-Smtp-Source: ACHHUZ4JOHtDWFQ4LGodQJQeTbDcb7k6hlLrpmBWoRmVlj/GYdnpPh27RpobDIIXY9ZqPqEj+V2A1g==
X-Received: by 2002:a05:6e02:1be4:b0:32a:a8d7:f099 with SMTP id y4-20020a056e021be400b0032aa8d7f099mr2048199ilv.3.1682702661611;
        Fri, 28 Apr 2023 10:24:21 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l17-20020a056e020dd100b0032a99a9eb8esm5644765ilj.40.2023.04.28.10.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 10:24:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tao Su <tao1.su@linux.intel.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, yukuai1@huaweicloud.com
In-Reply-To: <20230428045149.1310073-1-tao1.su@linux.intel.com>
References: <20230428045149.1310073-1-tao1.su@linux.intel.com>
Subject: Re: [PATCH v2] block: Skip destroyed blkg when restart in
 blkg_destroy_all()
Message-Id: <168270266088.259022.9566325777722187933.b4-ty@kernel.dk>
Date:   Fri, 28 Apr 2023 11:24:20 -0600
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


On Fri, 28 Apr 2023 12:51:49 +0800, Tao Su wrote:
> Kernel hang in blkg_destroy_all() when total blkg greater than
> BLKG_DESTROY_BATCH_SIZE, because of not removing destroyed blkg in
> blkg_list. So the size of blkg_list is same after destroying a
> batch of blkg, and the infinite 'restart' occurs.
> 
> Since blkg should stay on the queue list until blkg_free_workfn(),
> skip destroyed blkg when restart a new round, which will solve this
> kernel hang issue and satisfy the previous will to restart.
> 
> [...]

Applied, thanks!

[1/1] block: Skip destroyed blkg when restart in blkg_destroy_all()
      commit: 8176080d59e6d4ff9fc97ae534063073b4f7a715

Best regards,
-- 
Jens Axboe



