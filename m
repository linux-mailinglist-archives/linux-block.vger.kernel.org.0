Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EAB5E7E45
	for <lists+linux-block@lfdr.de>; Fri, 23 Sep 2022 17:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiIWPXV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 23 Sep 2022 11:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbiIWPXI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 11:23:08 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F720148A2A
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 08:22:58 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v128so151764ioe.12
        for <linux-block@vger.kernel.org>; Fri, 23 Sep 2022 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=aj427EoyOIOpXGm7xFat3kqE/v++sDMs91pMGtHoDng=;
        b=RuQ488wvYkdtTlucK5RLBdMTThXD3sbSSbXW2cXsiqxLGIQK9mZXy5XJwisC727RR2
         v1mOFOB7KncwMOjpCHSAXz3qJc2PzLN0zAd98/cbaGvOlm+ps5VKAnLSRfoJV34OlrrG
         JFdo/85HBFYbI6eFHMMj1Th5685EbncE1VUJ6bizqOlthoM+mwyji6AGoxxTRvpyQncm
         +SSO5GLwHgMMD8fKQ3gaCWhXQJQvkMJCt2NX3QddiRi23dN7pVD+rPrYWNE4oqp81NKM
         OQIa9oXnaJZYufjF49owWISPcocZ781LqwxyhEOPEcT8FOD8SiV4w1FitmMR9Oo0QFqr
         +9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=aj427EoyOIOpXGm7xFat3kqE/v++sDMs91pMGtHoDng=;
        b=fE8M8ryubntPRK+uqhFhHm/sFIf9jSc/o+bEoGlasZjOEzk7iXcMIfp3sCC3Vi55n1
         1z4vIbchP9vSGZtEek0H2NcgBth58dLh2OJYOHOQWi6zrNjEj6Vt36HLAzf1znqeA/hQ
         lkO+P5sGOw08Ni1tIa6gaH1g1oRyrZvTBQL2nwIecXityjGLALaifQTVOVjrhGFFGlAj
         AE+GN3qnV+IOnNw0OPYkfFn+t2IWVbUTy3UUZw5aAzTsb2ITAcEo2FmRr5gcdUsiXKdL
         sY8Au4165+kH1qq2mr7S2CyxJLf0fOQ46HUIf0bMTXHoLv3CwLHvqJcGrWi8xF75yyat
         SPyA==
X-Gm-Message-State: ACrzQf2qHl2CNyfMs8vetIixbwBumf8PyTjzfc5kG3EyXocl9v3o87oL
        ueEQqYMU2GrSZBYLY/P16UgcPvksrVQzqg==
X-Google-Smtp-Source: AMsMyM66wPHtkFQ9IeC/C8z8JolIyiwSxGByINDT3QSo+pKmW5TeLs+OL/+8aAXBzDYx8annuJPNzA==
X-Received: by 2002:a05:6602:2d44:b0:6a1:b558:272d with SMTP id d4-20020a0566022d4400b006a1b558272dmr4127633iow.7.1663946572978;
        Fri, 23 Sep 2022 08:22:52 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x3-20020a056602160300b006a19872663bsm3575750iow.53.2022.09.23.08.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 08:22:52 -0700 (PDT)
Message-ID: <11a6e8c4-690c-d1bc-70fd-8dd33825fadf@kernel.dk>
Date:   Fri, 23 Sep 2022 09:22:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCHSET 0/5] Enable alloc caching and batched freeing for
 passthrough
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20220922182805.96173-1-axboe@kernel.dk>
 <Yy3NyACongSfayY+@infradead.org>
 <6f7600be-d4b9-aeac-7dd1-71992a4dd5e8@kernel.dk>
 <Yy3PEjD2pkSq84RW@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yy3PEjD2pkSq84RW@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/23/22 9:21 AM, Christoph Hellwig wrote:
> On Fri, Sep 23, 2022 at 09:19:15AM -0600, Jens Axboe wrote:
>> On 9/23/22 9:16 AM, Christoph Hellwig wrote:
>>> On Thu, Sep 22, 2022 at 12:28:00PM -0600, Jens Axboe wrote:
>>>> This is good for a 10% improvement for passthrough performance. For
>>>> a non-drive limited test case, passthrough IO is now more efficient
>>>> than the regular bdev O_DIRECT path.
>>>
>>> How so?  If it ends up faster we are doing something wrong in the
>>> normal path as there should be no fundamental difference in the work
>>> that is being done.
>>
>> There's no fundamental difference, but the bdev path is more involved
>> than the simple passthrough path.
> 
> Well, I guess that means there is some more fat we need to trim
> then..

Yes and no, there's always more fat to trim. But some of it is
inevitable, so...

-- 
Jens Axboe


