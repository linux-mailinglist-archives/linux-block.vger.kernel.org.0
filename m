Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7D544387E
	for <lists+linux-block@lfdr.de>; Tue,  2 Nov 2021 23:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhKBWgS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Nov 2021 18:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhKBWgR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 18:36:17 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0BDC06120A
        for <linux-block@vger.kernel.org>; Tue,  2 Nov 2021 15:33:42 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i12so584211ila.12
        for <linux-block@vger.kernel.org>; Tue, 02 Nov 2021 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XScYOlOeUciU4dBSUquEeTulM7j610reAXR2BVP/Na8=;
        b=tZwhFYjzuf+Soya8upKb4a0hV8W5rHBj5kxsRmtqEvDwWKhowXAPRSThRGbjAa6LIP
         R7Ur8ZOzURdaLzRwXP0HIa4lJGGLnoy/EuOjVRNZo1Wzh6t+ZLfqb4MWxj42iLz+QKCJ
         mEyOtl2CgdfK/zgAUW/Y2fHfoK6rjmKpELGcv2ASM02UJ5wE1WViclLT+mlawVkIy3XK
         YQ3gXZwRONJeH1hu1sdz4jmf+kIT45+d810NVdo09WCh8ca9ALQho33MszSuQkhlImwi
         uP5IweaAEZ8d8lIP7EjRTzlM9ndLYmJ+KcllkSJ2xYA5xy5v7yPKdsWQt+4ltBTAqcQf
         6vYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XScYOlOeUciU4dBSUquEeTulM7j610reAXR2BVP/Na8=;
        b=lEovcK5VdoPeoymMlMz9pyAx/pT1OSpqzymaagddfc529WnpGp5/xkmoEJ58IXk0yO
         6MMam5wTnio0b4yuWcKEViy3pIjvfZSYFWwEOo7VtDK0AMn9PuzbNV776EHczrTsdJ5A
         9g7zL9IC4rpUYJ71fVRN4JRfKLWpqd/dPlLtwU0sC0hhN3lSsdx1Gyv205qzGhittXuC
         dLnS4WBV6lxiJ/oM4+1eGQlQCNF0Gl5h7fP1ACY+6IyjJDzCpQ6BxSla+IfwT3QWyxZw
         N4IoWfw3zGZ2oiuIxc+42TS9FePQbqR8MiWNTf+W/5QIYOGTQhRhKE+Em5SCeMlUoOHO
         XR9Q==
X-Gm-Message-State: AOAM530BC64AueMAPTPHtwRhOH+QvR14Ljd/ALbzto6jPlspNqVrcPXb
        Qp5iY6jBjPbseqJdxd05CruuIfVHrQ4ycg==
X-Google-Smtp-Source: ABdhPJwmdmn7BUut9FocXY4DaKEL3oAyH/YYP9V0Rug8aghpEKVPHOz+mngGvUeoBGNY/RJtAmFk8g==
X-Received: by 2002:a05:6e02:1c2a:: with SMTP id m10mr6275229ilh.275.1635892421594;
        Tue, 02 Nov 2021 15:33:41 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id t14sm245628ilu.63.2021.11.02.15.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 15:33:41 -0700 (PDT)
Subject: Re: [PATCH 03/21] block: Add bio_for_each_folio_all()
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20211101203929.954622-1-willy@infradead.org>
 <20211101203929.954622-4-willy@infradead.org>
 <YYDlEmcpkTrph5HI@infradead.org> <YYGebqvswvJBdxuc@casper.infradead.org>
 <20211102222455.GI24307@magnolia>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ce6fb05-fe8d-6e4c-364a-0e2c9e8ee4ed@kernel.dk>
Date:   Tue, 2 Nov 2021 16:33:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211102222455.GI24307@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/21 4:24 PM, Darrick J. Wong wrote:
> On Tue, Nov 02, 2021 at 08:24:14PM +0000, Matthew Wilcox wrote:
>> On Tue, Nov 02, 2021 at 12:13:22AM -0700, Christoph Hellwig wrote:
>>> On Mon, Nov 01, 2021 at 08:39:11PM +0000, Matthew Wilcox (Oracle) wrote:
>>>> +static inline
>>>> +void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
>>>
>>> Please fix the weird prototype formatting here.
>>
>> I dunno, it looks weirder this way:
>>
>> -static inline
>> -void bio_first_folio(struct folio_iter *fi, struct bio *bio, int i)
>> +static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
>> +               int i)
>>
>> Anyway, I've made that change, but I still prefer it the way I had it.
> 
> I /think/ Christoph meant:
> 
> static inline void
> bio_first_folio(...)
> 
> Though the form that you've changed it to is also fine.

I won't speak for Christoph, but basically everything else in block
follows the:

static inline void bio_first_folio(struct folio_iter *fi, struct bio *bio,
                                   int i)
{
}

format, and this one should as well.

-- 
Jens Axboe

