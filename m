Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4189636DC56
	for <lists+linux-block@lfdr.de>; Wed, 28 Apr 2021 17:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbhD1Pt6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Apr 2021 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbhD1Ptk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Apr 2021 11:49:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEBCC061574
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 08:48:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id q2so12066351pfk.9
        for <linux-block@vger.kernel.org>; Wed, 28 Apr 2021 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tORliflyGiTlxpgw1Xju92EFVYS+y5dZFyWLyquG+EM=;
        b=PAlsmS21gCUe34ubxq/kYTGGg8YPYXdQ1HUnOaCiH+axMpr6gi+sk+JGiXGVtJdrGT
         JnMijmrnJipN2jKTSMhLdsfhZ0JnkgnBuicN7UrCK1F+s2czuifgdyuQM1C74qZum1uG
         XXWYqTg4yn5lg9wCujgMoU2YreLpiV+QzhyOxsxEhMZyPjIF3gE/7qtmpzGz49gXmmtl
         6bGT553GXKyP7oqUMQEJTOMEFoVjcMntQtYP2dBujyfw550Df2b1xvfzbRAf31wZoBNM
         S3HLP3bJgy6QE0eHN1KiPdwz24VWsm0mO0pv2d0k54J5GqbQvKhHh6gd+Gp4l3xtnd72
         zzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tORliflyGiTlxpgw1Xju92EFVYS+y5dZFyWLyquG+EM=;
        b=TargItzv/Jl1TrNUeIyFbPntuose4BtQ/2SJ8q0kequ6sYPTP/yPkpH8okfJz6+0BC
         vVMKKh6YuNyqozGU5wIbBlw8OHeDxNVwnOyW55LHdrrhhaBvlKmwyD3w70f8LotTvaQ0
         bB0wN7JJq9dgITWL6SbVUGpJhPouKd0rQ7ynRHVVZ1/tLq9cJcudFW/MEkuSSVkaS7XC
         PCj33XDUeTT9b8e2kJs8Vri5kjRujbvoxZIEmoq9c6byIKm1PXgTJq7FHayxQHXWhqsl
         P38RQ52ZUm7AZ7QAeZ2MZfY80oMoRBIXIeoBQpFnSsvbJRju+j5fKdTqFieW6byebX9q
         80ww==
X-Gm-Message-State: AOAM531/Cu+o19gEjLns7GPL0w62EnHoUNitGOUbXXGD3mMg1L2fHFpT
        A5kE/CcRqY/ZI7b+tkqe7Vvn9A==
X-Google-Smtp-Source: ABdhPJzEJ4Y/U6MqAkTlFXMn+B7exGAdQyHi3xVmOJ3pNV+7kxqLyP+Upr/X5mcNM4PQ/tfoWuShZQ==
X-Received: by 2002:a63:b515:: with SMTP id y21mr28034069pge.253.1619624932865;
        Wed, 28 Apr 2021 08:48:52 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t19sm113326pgv.75.2021.04.28.08.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 08:48:52 -0700 (PDT)
Subject: Re: [PATCH 0/1] spelling fixes
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
References: <20210428153521.2050899-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b11397f8-b1d2-f525-e6ac-de9826bd0c63@kernel.dk>
Date:   Wed, 28 Apr 2021 09:48:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210428153521.2050899-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/21 9:35 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patch that fixes the spelling of some comments.
> Thanks!

Applied, thanks.

-- 
Jens Axboe

