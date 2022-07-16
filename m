Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F44F576DF1
	for <lists+linux-block@lfdr.de>; Sat, 16 Jul 2022 14:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiGPMdf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 Jul 2022 08:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiGPMdd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jul 2022 08:33:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4691EC57
        for <linux-block@vger.kernel.org>; Sat, 16 Jul 2022 05:33:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a15so7912301pjs.0
        for <linux-block@vger.kernel.org>; Sat, 16 Jul 2022 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=WoxOauBVq0ZnUhdfV+eZctOBrPVihgWTZtcQPSl6xl4=;
        b=ODPdQlGcBGKx+FjTEMgMcnwbzuUGZ15Zd4hGXz/0y8fm8oGOYEjSmYQsKoz+nGjXPw
         s38Ox1NPpb5rYhz2RsVEGmgMucs0g7gg84EejieRWwCfK7DTB+yeOkYCZ2OER6OFG9ze
         dWE8plSWYKYWGSNYu94Y8SQnFebPzqsWZNh7H5BmQ9l0yihA8AlM3jeTUkp67s7VvV0q
         IEI5S+zV0iEjYY90wG5KzLqD+efDqjUC4g5lss5k6rgnKVd33lwcGuqzXiaNtWFC1/ra
         rFly1Bfe97Li2fpmJ85KklmvFmH2JwdZu7TaaoheilCrj8HeHiSO5o7gDhND07dU8pV+
         aI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=WoxOauBVq0ZnUhdfV+eZctOBrPVihgWTZtcQPSl6xl4=;
        b=8A0EmblRWUvWw1Vxo39xGYfA1ztSP1PwjbKCF+NmrncyOChsOULcJUoTsSBC9c+S4a
         HuRdqEKeawMZFPIdztjWIIZ6SLMW+k85RiOXNDKR1K0C0mG6ceOlq+PPyO/dxBLZlcnx
         r+ENfLqBFjVnAK1Jlr7rrOdwIyRY3vJFjTtnQ5onKO/+lSSiTJDo+lVlgjqyJ0vxq/2y
         iuWh2c6rrFhv7p1E6ICoTFC0cv6z0cOnYh0h1Ov8RC8vnEic1xUrIv72KihHXDH45X3K
         r0C7TEDDMHvAyUtf7YEfhY6gds6uzkOeG/9HjorDiqf/2jEocsNCy7wwA7JGUgMD6cwe
         RSNw==
X-Gm-Message-State: AJIora+dkeksDftHiRuTSZedVINIJJqgsznh9OhN7cYFZ/bm5c4wHu2E
        KFKIegI/Bw9l2DkRyPY0dgLnzQ==
X-Google-Smtp-Source: AGRyM1uH1iCTf2Lg2cRt/sj1bJiLyKyCQfNWwY30drxXF/WYQrB1ga6slH3F4Y3xdnbC9BAI1voVeQ==
X-Received: by 2002:a17:90b:343:b0:1ef:b65d:f4d8 with SMTP id fh3-20020a17090b034300b001efb65df4d8mr27132403pjb.187.1657974812538;
        Sat, 16 Jul 2022 05:33:32 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w75-20020a627b4e000000b005251f4596f0sm5724808pfc.107.2022.07.16.05.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 05:33:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com
Cc:     lkp@intel.com, linux-block@vger.kernel.org
In-Reply-To: <20220716095344.222674-1-ming.lei@redhat.com>
References: <20220716095344.222674-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk_drv: fix build warning with -Wmaybe-uninitialized and one sparse warning
Message-Id: <165797481124.363655.12942466690118689906.b4-ty@kernel.dk>
Date:   Sat, 16 Jul 2022 06:33:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 16 Jul 2022 17:53:44 +0800, Ming Lei wrote:
> After applying -Wmaybe-uninitialized manually, two build warnings are
> triggered:
> 
> drivers/block/ublk_drv.c:940:11: warning: ‘io’ may be used uninitialized [-Wmaybe-uninitialized]
>   940 |         io->flags &= ~UBLK_IO_FLAG_ACTIVE;
> 
> drivers/block/ublk_drv.c: In function ‘ublk_ctrl_uring_cmd’:
> drivers/block/ublk_drv.c:1531:9: warning: ‘ret’ may be used uninitialized [-Wmaybe-uninitialized]
> 
> [...]

Applied, thanks!

[1/1] ublk_drv: fix build warning with -Wmaybe-uninitialized and one sparse warning
      commit: f2450f8a2c1ec3e88d6674f747b913aa5f21fa59

Best regards,
-- 
Jens Axboe


