Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F75707234
	for <lists+linux-block@lfdr.de>; Wed, 17 May 2023 21:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjEQTbR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 May 2023 15:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjEQTbK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 May 2023 15:31:10 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769C92729
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 12:31:02 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-760dff4b701so7551939f.0
        for <linux-block@vger.kernel.org>; Wed, 17 May 2023 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684351862; x=1686943862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OHLR70ERErcVWVOIXcQUQzyAztkWXEGKP3uB9D4eFw=;
        b=0QRWMWCG0ozeMGf/GOHaYaYARviZj/cR3DDQVK+yx0cxaiVOauI+uj/hBJh6OtP+W0
         Dx4eh+mq0r/gVuMINr3TU/4rPVjT5qT7njOKjdEVYTPOzhh0+x82N9D3vshpbrtafkfE
         Xu4aXL9+C6MwsavD35QKtGH0TcfuuTMKgS7HYR7sGJJVWUl3K6188LDp6rsDYjzSZz3W
         Kj/ogAToFXcAskZrtMyPGgKcrdw81VFU6auNyqJMFtjl0soO4jUP6HpfcqI140NpYcVm
         xYMnv/RUQ8tvBM1kThkcg9SHQyi+L4M4vb2M9ya2+PfScUiuWZKt39R2iT8IpB9CK/Sd
         UYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351862; x=1686943862;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OHLR70ERErcVWVOIXcQUQzyAztkWXEGKP3uB9D4eFw=;
        b=H5zzT4fJo2fVlWVdebsGjuivEivA1ukCugWzpWEg+dzYRoAtMOzIcKtXP3q8Nd3/qy
         abQDUt/1Ys9lFO3+kqpJqUgOd7z3GO8p0O2V/95OkxHeHp8V8Ijf14yeJIb3n5ZWqG5I
         kHYg2P+JwOhoG21QolnfXtfDbp+TrkOGD2CNNVTnGgOz6iGguwB/vHchc0Nscd4roQvf
         b8TaDAKC9K73EE7o/7bZ95eecvvo7Ex3iQnsndvOyaI+rRc9IqhzPlnMBsRx3+5btOXr
         F1KzqnB25otTkeJzR+8pFKz+IlGWJHZgQR1PFbzujNF1GwpYReaut9KDQguN+F4PSMTT
         1LyQ==
X-Gm-Message-State: AC+VfDw08gDRImdgBA0Q9YYZhpzP7yOzYfh6iKzG5uFEiGy/k/Tx9Uwy
        MUur54Fe6O5KVxcrIIlye863mg==
X-Google-Smtp-Source: ACHHUZ78FLRicfxazm65ydU45P11Uw42OT1d6h8VwqAthGiaYjb/pWt8nd4BCq6WD7gnoyRJ6NNHVg==
X-Received: by 2002:a6b:144f:0:b0:770:4bd:34b9 with SMTP id 76-20020a6b144f000000b0077004bd34b9mr1887014iou.2.1684351861763;
        Wed, 17 May 2023 12:31:01 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q3-20020a027b03000000b0041672c963b3sm7422559jac.50.2023.05.17.12.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 12:31:01 -0700 (PDT)
Message-ID: <84e1ce69-d6d5-5509-4665-2d153e294fc8@kernel.dk>
Date:   Wed, 17 May 2023 13:31:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH for-next 2/2] nvme: optimise io_uring passthrough
 completion
Content-Language: en-US
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        io-uring@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
        joshi.k@samsung.com
References: <cover.1684154817.git.asml.silence@gmail.com>
 <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com>
 <20230517072314.GC27026@lst.de>
 <9367cc09-c8b4-a56c-a61a-d2c776c05a1c@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9367cc09-c8b4-a56c-a61a-d2c776c05a1c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/17/23 6:32 AM, Pavel Begunkov wrote:
> On 5/17/23 08:23, Christoph Hellwig wrote:
>> On Mon, May 15, 2023 at 01:54:43PM +0100, Pavel Begunkov wrote:
>>> Use IOU_F_TWQ_LAZY_WAKE via iou_cmd_exec_in_task_lazy() for passthrough
>>> commands completion. It further delays the execution of task_work for
>>> DEFER_TASKRUN until there are enough of task_work items queued to meet
>>> the waiting criteria, which reduces the number of wake ups we issue.
>>
>> Why wouldn't you just do that unconditionally for
>> io_uring_cmd_complete_in_task?
> 
> 1) ublk does secondary batching and so may produce multiple cqes,
> that's not supported. I believe Ming sent patches removing it,
> but I'd rather not deal with conflicts for now.

Ming, what's the status of those patches? Looks like we'll end up
with a dependency regardless of the ordering of these. Since these
patches are here now, sanest approach seems to move forward with
this series and defer the conflict resolving to the ublk side.

-- 
Jens Axboe


