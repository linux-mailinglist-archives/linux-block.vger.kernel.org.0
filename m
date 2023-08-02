Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6AC76D13A
	for <lists+linux-block@lfdr.de>; Wed,  2 Aug 2023 17:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjHBPNv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Aug 2023 11:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbjHBPNs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 11:13:48 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0582D49
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 08:13:36 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-790b6761117so32543939f.0
        for <linux-block@vger.kernel.org>; Wed, 02 Aug 2023 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690989215; x=1691594015;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFN0yTkYJmRYBxe8C0crI4IHgD1XQCao320E85C1eJo=;
        b=kp7n9nNtSk8/5HElDyrHrxdGYt7rv/xOLxBpQU+qG5wUj+aPhHFt7hOsgBNU+OETht
         KWYQgN+RSSEkCSHwBiuIn2wqCn91pIcH/6WpiiodnA80qHVCbrbi7a5F7VrS1AWocpGX
         lkpINsr9WOQxcFPAY8112JHDHuJNcmJ6kzBmZcak+HGIKh1mUfZlmlGg/fFYiljja8Iw
         hOStezDZIgh7VUM+4wefm3ZdGRsulRhaUdKProubNLnmpS5r9xd7/3JvspGQR7Qmuo3D
         jGBr6kX71aa/Ip9kVb1+ByoY7pLHM2YwhbYEQr92yRmJOnBOGLIpP3nmoti+KebJ98IT
         YNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690989215; x=1691594015;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFN0yTkYJmRYBxe8C0crI4IHgD1XQCao320E85C1eJo=;
        b=RmUMGu6Q7YME7QnWKvY4ykdBZYQheC1TPCd/TvrmS2VZTQmc3EQbMPpVGuxyoXA7Nw
         sEqrc1cam7Nl0EPCqpVbb65o7K8iP52nkYJ5tRa5FYOEvBBgXk96I58lYEr7kPkjoouX
         p5XNZjxX1kNDtNjG6vL5WBla0sfggYOYkO/82VS0Mmz/ikYaVDWucJivY7sZm0ezTXR/
         UBK/dsmEWHDSXEEbtLmj97oySavPfSxOE1KHkY9OiIqlT0NQZrpgz/mIlK63gGv//aKj
         1UPV+xr7OSWjZQAkGT7G+NGu9QP8b84YnbSt1ZoGMA3EbXEEzX3tc48ao6fhD6bxDklX
         v0fA==
X-Gm-Message-State: ABy/qLZP5PXYlcaXrruwVivLeg/LIGW+t2YUJFWgyBl+3RYOa1snAycw
        XnpnPIr7FmmP3tElwg/ill2zsQ==
X-Google-Smtp-Source: APBJJlGV0GWnRqN4nUuY2j+yBlsWFiPPK/hRERx9kc8EMoqN+d2kaqg0kL1v4ktlNGSiEvEAkXeswA==
X-Received: by 2002:a05:6e02:4c4:b0:345:a3d0:f0d4 with SMTP id f4-20020a056e0204c400b00345a3d0f0d4mr12930279ils.3.1690989215175;
        Wed, 02 Aug 2023 08:13:35 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y8-20020a02a388000000b0042b46224650sm4293136jak.91.2023.08.02.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:13:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christian Brauner <brauner@kernel.org>
In-Reply-To: <20230801172201.1923299-2-hch@lst.de>
References: <20230801172201.1923299-1-hch@lst.de>
 <20230801172201.1923299-2-hch@lst.de>
Subject: Re: [PATCH 1/6] fs: remove emergency_thaw_bdev
Message-Id: <169098921438.7183.18231196765480619399.b4-ty@kernel.dk>
Date:   Wed, 02 Aug 2023 09:13:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 01 Aug 2023 19:21:56 +0200, Christoph Hellwig wrote:
> Fold emergency_thaw_bdev into it's only caller, to prepare for buffer.c
> to be built only when buffer_head support is enabled.
> 
> 

Applied, thanks!

[1/6] fs: remove emergency_thaw_bdev
      commit: 4a8b719f95c0dcd15fb7a04b806ad8139fa7c850
[2/6] fs: rename and move block_page_mkwrite_return
      commit: 2ba39cc46bfe463cb9673bf62a04c4c21942f1f2
[3/6] block: open code __generic_file_write_iter for blkdev writes
      commit: 727cfe976758b79f8d2f8051c75a5ccb14539a56
[4/6] block: stop setting ->direct_IO
      commit: a05f7bd9578b17521a9a5f3689f3934c082c6390
[5/6] block: use iomap for writes to block devices
      commit: 487c607df790d366e67a7d6a30adf785cdd98e55
[6/6] fs: add CONFIG_BUFFER_HEAD
      commit: 925c86a19bacf8ce10eb666328fb3fa5aff7b951

Best regards,
-- 
Jens Axboe



