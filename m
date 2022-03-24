Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BFD4E64A7
	for <lists+linux-block@lfdr.de>; Thu, 24 Mar 2022 15:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbiCXOGr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Mar 2022 10:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiCXOGq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 10:06:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005326C973
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 07:05:14 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q19so3921080pgm.6
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgQfab3RSsXK82N0kPcYr+G+j0ALAz0Eo/pV7r6C6fk=;
        b=bSoCwr1EQd58sQACThcHC9/uNRul24Jv5QHVjoUFaFWIQSZB9qXCFA59c971D6BWBZ
         aG8fSM2jGKSN/sxDakuS1UWz29IARsQynF193xkRaGZ2mHWfiNAfAqeSb28l/OhNyFN5
         2yXKIymCkN8i8sC8DVwkOsAnD+N7mcPibCvkmYQFrMdqYB6t/n3Ew5Ue6P2MQckiwrmb
         WeHsOxDWLr4eZ19vN9H1GJrKG1ar2qckZZ1K8NUdXCeYQDkzZPdcQ9fzDw0v2/ZgYV7/
         m6UYTz0po0CdUbTDJRjUKoL/Fndq7n+fWD/3hB+eJkUi/eZ+pSApBpQnfjBIQ4KT0cPE
         7xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgQfab3RSsXK82N0kPcYr+G+j0ALAz0Eo/pV7r6C6fk=;
        b=uscNW/JrY1XCYDx+PBdILs9BM1C1KrCQzg+kp3d6AddCFQyqoD04WP5GpewtrTPGiM
         j+jVubMALyo3tfEiXN9bcKySaTco9RUWbIfzlee6WhXEwcbFz/yKI5V6LyDNZy7Z2ZYA
         UdFt9NVwp5GBxk1lD9hIgQgG3sYW+38YzqSpN2CvuSPJW02OUAxchV031IPIDgfa1roW
         vHiCI5fARcfvbaPkzVnzq5ZodbX7dQL+xTb7lRXvvesSib7kOmyUjXR4WKeJKj9GmCtl
         zdbz7WkfHsurSH925BgCfFXkbO2JFRuaAdkCeJh8pcOkPVxGyf3HJSqUjmaKBVPXL2oM
         V//w==
X-Gm-Message-State: AOAM5320NPkuYI2Db8tbXBDkuMFl85lqzLZ+L3KxsT+HK0KoUp5OgHuV
        AOFlujEovPmN1w87Rc9NMLg=
X-Google-Smtp-Source: ABdhPJxtd3J4O8edTMEpdJ2AnMowFTuWlfiIkMN+YGRDaldOIgmcUXD80KHHQ/Jqh3nxDJlNQA+O8w==
X-Received: by 2002:a62:f205:0:b0:4fa:8461:421f with SMTP id m5-20020a62f205000000b004fa8461421fmr5559547pfh.4.1648130714434;
        Thu, 24 Mar 2022 07:05:14 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id u12-20020a17090a890c00b001b8efcf8e48sm9441845pjn.14.2022.03.24.07.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:05:13 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v3 0/2] virtio-blk: support polling I/O and mq_ops->queue_rqs()
Date:   Thu, 24 Mar 2022 23:04:48 +0900
Message-Id: <20220324140450.33148-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch serise adds support for polling I/O and mq_ops->queue_rqs()
to virtio-blk driver.

Changes

v2 -> v3
        - Fix warning by kernel test robot
          
            static int virtblk_poll()
                ...
                if (!blk_mq_add_to_batch(req, iob, virtblk_result(vbr),
                                                   -> vbr->status,

v1 -> v2
        - To receive the number of poll queues from user,
          use module parameter instead of QEMU uapi change.

        - Add the comment about virtblk_map_queues().

        - Add support for mq_ops->queue_rqs() to implement submit side
          batch.

Suwan Kim (2):
  virtio-blk: support polling I/O
  virtio-blk: support mq_ops->queue_rqs()

 drivers/block/virtio_blk.c | 194 ++++++++++++++++++++++++++++++++++---
 1 file changed, 181 insertions(+), 13 deletions(-)

-- 
2.26.3

