Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E705B0BD1
	for <lists+linux-block@lfdr.de>; Wed,  7 Sep 2022 19:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiIGRwa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 7 Sep 2022 13:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiIGRw3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 13:52:29 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BEAAA4DA
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 10:52:27 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id s22so11075907qkj.3
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2022 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/GZ+RgTDCqcSeZmgTb6Y4RRZFlczSPsnSW/Az+UNCWc=;
        b=GcLWAS+apMtFksHJpWLKxXtGyX1Wx1anj6qhx0WGSLp6BvKEIIzu3zt2hFDpLIlXjH
         aCDBHqErljVpsb98LAnsRihWZN/Hqh6AxgugUF6GqAgzokJ9K4VlqtvtybMykucrVhXn
         6+Os4Jbwp4Zv/Im/OHB4Ik6ETRMw9npMJVxDyLD5o69NPignqP6rdTt610de8P3jrMtB
         81d3cSvRvO/DCkRLijOlSmU1Bte8P8rzc41HrC4DEaKt7np4bxVzgha2uXLsq5UwaM63
         6Md3i4XH78NfjNuaZ9s/JMw8mAj0M+s3/Vt37vDxOsMnL0IND/+udVNSY7LtVZVacPDT
         nd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/GZ+RgTDCqcSeZmgTb6Y4RRZFlczSPsnSW/Az+UNCWc=;
        b=ZxIyx/CXF4oOeMPu/jqBiRAmGdLUnn1Ob8vWxMNvSJtNPzLMWxP+QjOA4aFBjq2pfA
         j+hMxmF0OtMrqONgL4vk2A9d2ozpOtxN1wy63V5sXyhAiiJHWwpU9Bo5l4P+GyH2P58w
         G/ymaCEWNdEJZeEo8KLQNRoK0VE6OMVMOCUQrEDkgBTypg7JfP0gEdUaTCxyjIQXVsBA
         KFFNblzvTV9JGl/9KbYGmrwBGNxeoHbNS4kd/ILoX5gBPMuJ9kjaoPv1FKDDoOKYFDjO
         V3K6UzN4mWjg5Ji4MMbGgDZORh7VsHMbF58dTzc/t6AXkJc7MReh7ED9cMF6s/PQLr30
         E2Lg==
X-Gm-Message-State: ACgBeo1JvyDeSO6fHxlBAkaeP1cfGp+35VL3x2wy3Ffe2xvWCT9d35ah
        i3uWE49Bo9iTdtweNRdRF73tUA==
X-Google-Smtp-Source: AA6agR4YJQKSl+stdY9bACRxfbDDMb6XmJWajLo6tOxEQ7um20LEh6aFZzAhJse9hO018K6UVILLFw==
X-Received: by 2002:a05:620a:2451:b0:6cb:b4db:a3ad with SMTP id h17-20020a05620a245100b006cbb4dba3admr1923323qkn.216.1662573146562;
        Wed, 07 Sep 2022 10:52:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t11-20020a05620a450b00b006b8e8c657ccsm15372948qkp.117.2022.09.07.10.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:52:26 -0700 (PDT)
Date:   Wed, 7 Sep 2022 13:52:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/17] btrfs: stop tracking failed reads in the I/O tree
Message-ID: <YxjaWHT7PZN37+YD@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-3-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:01AM +0300, Christoph Hellwig wrote:
> There is a separate I/O failure tree to track the fail reads, so remove
> the extra EXTENT_DAMAGED bit in the I/O tree.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Baacik <josef@toxicpanda.com>

Thanks,

Josef
