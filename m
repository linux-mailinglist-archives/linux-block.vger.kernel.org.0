Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3E518A2A
	for <lists+linux-block@lfdr.de>; Tue,  3 May 2022 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239666AbiECQmp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 May 2022 12:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiECQmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 May 2022 12:42:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CEB27B23
        for <linux-block@vger.kernel.org>; Tue,  3 May 2022 09:39:10 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so2739779pjb.5
        for <linux-block@vger.kernel.org>; Tue, 03 May 2022 09:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=s39mE0kiqCYA7ZYSMO88r6nrLoSeKkE/K4dp3BvGwGs=;
        b=pGDpCf7sl1d7573gjTTpqwkm3SiLycRrYLR/Cpm0xghxjpDf3AYMtstNaQt6JhXwCj
         hQ35tsdAS9xUuNcQ6bjTAIO4jrWGURYFn6WniUxLx9leI8Us/ZQXxmUsx5sXqR+3SMFs
         NPtnD8cP+Vrfqw+JIy3zA370Pyvn+VSXvM3gc7wLfoXTetostms9mgjy7Euc3hVJAm4j
         a9n45bGAUG8eOYOtc2pRDLYRKouGSmmTKZVBKYAG6yGnvzNVe7ulVhqBTMV0jNCtQJ1b
         eh8fwFdSJCS0763Fc+Es4Igf8he/A1M8/7QNTfbxn1mM2JdiBuUfp0c3rzGlnMqDUeCY
         VcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=s39mE0kiqCYA7ZYSMO88r6nrLoSeKkE/K4dp3BvGwGs=;
        b=7mBuiW/OnMfMt+x12PvtF2wTdhGdL5BMabf5kPHH7yleImEC+uxMQj2dMBHfma3m0q
         O5JZv++zTRYxcMcIsOjmoUO5ezHuIFUtqa4cakez6E5zefgGio3cLkCWahEhg0HQtWK6
         EN7s9gNbyKek+WpdrzG+a8ZaUAut6OB2ZwiIWvWOzBmxp2izi2tqQ9qstv0Qzanu9pRk
         cwweeXFK50t1uMUZtvxIFjh0kn6OFAuWV3z3EdPOL/GMwE/NsClTCtnkbMfTpytc/0ES
         5GZMAceH6xKHHDYAJi1L0e3Il1OzGblx1mwXu150ECaQHIxavpA1H8MNLw6PUkxanWHr
         AWyg==
X-Gm-Message-State: AOAM530u4TW45oWXH+Dr59RlNr7ikAuJGjV5fipJdG2RBLwGkzUJftQr
        oMdbcy3eMWgtKpNbCAvm4S3nzA==
X-Google-Smtp-Source: ABdhPJynf+YKk08yAhS/p4BXstboFDeyZsD4FTBMM24xr+KLv+BRsvUdLzF1UAPk9hKAVzsu2Q8whQ==
X-Received: by 2002:a17:90a:9901:b0:1cb:aa19:5eee with SMTP id b1-20020a17090a990100b001cbaa195eeemr5645991pjp.158.1651595950265;
        Tue, 03 May 2022 09:39:10 -0700 (PDT)
Received: from [127.0.1.1] ([8.34.116.185])
        by smtp.gmail.com with ESMTPSA id m9-20020a17090a858900b001d9b7fa9562sm1559200pjn.28.2022.05.03.09.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 09:39:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     mst@redhat.com, linux-s390@vger.kernel.org, sth@linux.ibm.com,
        martin.petersen@oracle.com, dm-devel@redhat.com,
        hoeppner@linux.ibm.com, linux-nvme@lists.infradead.org,
        richard@nod.at, josef@toxicpanda.com,
        virtualization@lists.linux-foundation.org, snitzer@kernel.org,
        roger.pau@citrix.com, linux-um@lists.infradead.org,
        linux-block@vger.kernel.org, song@kernel.org, nbd@other.debian.org,
        linux-raid@vger.kernel.org, johannes@sipsolutions.net,
        haris.iqbal@ionos.com, xen-devel@lists.xenproject.org,
        jasowang@redhat.com, jinpu.wang@ionos.com
In-Reply-To: <20220418045314.360785-1-hch@lst.de>
References: <20220418045314.360785-1-hch@lst.de>
Subject: Re: fix and cleanup discard_alignment handling
Message-Id: <165159594780.2557.1712299203175316151.b4-ty@kernel.dk>
Date:   Tue, 03 May 2022 10:39:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 18 Apr 2022 06:53:03 +0200, Christoph Hellwig wrote:
> the somewhat confusing name of the discard_alignment queue limit, that
> really is an offset for the discard granularity mislead a lot of driver
> authors to set it to an incorrect value.  This series tries to fix up
> all these cases.
> 
> Diffstat:
>  arch/um/drivers/ubd_kern.c         |    1 -
>  drivers/block/loop.c               |    1 -
>  drivers/block/nbd.c                |    3 ---
>  drivers/block/null_blk/main.c      |    1 -
>  drivers/block/rnbd/rnbd-srv-dev.h  |    2 +-
>  drivers/block/virtio_blk.c         |    7 ++++---
>  drivers/block/xen-blkback/xenbus.c |    4 ++--
>  drivers/md/dm-zoned-target.c       |    2 +-
>  drivers/md/raid5.c                 |    1 -
>  drivers/nvme/host/core.c           |    1 -
>  drivers/s390/block/dasd_fba.c      |    1 -
>  11 files changed, 8 insertions(+), 16 deletions(-)
> 
> [...]

Applied, thanks!

[01/11] ubd: don't set the discard_alignment queue limit
        commit: 07c6e92a8478770a7302f7dde72f03a5465901bd
[02/11] nbd: don't set the discard_alignment queue limit
        commit: 4a04d517c56e0616c6f69afc226ee2691e543712
[03/11] null_blk: don't set the discard_alignment queue limit
        commit: fb749a87f4536d2fa86ea135ae4eff1072903438
[04/11] virtio_blk: fix the discard_granularity and discard_alignment queue limits
        commit: 62952cc5bccd89b76d710de1d0b43244af0f2903
[05/11] dm-zoned: don't set the discard_alignment queue limit
        commit: 44d583702f4429763c558624fac763650a1f05bf
[06/11] raid5: don't set the discard_alignment queue limit
        commit: 3d50d368c92ade2f98a3d0d28b842a57c35284e9
[07/11] dasd: don't set the discard_alignment queue limit
        commit: c3f765299632727fa5ea5a0acf118665227a4f1a
[08/11] loop: remove a spurious clear of discard_alignment
        commit: 4418bfd8fb9602d9cd8747c3ad52fdbaa02e2ffd
[09/11] nvme: remove a spurious clear of discard_alignment
        commit: 4e7f0ece41e1be8f876f320a0972a715daec0a50
[10/11] rnbd-srv: use bdev_discard_alignment
        commit: 18292faa89d2bff3bdd33ab9c065f45fb6710e47
[11/11] xen-blkback: use bdev_discard_alignment
        commit: c899b23533866910c90ef4386b501af50270d320

Best regards,
-- 
Jens Axboe


