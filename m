Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BCB40BA72
	for <lists+linux-block@lfdr.de>; Tue, 14 Sep 2021 23:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhINVkU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Sep 2021 17:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbhINVkT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 17:40:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0202FC061574
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 14:39:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g16so520607wrb.3
        for <linux-block@vger.kernel.org>; Tue, 14 Sep 2021 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QD7OayhROXujehkI34HCX9N67G5oxmlfHwV2CUb2QUw=;
        b=ghsorgWps1wHJ/GE1owAIqir1YE47uIxOq2AXcG9+Sf0P3gfFKMw0NGsmrom0NivKM
         Bd+F4IjeUiifvJGOdEjI0abGmXkD9+bt7EzwlJq34psMKbIy6vgRFcCEiRZJbJBbXtm3
         Cojzx+wQdGnDWqXwDpBzfzfVHjc1g9y/a040jHVm8ODdAt0MLU33awcvYpYw8HxdSxin
         83ytg3JDJP9bUO2vi9XxZk+DecL+A+I5r/rgwUVv80B9x3Y9eTp7nnkilEpTICgbdkRm
         5vDlEHfhcAlENY9jexMn4+uGjI8nIw/6wJS80JkONDXxCniJm26TjT2tUBv0BMBijbYv
         P6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QD7OayhROXujehkI34HCX9N67G5oxmlfHwV2CUb2QUw=;
        b=CqBGZjHdQU+xDPoyzkcBqxVOAWmPRG3qbH3DMbcnb4kj/HEw/E5Dlny4v6vTHpmYeZ
         LOKLMXHG1vwij/W9aBdwbeprrZ4YXp4B064XI1O98SPzvLpuBjE0rqqqhqjHPYUVGGcy
         osv8pjJZDVzaz7VHJ5oiqWa5Av/rEQ+3R6i41c1lz4UrQoMYDDCgR8WRU2XcqAAU0AXM
         A+13daE2tAQxHdj4udMkjGEm/pgzaDexqOeuYe58CeJcZJ31t9eU4mApNa2Nu7nMz0C9
         oOq5GrmqaS0dp6H5mzm1D4lCLWfmLeFWNwEf/o8y9nqJ912yLiZuURhbViHm1a2IW3mJ
         I/Bg==
X-Gm-Message-State: AOAM5314WoTs8pGVdPAna812qlgt33bXPrhGbqFpNwpXfkVDVtv7sk67
        wnS2xQKynsCReGCo5g7PtW17p3RikbU=
X-Google-Smtp-Source: ABdhPJy3zvKuJKDnzQa98tSLjq9ePSu5/8hnd9ii5Y+XRT6Yg1EzZTbf1su4QvuqE7BKLJ7E2UT6tw==
X-Received: by 2002:adf:f208:: with SMTP id p8mr1216869wro.379.1631655540418;
        Tue, 14 Sep 2021 14:39:00 -0700 (PDT)
Received: from [192.168.8.197] ([185.69.144.239])
        by smtp.gmail.com with ESMTPSA id x5sm2078499wmk.32.2021.09.14.14.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 14:38:59 -0700 (PDT)
Subject: Re: [PATCH] null_blk: poll queue support
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <1a63be84-3024-722b-232b-90f606a2addd@gmail.com>
Date:   Tue, 14 Sep 2021 22:38:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/21 4:29 PM, Jens Axboe wrote:
> There's currently no way to experiment with polled IO with null_blk,
> which seems like an oversight. This patch adds support for polled IO.
> We keep a list of issued IOs on submit, and then process that list
> when mq_ops->poll() is invoked.

That would be pretty useful to have.

to fold in:

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 5914fed8fa56..eb5cfe189e90 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1508,7 +1508,7 @@ static int null_poll(struct blk_mq_hw_ctx *hctx)
 		cmd = blk_mq_rq_to_pdu(req);
 		cmd->error = null_process_cmd(cmd, req_op(req), blk_rq_pos(req),
 						blk_rq_sectors(req));
-		nullb_complete_cmd(cmd);
+		end_cmd(cmd);
 		nr++;
 	}
 
> 
> A new parameter is added, poll_queues. It defaults to 1 like the
> submit queues, meaning we'll have 1 poll queue available.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---

-- 
Pavel Begunkov
