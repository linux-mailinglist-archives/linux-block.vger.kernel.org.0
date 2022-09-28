Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B8E5EDEC2
	for <lists+linux-block@lfdr.de>; Wed, 28 Sep 2022 16:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiI1O2K (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Sep 2022 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiI1O2I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 10:28:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612FBAB427
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 07:28:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso2489656pjf.5
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 07:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=RlRvct3277EYFToPkW4od6VyhmMFB2bnHNyqnEFyrBM=;
        b=CTdt4QqtPWlmjOer5e4jfzrIOLyZndPvQViX2DxuaaYRi8jdHNRDhr15r7TTLmXcif
         ebtsA7cI6Yht1jcDtTlaI7tNQWSyu3lyLXeJvrYgKh2N6YcU+2pmRUbVjWWDCE00cbeg
         CHLGEXblutHx4aNfjvq7TzZheZqNR2IMKSDnFFZItikZb4W9FkWqXYG/Yyghk5Y/aEwT
         Ety7xrr38GrtQZE8vq52oiX0kfyEPpqLuMs8SlObeRtqUOlmpbe7RPUep0w/NeKfsql0
         6R5KsKOtX3ryXHOHNa0Qop+K8XGpOtUsbEPzMExvi7giv7WI3IsfIe2zhzJYnGWRov6U
         cyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=RlRvct3277EYFToPkW4od6VyhmMFB2bnHNyqnEFyrBM=;
        b=53dQn2Si/1PH0wZiUu0LOzrxmEvyWgi7eiSbwKZ1xBUU4paC9MqD1Gh6IE2FaL9V7c
         Eq+7Ffx+8Ju69oG8NnkxUyFZQZGh/PYbeHv+1CqoC9dwQrNjy3zu92QEkJ2ZWrz30jL0
         mfQ+21++XWrOyo+qMgzVPhPiMkfgBdEcrLbIHDdn6BiLN1XcCLFjCv70fG4zzjyXxVYJ
         0zrnP68Wqirb06NIUJIUfUDb9QhXTQWlB2phByD5Je++aBx/KEKPOU2P8fUkttWSk8ft
         +FUmfUtpQ5mt5hW68A0DvqgsIIEEX6UDvMtG9g55g0HpB1qE08YI105AznvJQm4h+Oj2
         vpcA==
X-Gm-Message-State: ACrzQf2GaKLsJ1/AudgsEGSloTEfELWpKp6ngUFZXwWjIfGYVm0jk+2c
        QCTwPwdMIoa0xm9sPHmf58BP1g==
X-Google-Smtp-Source: AMsMyM4REYpTDSAfEZcJo3ADi76E0K/8bIe2v79W+pe1cKZ3OjTnXEc2ij22YaVeD7Sl7qwFecHbkg==
X-Received: by 2002:a17:902:dac7:b0:178:b5e0:3627 with SMTP id q7-20020a170902dac700b00178b5e03627mr72355plx.147.1664375283710;
        Wed, 28 Sep 2022 07:28:03 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u8-20020a170903124800b00178b717a143sm3907725plh.126.2022.09.28.07.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:28:03 -0700 (PDT)
Message-ID: <96154f6c-c02a-4364-c2a8-c714d79806d3@kernel.dk>
Date:   Wed, 28 Sep 2022 08:28:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH for-next v10 0/7] Fixed-buffer for uring-cmd/passthru
Content-Language: en-US
To:     Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, gost.dev@samsung.com
References: <CGME20220927174622epcas5p1685c0f97a7ee2ee13ba25f5fb58dff00@epcas5p1.samsung.com>
 <20220927173610.7794-1-joshi.k@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220927173610.7794-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/22 11:36 AM, Kanchan Joshi wrote:
> Hi
> 
> uring-cmd lacks the ability to leverage the pre-registered buffers.
> This series adds that support in uring-cmd, and plumbs nvme passthrough
> to work with it.
> Patch 3 and 4 contains a bunch of general nvme cleanups, which got added
> along the iterations.
> 
> Using registered-buffers showed IOPS hike from 1.65M to 2.04M.
> Without fixedbufs
> *****************
> # taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B0 -O0 -n1 -u1 /dev/ng0n1
> submitter=0, tid=2178, file=/dev/ng0n1, node=-1
> polled=1, fixedbufs=0/0, register_files=1, buffered=1, QD=128
> Engine=io_uring, sq_ring=128, cq_ring=128
> IOPS=1.63M, BW=796MiB/s, IOS/call=32/31
> IOPS=1.64M, BW=800MiB/s, IOS/call=32/32
> IOPS=1.64M, BW=801MiB/s, IOS/call=32/32
> IOPS=1.65M, BW=803MiB/s, IOS/call=32/31
> ^CExiting on signal
> Maximum IOPS=1.65M
> 
> With fixedbufs
> **************
> # taskset -c 0 t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1 -O0 -n1 -u1 /dev/ng0n1
> submitter=0, tid=2180, file=/dev/ng0n1, node=-1
> polled=1, fixedbufs=1/0, register_files=1, buffered=1, QD=128
> Engine=io_uring, sq_ring=128, cq_ring=128
> IOPS=2.03M, BW=991MiB/s, IOS/call=32/31
> IOPS=2.04M, BW=998MiB/s, IOS/call=32/32
> IOPS=2.04M, BW=997MiB/s, IOS/call=32/31
> ^CExiting on signal
> Maximum IOPS=2.04M

Christoph, are you happy with the changes at this point?

-- 
Jens Axboe


