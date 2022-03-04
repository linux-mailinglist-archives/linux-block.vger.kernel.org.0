Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608FB4CDE8F
	for <lists+linux-block@lfdr.de>; Fri,  4 Mar 2022 21:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiCDUDF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Mar 2022 15:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiCDUCn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 15:02:43 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C1723EE54
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 11:53:50 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so10643188ooi.2
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 11:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ngnYdHqHX0ob26fBskLNuWtCgUWkLmLTIT0t9WbICL4=;
        b=Rnbcg4cjSLMt35FRWfDoCNwLG8yqIEcNC/4CDuqOeWUL2UbhD5icci+r2Vs6F+oKhv
         Dm/P2jTtoALbDOce0IyLxnV8wEwzldwUNzUPSlySLaTJ19yqxQq+RGOiGpGrynEfk5gY
         9tmt52DxY7GoyUlHxtomylt6F+cJdeiwaGHaspEoiRImWbfOqPglCdayEgI0ElKkMIyW
         qtpd7NFyo8640nNaWdjrLgIJBNVGdwKCwS9yqD3zx4MgtHstP9TlXS3cUCKxGI88CTJZ
         EEiFM/Lnz9ee2vdwEll1E5aN0rWTm0fqNv8DEwiAJn8YTbqzl+wE3dG3W6oPutlaw/SW
         f5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ngnYdHqHX0ob26fBskLNuWtCgUWkLmLTIT0t9WbICL4=;
        b=7hGbciA197QqZg1UIm5Ymz9ctsDYQ1TodGTTMaHS0HKS8ekctAFI9qee/KpkLygtN3
         Zx8XettET0XnN0lbmo5Jll6bOLUy54ECL+6LhmigeiiJj8xgnBXMiZ87uVsO3u8FcTsG
         y8DBCFwP4YlDzGmfMujNLTjF+O/v0DLT5xIaLpPDgQXbyRj08PHjpI0DOw17aLyWae8N
         y5EDUr528gY7wMuBroDl1cmuv7dXpqiOu6y/e1RfsTJ/1YGcATbyTfBCAPNNbaCNo+dx
         A6VBMnxecFg+ksCH08XOT435XohDlXTgoOuSvkTxKtMawJGONy4lO/OEfYt7d0J9TEqy
         IQKA==
X-Gm-Message-State: AOAM530j6byRNaH/ISxY1FZYyJv9r8Na6FTTYlJgr0Q7D8Mf++/uy351
        avp/GKyVHvwboi/qDHWhmMuD13Q+gjhQ6A==
X-Google-Smtp-Source: ABdhPJxOOPisoZmDfj6F3/n1EIPu2+rUEXchMh8/8sGgVHx2B8DfMALx8wwjZbLjjoqkE4MjHXrmVQ==
X-Received: by 2002:a17:90b:1c8e:b0:1bf:364c:dd7a with SMTP id oo14-20020a17090b1c8e00b001bf364cdd7amr173281pjb.103.1646422177250;
        Fri, 04 Mar 2022 11:29:37 -0800 (PST)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id mu1-20020a17090b388100b001bedddf2000sm5521490pjb.14.2022.03.04.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 11:29:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Justin Sanders <justin@coraid.com>,
        Nitin Gupta <ngupta@vflare.org>, nvdimm@lists.linux.dev,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-bcache@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        drbd-dev@lists.linbit.com,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Minchan Kim <minchan@kernel.org>, linux-block@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Coly Li <colyli@suse.de>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Denis Efremov <efremov@linux.com>,
        Dan Williams <dan.j.williams@intel.com>
In-Reply-To: <20220303111905.321089-2-hch@lst.de>
References: <20220303111905.321089-1-hch@lst.de> <20220303111905.321089-2-hch@lst.de>
Subject: Re: [PATCH 01/10] iss-simdisk: use bvec_kmap_local in simdisk_submit_bio
Message-Id: <164642217510.204397.18145743592419266706.b4-ty@kernel.dk>
Date:   Fri, 04 Mar 2022 12:29:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 3 Mar 2022 14:18:56 +0300, Christoph Hellwig wrote:
> Using local kmaps slightly reduces the chances to stray writes, and
> the bvec interface cleans up the code a little bit.
> 
> 

Applied, thanks!

[01/10] iss-simdisk: use bvec_kmap_local in simdisk_submit_bio
        commit: 143a70b8b4300faa92ad82468f65dccd440e7957
[02/10] aoe: use bvec_kmap_local in bvcpy
        commit: b7ab4611b6c793100197abc93e069d6f9aab7960
[03/10] zram: use memcpy_to_bvec in zram_bvec_read
        commit: b3bd0a8a74ab970cc1cf0849e66bd0906741105b
[04/10] zram: use memcpy_from_bvec in zram_bvec_write
        commit: bd3d3203eb84d08a6daef805efe9316b79d3bf3c
[05/10] nvdimm-blk: use bvec_kmap_local in nd_blk_rw_integrity
        commit: 20072ec828640b7d23a0cfdbccf0dea48e77ba3e
[06/10] nvdimm-btt: use bvec_kmap_local in btt_rw_integrity
        commit: 3205190655ea56ea5e00815eeff4dab2bde0af80
[07/10] bcache: use bvec_kmap_local in bio_csum
        commit: 07fee7aba5472d0e65345146a68b4bd1a8b656c3
[08/10] drbd: use bvec_kmap_local in drbd_csum_bio
        commit: 472278508dce25316e806e45778658c3e4b353b3
[09/10] drbd: use bvec_kmap_local in recv_dless_read
        commit: 3eddaa60b8411c135d1c71090dea9b59ff3f2e26
[10/10] floppy: use memcpy_{to,from}_bvec
        commit: 13d4ef0f66b7ee9415e101e213acaf94a0cb28ee

Best regards,
-- 
Jens Axboe


