Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B54F6BA0
	for <lists+linux-block@lfdr.de>; Wed,  6 Apr 2022 22:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiDFUvq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Apr 2022 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiDFUve (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 16:51:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A99F3CBF24
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 12:07:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r13so6260925ejd.5
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nyp7OX1W1Fn5BbwnjKbR+lJdVHHkk18+5VS/ZBLl7Y=;
        b=Dx31FWyqp8a4yw4JDlmDuzyHowcDdFIxuWvRdZtAibJU9DCTAzyrS0NapTDIdql+yn
         UmAUPO1EiOdY7/KzHIjLA5UCc97TJ/f3Q0UxGGwLMHwTiKh2xTl6ijiU670s8fBUx84P
         eg0LFW/165hj6f3YbdLHIEljvGng9g+ZmebiUjWmf6zqJDFv3M+dcBZyl7WKsAwfcN35
         vpQhRH/XwlQ66uhfu2s+2ihvNiiPbTC1oEMih7cGIKCEV+o4k+pNFFMiQRANw4FAgD74
         Fu/zUB1FQ6a1yKp9Wb2Z1wIly37MwkjDItzBGdiHi/O2VqxEdsb9FdYLMKTaBlBA5AfK
         UtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nyp7OX1W1Fn5BbwnjKbR+lJdVHHkk18+5VS/ZBLl7Y=;
        b=yyA+VHwdRI0gGO7t03bZrSaNDGq9bfNRdgJ/iaqcA95lPGCb1/vs5+KTD4rgDBFqO3
         Y4T8N/qtkLt59ResimOJHOlU+saa0x+NQNHfFChsgQ9WpnUb/8BMx043xIgXT0Awisi+
         gV3kyhZlr6/hRkXUMnris5G8WkXn9nbGk4JmxyeZhq96OPuk1vaGCWbf5+ct2ANANtco
         TghD0GQ38EeZCWU+huv30/4yU4VYNTOseufmnZ5xLckU/ybvCu8aLvV+eB5lnvZXmfSb
         yH3RRmk7pWsepkELe167FsSdd3DfphlXoRMoLKVavxRZoPBw/RpR0goPwR61MxcpZLyu
         FmOg==
X-Gm-Message-State: AOAM531QLQ3wGYi+XvN5AHMmpRT8ZSGuQeHogOtSTOHEt+P50W8NQ7jH
        2xut2zehopqBl3VyQLbZfJZWdg==
X-Google-Smtp-Source: ABdhPJysIJlKR0YpwnjF/Bo3FpPKzC8wDAcVGAN6w8AohntTEfCK5iYxD9mV6tlmoAskOH4ROIB49g==
X-Received: by 2002:a17:907:2d90:b0:6db:729e:7f25 with SMTP id gt16-20020a1709072d9000b006db729e7f25mr9911182ejc.203.1649272049814;
        Wed, 06 Apr 2022 12:07:29 -0700 (PDT)
Received: from localhost (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id z6-20020a056402274600b004194fc1b7casm8249210edd.48.2022.04.06.12.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 12:07:29 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 0/7] DRBD updates for 5.19
Date:   Wed,  6 Apr 2022 21:07:08 +0200
Message-Id: <20220406190715.1938174-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mostly cosmetic changes, bound for 5.19.

Arnd Bergmann (2):
  drbd: fix duplicate array initializer
  drbd: address enum mismatch warnings

Cai Huoqing (2):
  drbd: Make use of PFN_UP helper macro
  drbd: Replace "unsigned" with "unsigned int"

Haowen Bai (1):
  drbd: Return true/false (not 1/0) from bool functions

Jiapeng Chong (1):
  block: drbd: drbd_receiver: Remove redundant assignment to err

Uladzislau Rezki (Sony) (1):
  drdb: Switch to kvfree_rcu() API

 drivers/block/drbd/drbd_bitmap.c   |  2 +-
 drivers/block/drbd/drbd_main.c     | 11 +++++-----
 drivers/block/drbd/drbd_nl.c       | 33 +++++++++++++++---------------
 drivers/block/drbd/drbd_receiver.c | 15 ++++++--------
 drivers/block/drbd/drbd_req.c      |  2 +-
 drivers/block/drbd/drbd_state.c    |  3 +--
 drivers/block/drbd/drbd_worker.c   |  2 +-
 7 files changed, 32 insertions(+), 36 deletions(-)

-- 
2.35.1

