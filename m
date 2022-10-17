Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1024E600423
	for <lists+linux-block@lfdr.de>; Mon, 17 Oct 2022 01:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJPXXH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 16 Oct 2022 19:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiJPXXG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Oct 2022 19:23:06 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0D033E14
        for <linux-block@vger.kernel.org>; Sun, 16 Oct 2022 16:23:05 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id bb5so6809730qtb.11
        for <linux-block@vger.kernel.org>; Sun, 16 Oct 2022 16:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2YKjKjr/Iqhytm7HQxGJmcY+ib/Qdg9cNU3yBgPhck=;
        b=SwDTvufwiN1eCsa8868EcV7Jt1pk4Ew6nZKhghXJLs2+DM23wm2GxI5FUHrmRiiC5p
         Lz+bshugc4O559q0+RHnw8CT4KkDxRMtSdT9Fj+4CQ/EVlpK6Ghe5T83uPS2o5C8t0Eq
         tGZc3IdT4fjd/vd9y+SI1kOzTrjO3m7uwv9/ucrTlWYD15dDMCPfIEIdU2RRD5gui3gW
         /6sVlqOJE3Y24NNft+48F2hREfhrtXdxJ1KWLkseDl2GIhhwG1hC4BWKPmw47k39AZvZ
         ScWeSPqbgCapYyPduiIwxILlB8jsQvt/7nGxncgU0NqYPpOKXswASRGVoymB904+u5vx
         6DEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2YKjKjr/Iqhytm7HQxGJmcY+ib/Qdg9cNU3yBgPhck=;
        b=GTmIFT7crCSdB8UVQsvBuy+Y2Uv3cswzTezX3JHFBIghc5FXsRRTsGOE/6f2+blSWk
         cMY4xbmsQpUflKk/86X8O6iCJP0auzs/U0aB4ZNwn6SzJO9wZ7GMejpeD2xTIu6WhDU7
         HDbITSJODplXDuiRvf8XfMg5zb1zO4iSzl0kqs2KASWCO4God3PJLoupobZ0RJeE54En
         ePxuXD+eJByjwLxaLYs0M+W9HQVkGIcLCufM90aEHcyNOZYGhOZbx3G6+E9Wq3hZ2BJq
         T6grIjXrZ9RtXb0oNJkPV34X4vvgdufUhDY8S/w3taxmoMyHwL7N35+dnEShml4dQI1P
         I/uQ==
X-Gm-Message-State: ACrzQf0UOONJZDg97U2lq8cKniOYu2jqY22RhQGlE96wznnNx86anwBU
        neu68FgHE2qbJN6FgdMz53WCB3AnUTCt77jZ
X-Google-Smtp-Source: AMsMyM7DmNkIX93gUNRD6AhHpjgtw942VFTuB/nlonmEnCVrh2HKOywJwR0A82bLSIh0rRdmrXOpeQ==
X-Received: by 2002:ac8:5dcb:0:b0:39c:ce78:47a1 with SMTP id e11-20020ac85dcb000000b0039cce7847a1mr6742897qtx.615.1665962584717;
        Sun, 16 Oct 2022 16:23:04 -0700 (PDT)
Received: from [127.0.0.1] ([8.46.73.120])
        by smtp.gmail.com with ESMTPSA id cm16-20020a05622a251000b00399b73d06f0sm6693624qtb.38.2022.10.16.16.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:23:04 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, Yu Kuai <yukuai1@huaweicloud.com>,
        john.garry@huawei.com, hare@suse.de
Cc:     linux-block@vger.kernel.org, yukuai3@huawei.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
In-Reply-To: <20221011142253.4015966-1-yukuai1@huaweicloud.com>
References: <20221011142253.4015966-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] blk-mq: fix null pointer dereference in blk_mq_clear_rq_mapping()
Message-Id: <166596258175.7979.3302811091883290568.b4-ty@kernel.dk>
Date:   Sun, 16 Oct 2022 17:23:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 11 Oct 2022 22:22:53 +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Our syzkaller report a null pointer dereference, root cause is
> following:
> 
> __blk_mq_alloc_map_and_rqs
>  set->tags[hctx_idx] = blk_mq_alloc_map_and_rqs
>   blk_mq_alloc_map_and_rqs
>    blk_mq_alloc_rqs
>     // failed due to oom
>     alloc_pages_node
>     // set->tags[hctx_idx] is still NULL
>     blk_mq_free_rqs
>      drv_tags = set->tags[hctx_idx];
>      // null pointer dereference is triggered
>      blk_mq_clear_rq_mapping(drv_tags, ...)
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix null pointer dereference in blk_mq_clear_rq_mapping()
      commit: 76dd298094f484c6250ebd076fa53287477b2328

Best regards,
-- 
Jens Axboe


