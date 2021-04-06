Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C45355AD7
	for <lists+linux-block@lfdr.de>; Tue,  6 Apr 2021 19:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhDFRyy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 6 Apr 2021 13:54:54 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:38510 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234333AbhDFRyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 13:54:53 -0400
Received: by mail-pl1-f179.google.com with SMTP id y2so7936939plg.5
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 10:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8oBogOUE76XQpK9g6WvEcHqOCHLvNJGQho+9Vw0Xz3k=;
        b=CmqCeBW2on6Eus/P2gxb/G7aXLq5Y393D/TMK9ECMe/BSuYtKflIl1Cev0CXIdyKjj
         dvQ34wT6fSwf2UGfhnJSlDPXYtCskA6tcTb5q3mxcjsSE7oYwIEg+q3SYpHOvYUKYP6p
         FiERlw0A1qQHHpZ7woF7zNR3D3fglqOxaKgn/Vw2YR4v7nbOWKicdWwZ8uk72XObOhw1
         5ARC2g2MpnEfYyRzzRIl4MqN9FVUXKLwTIX4t2kPUxIEJg0bXyhCwBoLQaGg9D7bBbNF
         PL7b0LEtR6aRFrtDQNF37t35vUGbb9CO6R/FVY4+iE5X75JBTKVZw+Q9tDyO5YHAcT1b
         k5Tw==
X-Gm-Message-State: AOAM532E8NtUFGTPKwpxhoe8M31q8QK2KJ7myC9Qy1tqr8ogpP1jBmyX
        wN28WJRIhGo/9SVW764rKdnQ4x0pc4Y=
X-Google-Smtp-Source: ABdhPJzQPhZfYfgh6QS6ghlC2B3msbe5O9kyV6MnRCjo1U0OaMRJEorrP0j4LNyi1C4+vhjKQ9FRZw==
X-Received: by 2002:a17:90a:3904:: with SMTP id y4mr3934262pjb.125.1617731685393;
        Tue, 06 Apr 2021 10:54:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:277d:764e:de23:a2e8? ([2601:647:4000:d7:277d:764e:de23:a2e8])
        by smtp.gmail.com with ESMTPSA id m1sm2994042pjk.24.2021.04.06.10.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 10:54:44 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: set default elevator as deadline in case of hctx
 shared tagset
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yanhui Ma <yama@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>
References: <20210406031933.767228-1-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8b1947b0-2099-ab96-f056-c35da5f6f89f@acm.org>
Date:   Tue, 6 Apr 2021 10:54:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210406031933.767228-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/21 8:19 PM, Ming Lei wrote:
> Yanhui found that write performance is degraded a lot after applying
> hctx shared tagset on one test machine with megaraid_sas. And turns out
> it is caused by none scheduler which becomes default elevator caused by
> hctx shared tagset patchset.
> 
> Given more scsi HBAs will apply hctx shared tagset, and the similar
> performance exists for them too.
> 
> So keep previous behavior by still using default mq-deadline for queues
> which apply hctx shared tagset, just like before.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
