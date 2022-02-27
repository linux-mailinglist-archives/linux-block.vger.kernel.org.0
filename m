Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87934C5F2D
	for <lists+linux-block@lfdr.de>; Sun, 27 Feb 2022 22:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiB0Vw1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 27 Feb 2022 16:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiB0Vw1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Feb 2022 16:52:27 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01D05BD32
        for <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 13:51:49 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id bc27so919117pgb.4
        for <linux-block@vger.kernel.org>; Sun, 27 Feb 2022 13:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=T+bY3cSVQwU97rpm1PWOkOKMCijaJDttt0NtP9XMRUQ=;
        b=P5MaDUXk16z8/hpH693B2xHSHZo//ZReUYLWsO5WmQlLEtpjLdqZ3SxcShABucESWD
         gkUDZcqvtqrxzTL/HBznk0KrejYwIAj3HoxYQalVeG1HxDmq/YLbpu9NlB4P6TirmJj2
         tNdNIV6wYGqY82VLMA+Mw5GUbyS0jOd/itE8dHkrcVdM9Bb6L95gorWOa8zYmgsddC8h
         zwCoc5DjwY/j3Rg7vXTyev4iXasdo5AcMBQ1q6scfujWk+AKpoL3W0XrcjyD40Gt2MbI
         /8viux9vd/q2pOFj2lly3had36ZTNzGSAeWkdFCorEsxqkjHFwoed3w28lUUMVXaTzda
         BIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T+bY3cSVQwU97rpm1PWOkOKMCijaJDttt0NtP9XMRUQ=;
        b=e1hOXYLvvCywOhKM3XwNr20WMVfhcDsQGVzCLImv3fPqeKARkMtBIjrefjApEGCi3p
         c8WA44rDbvHHZiODwl9akVXrKYJ9RjpGQAf92UP+ajEnJBACWvusCQBQfnF9E5cMWkcj
         /AxdHmRFBHiy5q2vi0Jntu0bIu/7YCOy2Bj39dBXBYV9aWSUH4wxuBWQ67G78civFp/p
         xSHyvWdqVzRF4Ql4L6/optk8g9COFvcmQ0ADywLEw9W9LmoCJ9i/V1L6b1p4ZU5uqTA7
         kKjhVVfJtuW+HvS+U1ZR4x2/B5Q79jNiqAY+zH6hotOnYdEMulqDtr0DP8IthFgiNSvA
         x5eA==
X-Gm-Message-State: AOAM532hrZ2c26WpxfA12AvQ6TqCbMhv7GBAyyszMaTeTQf7sEAfMhUn
        dPnG6SBNOrR9ID6UOOKkydecI/5jIWOrXA==
X-Google-Smtp-Source: ABdhPJw5iyelAy8Y8e7UDBvu5VGI0R9LRLKgwMaAMReYVGgkCIixIT0k5CsicGBwZOju4r6toco/bw==
X-Received: by 2002:a63:221f:0:b0:374:7286:446a with SMTP id i31-20020a63221f000000b003747286446amr14756264pgi.538.1645998709137;
        Sun, 27 Feb 2022 13:51:49 -0800 (PST)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id v23-20020a17090a521700b001bbfc181c93sm15037230pjh.19.2022.02.27.13.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Feb 2022 13:51:48 -0800 (PST)
Message-ID: <d7ed009d-09af-935b-f905-fef7d02f1649@kernel.dk>
Date:   Sun, 27 Feb 2022 14:51:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v9] block: cancel all throttled bios in del_gendisk()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Yu Kuai <yukuai3@huawei.com>
Cc:     ming.lei@redhat.com, tj@kernel.org, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220210115637.1074927-1-yukuai3@huawei.com>
 <YhuyBgZSS6m/Mwu6@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YhuyBgZSS6m/Mwu6@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/27/22 10:16 AM, Christoph Hellwig wrote:
> On Thu, Feb 10, 2022 at 07:56:37PM +0800, Yu Kuai wrote:
>> Throttled bios can't be issued after del_gendisk() is done, thus
>> it's better to cancel them immediately rather than waiting for
>> throttle is done.
>>
>> For example, if user thread is throttled with low bps while it's
>> issuing large io, and the device is deleted. The user thread will
>> wait for a long time for io to return.
> 
> FYI, this crashed left rigt and center when running xfstests with
> traces pointing to throtl_pending_timer_fn.

Dropped for now.

-- 
Jens Axboe

