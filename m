Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B7221E1E6
	for <lists+linux-block@lfdr.de>; Mon, 13 Jul 2020 23:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgGMVNy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 13 Jul 2020 17:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgGMVNy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jul 2020 17:13:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7D0C061755
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:13:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n26so19086823ejx.0
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2020 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QevkwhKk57WV1l1+r540FqcpexoQRcqz61McRvSggt4=;
        b=HL9PJr1hijfRzkMGxZjhtawKxTqnNuBlXhzbBZWRtMDzboLD4MEMDX0ZcOTSGnHmfo
         a2aZ+3z4qVycPJWibIYyRQVyoNg/2/uBn8BmXJYHpcrVVblcKcvTannwi0HPZqeADaHK
         t1CiVWdvMCVOiACbK4J4ezMzx87TPx4zO8MX1hguADLE3G1++w06tCfw1nERbELFEIH1
         0eIBNhsj3TRMt2iMpAEvy01dvM0prybCD/PbZlBXfzLrVbyxM00rBeseIJwqRsx21UBo
         LXsXI5dlj0IhHkYyRZccMr4H48M2A8Tl62IfSHuW8xICIwsy+ccvHh0etppY/RBQIklW
         uusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QevkwhKk57WV1l1+r540FqcpexoQRcqz61McRvSggt4=;
        b=SFKLsvCQUU5op54w2VNNTv072KDYfmJfqp3D+LXE2eQMf5F4/sty7t1j2xfqO9nJER
         Xw8DdNxlkQMV/8Ptw6PnF00Ampw1JLarxVigJtP+PgQJiTdVPZIBgQYhwI56SLh1pmbP
         71NkBOvqO+RBlx0bBoflZH94Clhiw1i2P9Fw6IZo4AfXY8Hw5dVo85XRSfbHMwccZGKB
         jFUFvwdGZDTeWsPTtiIxx042Z8iqkoIHVqPc2spq6ZbnzxVKTYJoeMTzfMElcLPrZ0gk
         KUcEp2Hcx6btYRrxWUnYz54xWrtRg1r6Zfo0o52uo64UX9u95yoqS0kmtv0uLVHyuc/e
         8CvA==
X-Gm-Message-State: AOAM530z9esvFS5eYjd1snW0LW1jaE3ftr2uhzPnFK2/aAmdG2qO5K2C
        GLOODPjJSGNUxzOB4f0+EYhxS5u3j0560Q==
X-Google-Smtp-Source: ABdhPJwnwAjeaZdwMeczU+/U5bBuVqcKNYIPQ+EVaAdXB+wHjhzqFKEjnWcuausaePX/KXRmlhd6dQ==
X-Received: by 2002:a17:906:fb99:: with SMTP id lr25mr1567041ejb.49.1594674832884;
        Mon, 13 Jul 2020 14:13:52 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ab:24b8:5892:2244])
        by smtp.gmail.com with ESMTPSA id d5sm12715770eds.40.2020.07.13.14.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:13:52 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH RFC V2 0/4] block: add two statistic tables
Date:   Mon, 13 Jul 2020 23:13:17 +0200
Message-Id: <20200713211321.21123-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Now, a new io_extra_stats node is introduced which works with the config
option. with the double insurance, I think no one will suffer from the
additional overhead unless people really need the statistic tables.

And I will delete the kernel option if it doesn't make sense to have both
kernel option and sysfs node. Review and comment are welcomed.

Thanks,
Guoqing

RFC V1 -> RFC V2:
* don't call ktime_get_ns and drop unnecessary patches.
* add io_extra_stats to avoid potential overhead.

RFC V1 at https://marc.info/?l=linux-block&m=159419516730386&w=2

Guoqing Jiang (4):
  block: add a statistic table for io latency
  block: add a statistic table for io sector
  block: add io_extra_stats node
  block: call blk_additional_{latency,sector} only when io_extra_stats
    is true

 Documentation/block/queue-sysfs.rst |  6 ++++
 block/Kconfig                       |  9 +++++
 block/blk-core.c                    | 54 +++++++++++++++++++++++++++++
 block/blk-sysfs.c                   |  8 +++++
 block/genhd.c                       | 47 +++++++++++++++++++++++++
 include/linux/blkdev.h              |  2 ++
 include/linux/part_stat.h           |  8 +++++
 7 files changed, 134 insertions(+)

-- 
2.17.1

