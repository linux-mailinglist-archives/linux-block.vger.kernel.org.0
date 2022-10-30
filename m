Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9534F6129CE
	for <lists+linux-block@lfdr.de>; Sun, 30 Oct 2022 11:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJ3KDj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 30 Oct 2022 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiJ3KDi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 06:03:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862A6103B
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:03:35 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a5so13677725edb.11
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6oLL2KhAmaTN+LmZKCQYKzyB0xny0EVS0BMlbWPigno=;
        b=Z8aCgFvndZHScKg0yg7p+vmvlZojjuQ3gTjx57OTRDzCrpIS1ECKqqDRmP/ktDzXO9
         AdBnNRgN7iix63GTuS+IeuZdn6q6ja/cgaf8UmYRAKSPQQ9ULWUC8YK/8lgToqHuNNjR
         9uHJRi3g9Ri8e/l38iHi7+49fzTU+M4q84DahlsMwOtl6yDxiS6Nnev71RWSxukyDTyP
         dDNXah/lN6+wfvBOu+viZpBRv3cPqy/ZaYoDf0xxi+ktTE4e4mjnjwxYPcIAVeEKReNC
         1J1lxVNIZBBAvaezlKFxzGocKVsFZujrzNZ07vT7JhwtQHKXWittADL+VNJ0mRvxPGTs
         5D8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6oLL2KhAmaTN+LmZKCQYKzyB0xny0EVS0BMlbWPigno=;
        b=TFsrMZyt52EvHUJG1zb5HVB6XcBGoUCVzm4vA7ZpxO9M2cDqMpnnbUo+JP6G1L1tcT
         AsQH0a98MP0gX68NmAS6iz0KwofEI6eirJJ4vTC7I/BnfPjtHKnu2y0ZXNfg8HXKhRv4
         10OG/lXEGCUIkaX/PHc5ke53mqrRA1+57HlhsxjSltRaATw31+5GExjVVAIYH5ghmlUZ
         C9TfM7LMc4CNTkv6YkiEsxLYdStZRQUErm3RVNuPFVXOj6iEUXeUXhoCOs3zyey4v0Rx
         6rsHUN4YyFnZU/qe8ZJgslrQZ99Y9UFYDFYdEXF+tvt7qiDYs56kKjB3i+hWL+jS52gy
         anww==
X-Gm-Message-State: ACrzQf00lRp+Ii2ihPHU5VjvN/oJt65iIHMim2grQX+jpUVim2751TZ7
        c3219m4pJlSgGcDGL4wgHRqc/jQ/zkSnvg==
X-Google-Smtp-Source: AMsMyM6hHDGnM2xR+hazedwwmZ54KroriqfV2ULbtD4sHUqws8u0f8dVVe8L7hhsGoCJXqrTmmgBEQ==
X-Received: by 2002:aa7:de0a:0:b0:462:d2a0:93a with SMTP id h10-20020aa7de0a000000b00462d2a0093amr7745022edv.275.1667124213832;
        Sun, 30 Oct 2022 03:03:33 -0700 (PDT)
Received: from MBP-di-Paolo.station (net-2-35-55-161.cust.vodafonedsl.it. [2.35.55.161])
        by smtp.gmail.com with ESMTPSA id d27-20020a170906305b00b0073d71792c8dsm1666088ejd.180.2022.10.30.03.03.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 03:03:33 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH V5 0/8] block, bfq: extend bfq to support multi-actuator drives
Date:   Sun, 30 Oct 2022 11:02:52 +0100
Message-Id: <20221030100300.3085-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
this V5 differs from V4 in that it addresses the issues reported in
[2] and [3].

Here is the whole description of this patch series again.  This
extension addresses the following issue. Single-LUN multi-actuator
SCSI drives, as well as all multi-actuator SATA drives appear as a
single device to the I/O subsystem [1].  Yet they address commands to
different actuators internally, as a function of Logical Block
Addressing (LBAs). A given sector is reachable by only one of the
actuators. For example, Seagate’s Serial Advanced Technology
Attachment (SATA) version contains two actuators and maps the lower
half of the SATA LBA space to the lower actuator and the upper half to
the upper actuator.

Evidently, to fully utilize actuators, no actuator must be left idle
or underutilized while there is pending I/O for it. To reach this
goal, the block layer must somehow control the load of each actuator
individually. This series enriches BFQ with such a per-actuator
control, as a first step. Then it also adds a simple mechanism for
guaranteeing that actuators with pending I/O are never left idle.

See [1] for a more detailed overview of the problem and of the
solutions implemented in this patch series. There you will also find
some preliminary performance results.

Thanks,
Paolo

[1] https://www.linaro.org/blog/budget-fair-queueing-bfq-linux-io-scheduler-optimizations-for-multi-actuator-sata-hard-drives/
[2] https://lore.kernel.org/lkml/202210212014.ynAHDVJU-lkp@intel.com/t/#mda5d00db9eb78ea698e7d0269b78ac57d134181e
[3] https://lore.kernel.org/lkml/202210212014.ynAHDVJU-lkp@intel.com/t/#m31c1d2403d0ae584b8a99733b29233d350cd9628

Davide Zini (3):
  block, bfq: split also async bfq_queues on a per-actuator basis
  block, bfq: inject I/O to underutilized actuators
  block, bfq: balance I/O injection among underutilized actuators

Federico Gavioli (1):
  block, bfq: retrieve independent access ranges from request queue

Paolo Valente (4):
  block, bfq: split sync bfq_queues on a per-actuator basis
  block, bfq: forbid stable merging of queues associated with different
    actuators
  block, bfq: move io_cq-persistent bfqq data into a dedicated struct
  block, bfq: turn bfqq_data into an array in bfq_io_cq

 block/bfq-cgroup.c  |  97 ++++----
 block/bfq-iosched.c | 533 ++++++++++++++++++++++++++++++--------------
 block/bfq-iosched.h | 141 +++++++++---
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 539 insertions(+), 234 deletions(-)

--
2.20.1
