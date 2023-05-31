Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3347186B8
	for <lists+linux-block@lfdr.de>; Wed, 31 May 2023 17:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjEaPuZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 31 May 2023 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjEaPuX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 May 2023 11:50:23 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3565C134
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 08:50:20 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33110a36153so1282635ab.0
        for <linux-block@vger.kernel.org>; Wed, 31 May 2023 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1685548219; x=1688140219;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kr7AYf3i1eBygjzH5q6AjnbmzDMGTDydvzH6ggOcr8w=;
        b=4nzwQWXlPFrQgBR+Umz4rzJtXWnzFgbzUWVUfB9QgaeAyjDpdPycDHBOlzoGjkiyyF
         WISZEhApoKJHX22j+q6FimQPSzuRzF1ACB/gjMYQF73jOOv9yb/CaL6c/cBr9iKLVL6a
         oPEyWRUWLo3t6tEOB+MZMpIXQ/YO7qF9X+uZoWStyxdO1JqHmDHKM6Ywva729pw00VjN
         K/4G6lUTixU41ZXWz6pHYoaoZ4B8pTBJ+MsxdVR7ZdtzhIvDbDXos/3WexK9ADx0jMsK
         ImDcTknGUE04r0reHu1U5tXYxAs8kQ2e/F36l0E25F1pgb64Kd8DLNjSS74EObEQif36
         HXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685548219; x=1688140219;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kr7AYf3i1eBygjzH5q6AjnbmzDMGTDydvzH6ggOcr8w=;
        b=KtWLS0Ylf+azP3R2/Zi1EjVHz08ABGcdVNO5OBKGDgtG59i200RFUSlNC2MQn9TwDJ
         1CwD5FgwFNPL3a5Pja6IvOQJSEkDwRnYBo18IlZKAkQ6jOweAh5xnjVRLChYfWfzh7zN
         QyHlxsdTApNK8SiGRa9R7/fH+GBpdX/p7/iM24XZuJZdQzzh3VRAUHCameuyhKMY2Fj8
         YTx01wNE4qg5RnwcF86QvUg6yl7MFpqU7jL7rmxHgVBjzlO9CoUD1FtHbwMZc45LPoap
         6/CN5xm+YWZ23lOSEBhoB2oAtHLKMQiDm0LvU67H7oEowT/b3w3qWtIMr06Pbrj4Ztgb
         5hSA==
X-Gm-Message-State: AC+VfDwdw0M4DEYPYHomq3L1cP/S5ly17YghArAoR8dLKiJjvy1qTBTp
        8EWVZQAAi8OM8Kv2h5UwdcuS2w==
X-Google-Smtp-Source: ACHHUZ4Vc5K9goUssaOAlBejpFmpFM1M2MosneBhWp7jmoz34Mcc3cGA6Lj397yP4Jgger0rhBRBog==
X-Received: by 2002:a05:6e02:1061:b0:32b:51df:26a0 with SMTP id q1-20020a056e02106100b0032b51df26a0mr1411548ilj.2.1685548219545;
        Wed, 31 May 2023 08:50:19 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id a4-20020a927f04000000b0033355fa5440sm3211579ild.37.2023.05.31.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 08:50:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, gouha7@uniontech.com
In-Reply-To: <cover.1685532726.git.johannes.thumshirn@wdc.com>
References: <cover.1685532726.git.johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v7 00/20] bio: check return values of bio_add_page
Message-Id: <168554821814.183617.716542495633198655.b4-ty@kernel.dk>
Date:   Wed, 31 May 2023 09:50:18 -0600
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


On Wed, 31 May 2023 04:50:23 -0700, Johannes Thumshirn wrote:
> We have two functions for adding a page to a bio, __bio_add_page() which is
> used to add a single page to a freshly created bio and bio_add_page() which is
> used to add a page to an existing bio.
> 
> While __bio_add_page() is expected to succeed, bio_add_page() can fail.
> 
> This series converts the callers of bio_add_page() which can easily use
> __bio_add_page() to using it and checks the return of bio_add_page() for
> callers that don't work on a freshly created bio.
> 
> [...]

Applied, thanks!

[01/20] swap: use __bio_add_page to add page to bio
        commit: cb58bf91b138c1a8b18cca9503308789e26e3522
[02/20] drbd: use __bio_add_page to add page to bio
        commit: 8f11f79f193c935da617375ba5ea4e768a73a094
[03/20] dm: dm-zoned: use __bio_add_page for adding single metadata page
        commit: fc8ac3e539561aff1c0a255d701d9412d425373c
[04/20] fs: buffer: use __bio_add_page to add single page to bio
        commit: 741af75d4027b1229fc6e62f4e3c4378dfe04897
[05/20] md: use __bio_add_page to add single page
        commit: 3c383235c51dcd6198d37ac3ac06e2acad79f981
[06/20] md: raid5-log: use __bio_add_page to add single page
        commit: b0a2f17cad9d3fa564d67c543f5d19343401fefd
[07/20] md: raid5: use __bio_add_page to add single page to new bio
        commit: 6eea4ff8528d6a5b9f0eeb47992e48a8f44b5b8f
[08/20] jfs: logmgr: use __bio_add_page to add single page to bio
        commit: 2896db174ced7a800863223f9e74543b98271ba0
[09/20] gfs2: use __bio_add_page for adding single page to bio
        commit: effa7ddeeba782406c81b572791a142fbdaf6b05
[10/20] zonefs: use __bio_add_page for adding single page to bio
        commit: 0fa5b08cf6e17b0a64ffcc5894d8efe186691ab8
[11/20] zram: use __bio_add_page for adding single page to bio
        commit: 34848c910b911838e1e83e1370cb988b578c8860
[12/20] floppy: use __bio_add_page for adding single page to bio
        commit: 5225229b8fdfb3e65520c43547ecf9a737161c3f
[13/20] md: check for failure when adding pages in alloc_behind_master_bio
        commit: 6473bc325644b9c8473e6c92bfb520a68dce1e12
[14/20] md: raid1: use __bio_add_page for adding single page to bio
        commit: 2f9848178cfa4ac68a5b46e63e5163a09b8bd80f
[15/20] md: raid1: check if adding pages to resync bio fails
        commit: 33332be32fe91ff54ff326b3a1608973544e835a
[16/20] dm-crypt: use __bio_add_page to add single page to clone bio
        commit: 9be63ecfdd63f957b9ed25eaf85666d22a02d7a5
[17/20] block: mark bio_add_page as __must_check
        commit: 5b3e39c1cc8e1cf31a398830dd665eb15546b4f7
[18/20] block: add bio_add_folio_nofail
        commit: 42205551d1d43b1b42942fb7ef023cf954136cea
[19/20] fs: iomap: use bio_add_folio_nofail where possible
        commit: f31c58ab3ddaf64503d7988197602d7443d5be37
[20/20] block: mark bio_add_folio as __must_check
        commit: 9320744e4dbe10df6059b2b6531946c200a0ba3b

Best regards,
-- 
Jens Axboe



