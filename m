Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE40751B81
	for <lists+linux-block@lfdr.de>; Thu, 13 Jul 2023 10:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjGMI2M (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 13 Jul 2023 04:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjGMI1w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2023 04:27:52 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA364C18
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 01:18:38 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-c5cf26e9669so371251276.0
        for <linux-block@vger.kernel.org>; Thu, 13 Jul 2023 01:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689236247; x=1691828247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=An/lgfGfphqbX1hL0oKKGBUnuYFAW5BJf6INYxK4Dxo=;
        b=fMaMqgzEJcFheU9cUMf4jHc+VgZuKRcayfupFiAAHVSZwN2eGuJ0iY9WSnRCT+k1aF
         rqGTZ7/bWxogAyhv6Ke0+0lk8P83qa3dmlrEhXp+npJV3hpadt87H3WJztjnolYYQMnK
         skmlT/ZvhgFN8CT/sINe/QIBki05k3+/sJa3RwYEIUWiB5z9bzvm1/qP0lO42C3//ReJ
         +Iq0t7xow5sWHz427kMkYiTIXxW2kq/M5kNJq760tMQ+czB85Mh1gd+wi2phmxP1X6C4
         qnBwE8MWo418C2GFTXXcm6dhOlNyhCLbOPJ4DtqBs8ZDiNa0g7kaHecEdGA8C/z0JjIa
         hP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689236247; x=1691828247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=An/lgfGfphqbX1hL0oKKGBUnuYFAW5BJf6INYxK4Dxo=;
        b=ImJrsbh0reo3F7fZHWmZ7rkIwnzSnOsTrwKZGN3w1x8ScJU0rtxLozzprH2vNXSItB
         Fp8YmlfRL9p5iBbq64d5AHm2N9bUYZpMpA0leYlmhU+BsAPafL0sTKEQSqaelMbxRQ+S
         cXkcLNOOAhAXN8cvUgjnxYldWnz9AIOyAga7/U+zFoas33ljnWF64H0ljd3vNEponzHp
         yu1UTKxzoJj5UGUrlGsHdkc5R2a4uRnnL6WEn+Wa75gkUCAfnCM1hFuQIlguxpFtj/PS
         TehqhcQ2/XOZU8Hte9k9CcLQn4J2mYxYumrEvQqbypuax88KRckTrnyUFbwo3gLvDrqi
         0/YQ==
X-Gm-Message-State: ABy/qLbGbHCtVwxzOat9PSvSSxNMmRuT3k8vyRODWAVCocT7Uf54MiBk
        VaDm4wJhvt9N+ErSEsTufunRdh8G5SkJLPdltms=
X-Google-Smtp-Source: APBJJlEIV5MP79fSqL2cxlOxBR4Hvs8OKm8tFgJmSWtKz6UW7+XN4NUCM/wRKHTmCQ2+6zGY59R6Z268+NkTfzQy0Mw=
X-Received: by 2002:a25:f43:0:b0:c3d:25af:45ec with SMTP id
 64-20020a250f43000000b00c3d25af45ecmr686366ybp.41.1689236247458; Thu, 13 Jul
 2023 01:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <ZJL3+E5P+Yw5jDKy@infradead.org> <20230625022633.2753877-1-houtao@huaweicloud.com>
 <7f49a5ad-8b34-c00c-9270-8d782200c78c@nvidia.com>
In-Reply-To: <7f49a5ad-8b34-c00c-9270-8d782200c78c@nvidia.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 13 Jul 2023 10:17:18 +0200
Message-ID: <CAM9Jb+jpRCKHxykW5-obnkzhzyPoiZupVAMcb=dTq6h+ajRHFQ@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_pmem: add the missing REQ_OP_WRITE for flush bio
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Hou Tao <houtao@huaweicloud.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> I've failed to understand why we should wait for [0] ...

Sorry, missed to answer before. The optimization was to make the
virtio-pmem interface completely
asynchronous and coalesce the flush requests. As this uses the
asynchronous behavior of virtio bus
there is no stall of guest vCPU, so this optimization intends to solve below:

- Guest IO submitting thread can do other other operations till the
host flush completes.
- As all the guest flush work on one virtio-pmem device. If there is
single flush in queue all the subsequent flush would wait enabling
request coalescing.

Currently, its solved by splitting the bio request to parent & child.
But this results in preorder issue (As PREFLUSH happens after the
first fsync, because of the way how bio_submit() works). I think the
preflush order issue will still remain after this patch. But currently
this interface is broken in mainline. So, this patch fixes the issue.


Thanks,
Pankaj
