Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF5A375F12
	for <lists+linux-block@lfdr.de>; Fri,  7 May 2021 05:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhEGDR2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 6 May 2021 23:17:28 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:44885 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhEGDR2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 23:17:28 -0400
Received: by mail-pg1-f180.google.com with SMTP id y32so6150046pga.11
        for <linux-block@vger.kernel.org>; Thu, 06 May 2021 20:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OyoX825gUsXW883Jf2nn4el1fRPO3SNvxfFbdn6Vxj8=;
        b=i8Szz3azX+iEyXOMECRgxE/LdSfYRFUjw0+KSLSg2GFoYhL6ByXRCfl4LqN+rO/mXS
         Pd4qO5Qwq236JxxU6VnbfsAR6Fy+isUbsO//BZEzAwThWFFqy0+PG+2/z5OD+24Z/kXs
         n7EGt/PJB5GITl4eIvNvaLJJ7nG8xamib2UUj0wr/pO0vSW6c5CRxim+XtgXNDKA97Q5
         pMBDth65xfK4KdDmlzWc4Iuck4YyVihdy3oWLvD4C5vxKLq0JQYG/DOxc7+VpIeZfy9C
         tk2reqGC3PbnhuklqDzSDZBuQeSf7VrvUdY8nyuNbVDv8c7eXEKdNQhg+HWx4LL/jwgH
         kNow==
X-Gm-Message-State: AOAM531KM+P3tzeJLGAgTAFQT/LvjXc3PYaHGzZ63MYVP4ikbU52kxfO
        3c5469XFJQpRUXqcV3VO4VvhdmGDj0w=
X-Google-Smtp-Source: ABdhPJwBkhh2mGRXNkK9s6cble+ywKAjgYtNO9aeQwwcLm4PX5WIx9L+9+0wC0C5iwxqsE6FAg5DEw==
X-Received: by 2002:a62:aa12:0:b029:28e:7580:8f3d with SMTP id e18-20020a62aa120000b029028e75808f3dmr7950564pff.42.1620357387840;
        Thu, 06 May 2021 20:16:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:5aec:6a45:557b:c859? ([2601:647:4000:d7:5aec:6a45:557b:c859])
        by smtp.gmail.com with ESMTPSA id x23sm3361373pfc.170.2021.05.06.20.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 20:16:26 -0700 (PDT)
Subject: Re: [PATCH V5 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210505145855.174127-1-ming.lei@redhat.com>
 <20210505145855.174127-4-ming.lei@redhat.com>
 <20210506071256.GD328487@infradead.org> <YJOb+a85Cpb56Mdz@T590>
 <20210506121849.GA400362@infradead.org>
 <b21d9e07-577b-f9cd-257f-323a82d8d74d@acm.org> <YJSFm99PUlLedF+D@T590>
 <739456b9-e8d4-310e-9bf3-7b8930a1e51c@acm.org> <YJSggHqgMFfWIALu@T590>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a2a7e66b-68e8-6468-2add-19ffbe096ed9@acm.org>
Date:   Thu, 6 May 2021 20:16:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YJSggHqgMFfWIALu@T590>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/6/21 7:05 PM, Ming Lei wrote:
> Putting the lock pair after clearing rq mapping should work, but not see
> any benefit: not very readable, and memory barrier knowledge is required for
> understanding its correctness(cmpxchg has to be completed before unlock), ...,
> so is it better idea to move lock pair after clearing rq mapping?

It depends on how much time will be spent inside
blk_mq_clear_rq_mapping(). If the time spent in the nested loop in
blk_mq_clear_rq_mapping() would be significant then the proposed change
will help to reduce interrupt latency in blk_mq_find_and_get_req().

Thanks,

Bart.
