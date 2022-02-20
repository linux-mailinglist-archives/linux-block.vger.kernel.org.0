Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E484BCC33
	for <lists+linux-block@lfdr.de>; Sun, 20 Feb 2022 05:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiBTEwO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 19 Feb 2022 23:52:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiBTEwN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Feb 2022 23:52:13 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F464FDF
        for <linux-block@vger.kernel.org>; Sat, 19 Feb 2022 20:51:51 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso12255416pjg.0
        for <linux-block@vger.kernel.org>; Sat, 19 Feb 2022 20:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=8aktvyxTQfTz4T7zUl9YR5ZozBlNK0rAs4FgR7Rn+Hk=;
        b=G5Dl3oXw5N7CxSFPuvPT550hpUL85OVJ5Hx/Mw+2zEIsyjsO7JYsVNKl8ydNUOLkff
         9y4mT00lWJUrKUe5nTcSoUo5vLsMsHEHImCS0O7l8QduwEJ5pEP44TIRFBZ6vJfAsEYu
         HrfosRAZknQ5Jj1I9cZF+g4hb/v61tjA4+2JfVPDPwdLhmqFdQUlEWy/9eMFiFywwJiu
         nSJ81e2tK1crRfwrXqaM0SSLw7QpU1CvtQ8USx1njTi8TqC0GvRk8XlQkZcEkyp3FqqF
         gG/i5PL/zQSmPqxDFXXPq5QAPt6LcT6i/BJnpfY98qoLF3xaQcYR3c8iYg856onyTLkz
         6UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=8aktvyxTQfTz4T7zUl9YR5ZozBlNK0rAs4FgR7Rn+Hk=;
        b=AT37JQSUHLc5zmfCnhYZ/C3vpkHX80Nxwvhm08MviLhVg/o7L2Rk7prUw7EQgrOrf/
         NwK0rLZ5LY74OGYuig8es8SYDNNaTvX19yEZIkFFKhX+pM6baY5Eb3U+JeZRturXBUeZ
         1woamqCVER708xuB8Cj8RqJ5V9tyHAbZNhseneMYj63Jx+UXQMMsJiocETnfus0BPJsl
         i0HFrEnEhLz0DLFlWRf//cgXL6glko5Q7N2IpFnA8SJxwyEAg1/BUfbqrb18hTZeFjPF
         4DQZfeMPw67gzsKSQCXlYhcHTC1HVGqvkfSxK2ulNjUzUUVsaO6/NWsdtjdgt+fKJ428
         lF2A==
X-Gm-Message-State: AOAM531h7vrO7EYTQmWlr2I6V6CTBsVLVmYqtuhkIZFzjV1ijBuaITPB
        Qzz/7A/rb6SMoWBzl7uczHo0ag==
X-Google-Smtp-Source: ABdhPJzFTJBv82Y7i+9gRClL8+UG/fJQNgYFunbOQVJPAG6tktW5XWf1iy8xJxxLnBlYI1WhORHpUg==
X-Received: by 2002:a17:90a:d243:b0:1b9:e73b:5c07 with SMTP id o3-20020a17090ad24300b001b9e73b5c07mr15492240pjw.198.1645332710829;
        Sat, 19 Feb 2022 20:51:50 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r72sm4679701pgr.80.2022.02.19.20.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 20:51:50 -0800 (PST)
Message-ID: <ef90c7c0-7b5a-2c73-ca1c-5188646d4310@kernel.dk>
Date:   Sat, 19 Feb 2022 21:51:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2 04/13] fs: split off __alloc_page_buffers function
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Stefan Roesch <shr@fb.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
References: <20220218195739.585044-1-shr@fb.com>
 <20220218195739.585044-5-shr@fb.com> <YhCdruAyTmLyVp8z@infradead.org>
 <YhHCVnTYNPrtbu08@casper.infradead.org>
 <7b2b2a34-601a-e62e-3e89-e19954dc965c@kernel.dk>
In-Reply-To: <7b2b2a34-601a-e62e-3e89-e19954dc965c@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/19/22 9:38 PM, Jens Axboe wrote:
> On 2/19/22 9:23 PM, Matthew Wilcox wrote:
>> On Fri, Feb 18, 2022 at 11:35:10PM -0800, Christoph Hellwig wrote:
>>> Err, hell no.  Please do not add any new functionality to the legacy
>>> buffer head code.  If you want new features do that on the
>>> non-bufferhead iomap code path only please.
>>
>> I think "first convert the block device code from buffer_heads to
>> iomap" might be a bit much of a prerequisite.  I think running ext4 on
>> top of a
> 
> Yes, that's exactly what Christoph was trying to say, but failing to
> state in an appropriate manner. And we did actually discuss that, I'm
> not against doing something like that.

Just to be clear, I do agree with you that it's an unfair ask for this
change. And as you mentioned, ext4 would require the buffer_head code
to be touched anyway, just layering on top of the necessary changes
for the bdev code.

-- 
Jens Axboe

