Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835AB24D933
	for <lists+linux-block@lfdr.de>; Fri, 21 Aug 2020 17:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHUP7C (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Aug 2020 11:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgHUP7A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Aug 2020 11:59:00 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7590C061573
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 08:58:59 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id k4so1786393ilr.12
        for <linux-block@vger.kernel.org>; Fri, 21 Aug 2020 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lKr2x91cMtcuwusmmtcHUtjJMQVufzAul6lNCKqAqKU=;
        b=m4fbbuBWuBCtIM9x0MSfyDP9xrirHaAzb9yrspv71Z0Xh7TThtwNSyNQXu7RcXoZHd
         /e3ZwwvcPAEZcAZQBOwqGnxGUBMFPZXdDInqY3BXPWZuQr6zKcUcW9B+XSonXsYljvqp
         ylFJBxdIYkE8mqeeDfJAE3FZS1ihDkPhPFLg7J7z5+/kNLDzV3J0f+pNuKK4DHofigYU
         DaVYTg4xETgBANbLc38IpyjQ3306lTUxiI74JHUHB5VNEWUapJPeRgt/SMS1TMoppgeX
         XvNz08dzTP00tlg0Bt8se1JMUgbEynj5O96EuAfUCUSAieQFBGW/Q3+8jl+oEADPbaLU
         cbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=lKr2x91cMtcuwusmmtcHUtjJMQVufzAul6lNCKqAqKU=;
        b=OGz872j5PDI2eQMAH9wKs5urkuBS8UxQhHx5XmcejQeushZ0atAnFV1PY6SEAvR7+3
         RdXUhMMJV2/XWC98UYdpwBoQlgwTZES1pwuM4+zKKWNmguYDEpbKqu2OI1d3tidIvRpf
         4m8b5bJULmNgkib9+QeE5wNccg4BgoNzrYuT9quhGBm3GuqLnh52xwDJ5jE8dJYvr9K2
         IqsJ0GiAe1ZBg7G5Br8d7F5WLTtcNjscisiJTd+g8QMtuY+OJSNNWVWzvrBvbs5qoIAG
         b1xu57ED9cbVM+hkVNUEu7euMB3B48R9rkM6Pe3FAYUBIohm69k/FLim2qLOM1PjDAa6
         h80A==
X-Gm-Message-State: AOAM532hrKW/8RgqyDRLpZwvfNmrqPeaats/WOBc5/FjjhKTOnqvFO41
        g4+/F/H+iXvql3zx2BpWuLVMUiRIitC7SL53
X-Google-Smtp-Source: ABdhPJwxkDRTg9Tdpb9O1saPdAEt9kHKHDqeKq++fAnEYawzRC35tL3lKkMLQ+g2cWCJSPkLrJMmpQ==
X-Received: by 2002:a05:6e02:13b1:: with SMTP id h17mr3215461ilo.259.1598025538629;
        Fri, 21 Aug 2020 08:58:58 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k8sm1478614ilk.11.2020.08.21.08.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 08:58:58 -0700 (PDT)
To:     io-uring <io-uring@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: io_uring and Optane2
Message-ID: <4af91b50-4a9c-8a16-9470-a51430bd7733@kernel.dk>
Date:   Fri, 21 Aug 2020 09:58:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

One of the key elements for eeking out the very last bit of performance
with io_uring is being able to test your design and improvements. I had
a bit of help on that front since Intel got me some Gen2 Optane SSD
samples a while back, and I've been using those to guide improvements -
and vice versa, to see which changes end up being detrimental to
latencies or scalability. I haven't been able to share any numbers on
that until now. So without further ado, here's some insight into what is
possible with io_uring, and the Linux IO stack, today.

Test setup:

Kernel: 5.9.0-rc1
System: Intel Ice Lake-SP Next-Gen Xeon (https://www.servethehome.com/intel-ice-lake-sp-next-gen-xeon-architecture-at-hc32/)
Storage device: Single Gen2 Optane SSD (https://blocksandfiles.com/2020/08/14/intel-gen-2-optane-details/)
Benchmark: t/io_uring from fio
Workload: Single thread random 512b O_DIRECT reads

Note that this is utilizing a single core in the system, out of the many
available. t/io_uring is used for light overhead IO generation, and
we're using polled IO with io_uring, and registered buffers and files.
512b IOs are used to keep us well below the bandwidth ceiling.
Throughput is easy, IOPS and latency are harder. My goal here was to
demonstrate what is possible today with io_uring in terms of efficiency.

Results
-----------------------------------------------------------
QD128 :		2.58M IOPS per core (34.9 usec avg latency)
QD16  :		2.06M IOPS per core ( 6.9 usec avg latency)
QD1   :		 290K IOPS per core ( 3.4 usec avg latency)

Outside of showing what's possible with io_uring today, these results
are also a testament to the general Linux IO stack efficiency. The
introduction of blk-mq was as much about general efficiency as it was
about scalability. That was a design criteria for both blk-mq and
io_uring from day 1. Even if you aren't driving millions of IOPS, or
using tons of threads/cores, you still care about getting your work done
in the shortest amount of time, using the fewest amount of wasted
cycles.

More to come...

-- 
Jens Axboe

