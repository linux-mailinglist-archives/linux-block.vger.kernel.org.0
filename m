Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2DFFF0A69
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2019 00:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfKEXsK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 5 Nov 2019 18:48:10 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38333 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfKEXsJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Nov 2019 18:48:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id c13so17318419pfp.5
        for <linux-block@vger.kernel.org>; Tue, 05 Nov 2019 15:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=05dRAMF1Vz+FeHeAryqq0JNAWj1xNIZkNNmr4b7Ijcc=;
        b=pjwu2L2FqwbVncAYOc13kacX1Wxo19uCEBZf8Pdn6fDX0d3yQJxlH/Vd3/l9OUMTkw
         u8Hl+o6BAL2H0s/1O3Gy90bEDALTOWPzNhdYTc/GkGVz+dKZNngUg906iAIeMXa3mR9N
         O+0RCIxPNOZ1MpsB0Aj0sH7l0soIS9FcjDK5ik97ZVMXjncrr/0IQ9sHl2b4iRU2iFXP
         61lBECtPF8TjuqLh51OZO8dh1/I4EWiiyhNqA6j42DCjDT51uxKRDujS4o3X9SD2ww+8
         ibggvlQJlioiXf7IWG88BIjk8VOCoPklbbjjuBTLpGhth++gA6B9CqIzeP8sVmmuzkGN
         NmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=05dRAMF1Vz+FeHeAryqq0JNAWj1xNIZkNNmr4b7Ijcc=;
        b=EvNY5+b1FivlmHaG2iQsFikKP0HI94iFMEmv1opLSoi9xswWEiquTRGOtQ07i1hh55
         XFK/6m8Mk8U+Qo6mm+SYaC1L5MsAydtLinLxT0kTH0UGmTlq71DtucV4oKLOUjyH6Tjs
         F/k8LFvb4NmLjIw7uXyWKJlNzrcmBkorPva4hbEMUmKtyrbD2uBtYwOU78R2kk70wVDo
         5LHR43xemXZFAMHuAPTWfFd94p4VejMxBBWx+v5ArftBcCEhwusrymvH8FJzPotE6Igr
         Etv2qinTZRr6SDjaAGPcN2F+LSQ5rUpkSy10xSRzWeDDygXvCynE51LDEGC8bnl3QcCd
         dwUA==
X-Gm-Message-State: APjAAAUPgiKkE0TamjPu4XhPL0A7nwtMWZTNdzQbcY5+FH85LLIUTezg
        oK3ara5Q6XTzq3fxPDNIB55yYMZS7Nc=
X-Google-Smtp-Source: APXvYqxIAfVX/SJs7cWhzrGFsFJ3v+s04NG9ZykHj1uKqqUrpDgGycujmu/RnMdSbp1PN21unVtHlw==
X-Received: by 2002:a63:ff46:: with SMTP id s6mr39577289pgk.337.1572997688645;
        Tue, 05 Nov 2019 15:48:08 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id a6sm541194pja.30.2019.11.05.15.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:48:07 -0800 (PST)
Subject: Re: [RFC 0/3] Inline sqe_submit
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1572993994.git.asml.silence@gmail.com>
 <a0393f05-dff2-6c34-4ba1-f6dba67955d2@kernel.dk>
 <1cc9dc92-3468-a780-e8ca-cb0f559a053f@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c50819c1-9a0a-1f48-2a93-14f3a10bb819@kernel.dk>
Date:   Tue, 5 Nov 2019 16:48:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1cc9dc92-3468-a780-e8ca-cb0f559a053f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/5/19 4:45 PM, Pavel Begunkov wrote:
> On 06/11/2019 02:37, Jens Axboe wrote:
>> On 11/5/19 4:04 PM, Pavel Begunkov wrote:
>>> The proposal is to not pass struct sqe_submit as a separate entity,
>>> but always use req->submit instead, so there will be less stuff to
>>> care about. The reasoning begind is code simplification.
>>>
>>> Also, I've got steady +1% throughput improvement for nop tests.
>>> Though, it's highly system-dependent, and I wouldn't count on it.
>>>
>>> P.S. I'll double check the patches, if the idea is accepted.
>>
>> I like the idea (a lot), makes the whole thing easier to follow as well.
> 
> Great, than I'll prepare the patches properly and resend it

Perfect - doesn't look like it'll conflict with the submission path
cleanup (which also looks good), but if it does, just collate them into
a single series.

-- 
Jens Axboe

