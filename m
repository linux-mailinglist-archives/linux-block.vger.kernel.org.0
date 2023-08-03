Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773D076EBDE
	for <lists+linux-block@lfdr.de>; Thu,  3 Aug 2023 16:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjHCOJL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Aug 2023 10:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjHCOHi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Aug 2023 10:07:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6971718
        for <linux-block@vger.kernel.org>; Thu,  3 Aug 2023 07:07:04 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fb4146e8ceso9875565e9.0
        for <linux-block@vger.kernel.org>; Thu, 03 Aug 2023 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691071622; x=1691676422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UlaTOf8b5xDgcpnz88BTF1oHWeegdnN7LO6qya3yLSU=;
        b=zPBVmwHRkQl+J3RU6R1o7ia6m+bpMwgPBisDZ2QRme5pKPkPV0BJ+ITYfFDYYXlLeB
         3JvvrsaMaOsn1lXtSpuKvSP16E7gidkkl4+dtNGWlSF8wwS5naJ+5+YZfz+U3PYrwHFY
         YoQWA+86q3IkBB9cfBv/PIujAjmis4+l5sOIiQBmGiFlYEYr2eMHJoxWqzpZZ7MfYwfS
         SE03DqEowHUmZ+CsEH1rrUIGPlOEHeNvu+4NSR5MFOeeY+qVViIRXTS9heTXKTDDeAr6
         kf0xANVbDYOXoi/TXy3qe3NjYX2gp3MCoPFbluh0ddu2VKDUKSeGLUVgGCaRSEU5wn6T
         oCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071622; x=1691676422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlaTOf8b5xDgcpnz88BTF1oHWeegdnN7LO6qya3yLSU=;
        b=OK6sY4QT1gEb7hrc6jjHbmeBfC23+tLfe9T5l08yK/2F27f4ULBwRcAwK7OZofySvd
         X9QWmUUduwZsy2LnFKUZiMV1WChgPbeB3YrsXicEk0fzLsuJhY7EjmG9NivErmAAnL5y
         p5D83dZckIHLaQX/LJ7gR7cFqWjTZPk6wn6YbaIxU8uhX3qbBh7AmWynCEJtSu9wdmcU
         Yozw+DGLlFlSmzt3XO2XObA95WUCfuOWmLStBlxvnkcI08fDF8d0GOGYX8bVQH2Hso0v
         nVfqenKuqS/ryyc8nmou84f0RwK7lm8m/O2+j/iGYMp5Z94lIaJW4WigAi/5qROBKOx0
         wu6Q==
X-Gm-Message-State: ABy/qLZuKcNNrqp8WSewO2+EiLwORDFbY5CtA2aWwGsMOnwmXbg/Zu6Q
        0UvGiYBEJexPAo9k4RVKxYc7hA==
X-Google-Smtp-Source: APBJJlHQdTpk8QeUs0BEWT1UvlrOOOfKBq6pywJj+PepaJ8PqCiwHiv9xiKVOaFD1fb8sfLcExjdug==
X-Received: by 2002:a05:600c:2a54:b0:3f7:f884:7be3 with SMTP id x20-20020a05600c2a5400b003f7f8847be3mr6793965wme.4.1691071622357;
        Thu, 03 Aug 2023 07:07:02 -0700 (PDT)
Received: from localhost ([147.161.155.117])
        by smtp.gmail.com with ESMTPSA id u25-20020a7bcb19000000b003fe1cac37d8sm4472449wmj.11.2023.08.03.07.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:07:01 -0700 (PDT)
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 0/3] ublk: enable zoned storage support
Date:   Thu,  3 Aug 2023 16:06:58 +0200
Message-ID: <20230803140701.18515-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Hindborg <a.hindborg@samsung.com>

Hi All,

This patch set adds zoned storage support to `ublk`. The first two patches do
some house cleaning in preparation for the last patch. The last patch adds
support for report_zones and the following operations:

 - REQ_OP_ZONE_OPEN
 - REQ_OP_ZONE_CLOSE
 - REQ_OP_ZONE_FINISH
 - REQ_OP_ZONE_RESET
 - REQ_OP_ZONE_APPEND

A user space component based on ubdsrv is available for testing [1] with the
"loop" target.

Read/write and zone operations are tested with zenfs [2].

The zone append path is tested with fio -> zonefs -> ublk -> null_blk.

The series is based on v6.5-rc4.

Changes for v10
 - Remove IO flag UBLK_IO_FLAG_ZONE_APPEND
 - Rename ublk_rq_data.nr_sectors to nr_zones
 - Change UAPI by adding field `nr_zones` in union with
   `ublksrv_io_desc.nr_sectors` and use zone count instead of sector count when
   applicable
 - Add documentation suggested Ming to UAPI `UBLK_IO_OP_REPORT_ZONES` and
   `ublksrv_io_cmd`
 - Updated user space component [1]

[1] https://github.com/metaspace/ubdsrv/tree/2966e5f9637b5856d4a4273ae113e31b1c53ff98
[2] https://github.com/westerndigitalcorporation/zenfs
[3] https://git.kernel.dk/linux.git

Andreas Hindborg (3):
  ublk: add helper to check if device supports user copy
  ublk: move check for empty address field on command submission
  ublk: enable zoned storage support

 drivers/block/ublk_drv.c      | 353 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/ublk_cmd.h |  63 +++++-
 2 files changed, 388 insertions(+), 28 deletions(-)


base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
-- 
2.41.0

