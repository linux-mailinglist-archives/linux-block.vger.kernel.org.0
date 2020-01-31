Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF3814F189
	for <lists+linux-block@lfdr.de>; Fri, 31 Jan 2020 18:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgAaRtT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 31 Jan 2020 12:49:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44305 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgAaRtT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 12:49:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so3824302pgl.11
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 09:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NqY9ETg9tXvM0DorJighH08vOiPBH+VJKGXzPrmcnPk=;
        b=JG8n7NOW3H7smU/BqfmUQ9vQSuVhYCsJxa2ijzKfNYekDTREKAliqYsTlsM9vPhnXE
         lLwuKFD8BPffeYiLv+B9+dsggX2q1f8z5fJ/uOl1ISmPijCedZNI7+8OGppuBT3PJkbB
         NfWdqb4fHYnxYHUYQssffDl/aqH2EWi5ZgkcROnZnEupuk1Fz87hcvzoShF5bK3CJlUy
         tCZz8YoN/4kX+Ye9jGTOBTmFbvs7Mt4YxJhMuzUh0DQrGrOiNSypSVN0I6d5ky0K59oM
         z9NSLtQd/fA4enZiO00/H/QM6TPpslzDmd4euD73Be2S3g49C+NIziTLoZsrRUhHBwHX
         OMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NqY9ETg9tXvM0DorJighH08vOiPBH+VJKGXzPrmcnPk=;
        b=DZmy9B5BabQiVwwvPxWj7/XnGaG0o1OAFryegZAoPnLbasb0dznj7tGgiLIzvp+QFO
         enddDsUguBaIQEoanjVAMXiblAhhf8DBisl1A1AmgMGZyq0eAP5EhHPrtkzvLuJfARhj
         nfltPa9Il4T3iqjTOOesDRJeXEYmE3YcInqQwfL0BaJyQH1I+HvhafXTpM3XVDOC0dXl
         eVHLQkenAMvwdvswjiO86oFGazn5JDWnTUXJFVlhSO+wtOZPe6c201xC5RrOZCBwr3WM
         MrkOUxCrtispR6YqR7rcw9MAM03aKqFr+Sd9RIDBCqjbUvx2QbIIzt3cCsmhwyqVZBU3
         58Kw==
X-Gm-Message-State: APjAAAXuBZxi+75SNMnArgHAOJXBc0HNNhHbVCTrbVwaGgeDHjf+N2Vl
        K0M/ZLRgY0lOKx/maD1EzWq35A==
X-Google-Smtp-Source: APXvYqwu+UIm8Bjlim0xjKh3/nW4mAcpLcRNzFX452/LXS9hYMCHjG+jnmAkuJheoIDlE6wjQsS+BQ==
X-Received: by 2002:a63:190c:: with SMTP id z12mr10556079pgl.1.1580492956578;
        Fri, 31 Jan 2020 09:49:16 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1371? ([2620:10d:c090:180::d1ba])
        by smtp.gmail.com with ESMTPSA id r6sm11034572pfh.91.2020.01.31.09.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 09:49:15 -0800 (PST)
Subject: Re: [PATCH v8 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jinpu Wang <jinpuwang@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>, rpenyaev@suse.de
References: <20200124204753.13154-1-jinpuwang@gmail.com>
 <CAHg0HuzLLHqp_76ThLhUdHGG_986Oxvvr15h_13T12eEWjyAxA@mail.gmail.com>
 <20200131165421.GB29820@ziepe.ca>
 <f657d371-3b23-e4b2-50b3-db47cd521e1f@kernel.dk>
 <CAD9gYJLVMVPjQcCj0aqbAW3CD86JQoFNvzJwGziRXT8B2UT0VQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a1aaa047-3a44-11a7-19a1-e150a9df4616@kernel.dk>
Date:   Fri, 31 Jan 2020 10:49:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAD9gYJLVMVPjQcCj0aqbAW3CD86JQoFNvzJwGziRXT8B2UT0VQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/31/20 10:28 AM, Jinpu Wang wrote:
> Jens Axboe <axboe@kernel.dk> 于2020年1月31日周五 下午6:04写道：
>>
>> On 1/31/20 9:54 AM, Jason Gunthorpe wrote:
>>> On Fri, Jan 31, 2020 at 05:50:44PM +0100, Danil Kipnis wrote:
>>>> Hi Doug, Hi Jason, Hi Jens, Hi All,
>>>>
>>>> since we didn't get any new comments for the V8 prepared by Jack a
>>>> week ago do you think rnbd/rtrs could be merged in the current merge
>>>> window?
>>>
>>> No, the cut off for something large like this would be rc4ish
>>
>> Since it's been around for a while, I would have taken it in a bit
>> later than that. But not now, definitely too late. If folks are
>> happy with it, we can get it queued for 5.7.
>>
>> --
>> Jens Axboe
> 
> Thanks Jason, thanks Jens, then we will prepare later another round for 5.7

It would also be really nice to see official sign-offs (reviews) from non
ionos people...

-- 
Jens Axboe

