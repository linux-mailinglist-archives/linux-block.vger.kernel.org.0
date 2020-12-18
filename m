Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F632DE673
	for <lists+linux-block@lfdr.de>; Fri, 18 Dec 2020 16:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgLRPXN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 18 Dec 2020 10:23:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgLRPXM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Dec 2020 10:23:12 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C62C0617A7
        for <linux-block@vger.kernel.org>; Fri, 18 Dec 2020 07:22:32 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f17so1512753pge.6
        for <linux-block@vger.kernel.org>; Fri, 18 Dec 2020 07:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=k+GZ8lhGYMGz9WOSaE6qCEI51V/eDBs7Mn8FPRV8MCA=;
        b=DegJUOImW9+z6N+vk2BkJg/TZ2j8yyH1SwV98wkorJNiaawDhyjnlpAQFgyPeJBbVr
         4xY717v8VgGdqgEXX5N9of1TJzNk6L8hMUKTLZsztlPSLwmZjsvVglqweRouzz3eslBG
         p1JemMwlIoA6xYsRhHUNURDtrsprBwg8I07AveqtOxAqpFjjbVr9qc9lWOYwqdTupjDt
         poiql+Sx8x5fxbA+xLK1cROlEh+Gv4DU1kJFbgEsaH51B7jJgzWWEPkxF/Rv5yuQR4O0
         WpnT8m2u+pkD48s+mnk4mBvYhx4EZgqhyIZH9r4OLZI/O1D1rN1b0OPWXRyEx7+gREhQ
         wkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=k+GZ8lhGYMGz9WOSaE6qCEI51V/eDBs7Mn8FPRV8MCA=;
        b=AqoXZupcXYb+h94NZQ5LZOZaYaKdPF6lMK//2ZXkI5JO54TFKWf7tPCWmunbGpzM1p
         GPyHSOruPQfYlmf7EG1/DbHtffqaHSnZjb6fYQOEjZfDclvDFetEED/Ng8wip3nL/ZEW
         vmfLUmOGMES0VB+LNwHdM1MOQ9JrQEK1R9gqt8qVwrvaKAQ0VEBFJIJebCSXH5YfCZSF
         RCyLvd/jygS1VAdgM3UDrefAFkK1lgRpkxUq6LVu9iloDeLKCcZd0IrHR6Pk8D4DAdaR
         ijKroLdvrZS/MMh+/VrK4aspfWU/7R6qSmFeZhvgNkbLpa49NC7hmcG0l/2zanDo0Wqb
         hqhQ==
X-Gm-Message-State: AOAM530pZ3kUb9lMrC3dHW0ykfDc/Bpo0UZxl6vstAgOA6B/as8wlxZc
        zu6449DZNkhYViiF8LVOXJZA2P/87ejBig==
X-Google-Smtp-Source: ABdhPJzi4SjlderGAo9cc4p+7hGiN2CkNTKfQWWlGWEzHqyA/73Rz8PKa7JTgM0Fj4Q/YLBpUyZP1Q==
X-Received: by 2002:a63:d62:: with SMTP id 34mr4636650pgn.276.1608304951773;
        Fri, 18 Dec 2020 07:22:31 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id h4sm10224411pgp.8.2020.12.18.07.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 07:22:30 -0800 (PST)
Subject: Re: "blk-mq: Use llist_head for blk_cpu_done" causing warnings
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1ee4b31b-350e-a9f5-4349-cfb34b89829a@kernel.dk>
 <20201218151824.quxry5bmaqlpohkr@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7da575fc-d750-55c1-473c-66f6ca8825bb@kernel.dk>
Date:   Fri, 18 Dec 2020 08:22:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218151824.quxry5bmaqlpohkr@linutronix.de>
Content-Type: multipart/mixed;
 boundary="------------ABF9A94E4DF20C37357A38C6"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is a multi-part message in MIME format.
--------------ABF9A94E4DF20C37357A38C6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 12/18/20 8:18 AM, Sebastian Andrzej Siewior wrote:
> On 2020-12-18 08:02:59 [-0700], Jens Axboe wrote:
>> Hi Sebastian,
> Hi Jens,
> 
>> I'm running into these when that last patch is applied:
>>
>> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #10!!!
>>
>> on at least my kvm test bed on the laptop. I'm going to revert this
>> series for now.
> 
> Okay. Can you keep #1 from the series?

Sure, we can keep this one. I did verify that only the last part of
that series caused issues.

> Anyway, could you please throw a .config and the test in my inbox so I
> can reproduce it and then I will look at this next year.

Attached. The test is just booting my vm, haven't even started running
anything when it triggers. It also seems to be happening throughout
the vm running, at a pretty low rate though.

-- 
Jens Axboe


--------------ABF9A94E4DF20C37357A38C6
Content-Type: application/gzip;
 name="qemu-config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="qemu-config.gz"

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
G/IP4yU83mREAQA=
--------------ABF9A94E4DF20C37357A38C6--
