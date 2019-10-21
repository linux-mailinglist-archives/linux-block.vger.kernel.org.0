Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4837EDF821
	for <lists+linux-block@lfdr.de>; Tue, 22 Oct 2019 00:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfJUWnH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Oct 2019 18:43:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44420 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJUWnH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 18:43:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id e10so8673937pgd.11
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 15:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cmVGQV7rEM3Ss9yM3Jgywgbc7hsGOE8bzpWlnP58tMU=;
        b=p9BcJH00d+P6KBCA84C6OO/VXhrKudhqc8Y4J5vv58cKtn/PNtGkgVmWGrbT4nG5Lg
         U7S31KxnfwRxHCgHzqmIsqCwh7M7O9TLG3QSWcVBvvg98R9SgK0oUeo/vYeYyh5ukFfd
         eUNDcI27sNl6gFjZ2Ko4m+j+Uy0gClW9002+EV4dgfRMy9Z2KQo/M9mZlCyaS6fMEdQ+
         eH0sAMmzMfVz1cdl3JZNtFScJR9zaJNiF5ERflOQ/VLL+DZiXiQmvEijQbWMzKauNbYi
         OS1NHNqaFfa4RCiAm57pZbYEysfBosDNm4uLy6cu/lXkbOL3iFQA3OoCUJWGD+7deoJA
         cpsA==
X-Gm-Message-State: APjAAAWKciBsU0+mhW7G2MRUS0czOdWN5T1FrAo0lVHgEEdcYAYBsNxp
        MHo3csM+XVXL+Pgv9gDttJJfkez4/80=
X-Google-Smtp-Source: APXvYqxJKPovX/JvNHqEPQhZcNwiBWv/VuaTeoHnL4v0pULY1cZrBnWFD80CyMMWv4uzmlMEONG2WA==
X-Received: by 2002:a17:90a:8992:: with SMTP id v18mr576523pjn.65.1571697786405;
        Mon, 21 Oct 2019 15:43:06 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u9sm15944763pjb.4.2019.10.21.15.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 15:43:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/4] Reduce the amount of memory required for request queues
Date:   Mon, 21 Oct 2019 15:42:55 -0700
Message-Id: <20191021224259.209542-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This patch series reduces the amount of memory required for request queues
and also includes two patches that are the result of reviewing code related
to the modified code. Please consider these patches for kernel version v5.5.

Thanks,

Bart.

Bart Van Assche (4):
  block: Remove the synchronize_rcu() call from
    __blk_mq_update_nr_hw_queues()
  block: Fix a race between blk_poll() and blk_mq_update_nr_hw_queues()
  block: Reduce the amount of memory required per request queue
  block: Reduce the amount of memory used for tag sets

 block/blk-mq.c | 113 +++++++++++++++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 41 deletions(-)

-- 
2.23.0.866.gb869b98d4c-goog

