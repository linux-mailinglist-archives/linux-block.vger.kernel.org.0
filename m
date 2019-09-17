Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09E0BB50CA
	for <lists+linux-block@lfdr.de>; Tue, 17 Sep 2019 16:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfIQOyn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Sep 2019 10:54:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36023 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbfIQOym (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Sep 2019 10:54:42 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so8345084iof.3
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2019 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jv1nPKgN541dTWmjgoEE9NwVDDUkzt0DXYH4qos1wVs=;
        b=v73eJh3uUNV4peUeNoFa4mDDYOe2IZXEjgBJUoCBGCgjBsgIbfu05XFsHgQB4KrUnl
         ClzCo2YW4NeUFULmoP+thvo1Wh3h6uMan9rX16hOOXijvSbeZTx2R0kjT6O0EvHiXbpf
         XTwdV2DJLAx+VpLQdtD53wXRBUHbudINTHxFOu02+NCkvsewyLc2A6QO+mkgFHf8zRYx
         bN/Douii1AgojQ7PmLM1ahi+WlMu7Saw5N1gHzGEp4HVPtwEfVDY+qUSKMM7nb1fUO+2
         VX7hYAA4262TK03HNT+jOQKkkEqF1Fyr9Z3QKj7Jbsy2N5sKu5YZh9cAWVfIBVM0NYIM
         tTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jv1nPKgN541dTWmjgoEE9NwVDDUkzt0DXYH4qos1wVs=;
        b=t2rraUO7OkQtJzpnTwNwyHSLGQvN/SCEMNcpeYpefDEfDyx2k620aZvTsm7EZV+QMt
         b7zSPEd61eRNC8V2oMg2wzKavtJ4MbKKIdeMTD9F7FGTC1XRZBo8eSeNM68EaJDu3dEb
         iCpUsiXcbhwwQuB4ObCfvj0LZcMSOEv9L650CVDTXxm7vsxj22Wuft9TCfTU1b8ebOpC
         NmgmJbOabn+e00e4HTrMybIVVMlwVbnUx4oW5g2mjgQ2/65qUVCzv+pjDVb0y5HGOUTB
         t1h9Ow+XV1xqpkjpxPpn4fu1CajcTES51LxpJLIkEGmI18nMXdVaeX581Na3x0ozhqxD
         XfBQ==
X-Gm-Message-State: APjAAAVB9GXMogASe1g66SW1RyMP4Hp5S95ilLqe+htEqphiP7/bOiVu
        C3c38kUOyhwfIXAr/X/jX1McSkmTkj22OA==
X-Google-Smtp-Source: APXvYqxFi2HNJ4XA/+AhE/mtwc9nQdyUwXe1Y7l8AvgBzKOcStcSiE5SoaZGNyRREh/Shnzi0iMwtw==
X-Received: by 2002:a02:1c02:: with SMTP id c2mr4710119jac.118.1568732081291;
        Tue, 17 Sep 2019 07:54:41 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u24sm1868664iob.12.2019.09.17.07.54.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 07:54:39 -0700 (PDT)
Subject: Re: [PATCH v1] io_uring: reserve word at cqring tail+4 for the user
To:     Avi Kivity <avi@scylladb.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20190917091358.3652-1-avi@scylladb.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3e886e3a-458d-0fe4-68ff-5925835efb5e@kernel.dk>
Date:   Tue, 17 Sep 2019 08:54:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917091358.3652-1-avi@scylladb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/17/19 3:13 AM, Avi Kivity wrote:
> In some applications, a thread waits for I/O events generated by
> the kernel, and also events generated by other threads in the same
> application. Typically events from other threads are passed using
> in-memory queues that are not known to the kernel. As long as the
> threads is active, it polls for both kernel completions and
> inter-thread completions; when it is idle, it tells the other threads
> to use an I/O event to wait it up (e.g. an eventfd or a pipe) and
> then enters the kernel, waiting for such an event or an ordinary
> I/O completion.
> 
> When such a thread goes idle, it typically spins for a while to
> avoid the kernel entry/exit cost in case an event is forthcoming
> shortly. While it spins it polls both I/O completions and
> inter-thread queues.
> 
> The x86 instruction pair UMONITOR/UMWAIT allows waiting for a cache
> line to be written to. This can be used with io_uring to wait for a
> wakeup without spinning (and wasting power and slowing down the other
> hyperthread). Other threads can also wake up the waiter by doing a
> safe write to the tail word (which triggers the wakeup), but safe
> writes are slow as they require an atomic instruction. To speed up
> those wakeups, reserve a word after the tail for user writes.
> 
> A thread consuming an io_uring completion queue can then use the
> following sequences:
> 
>    - while busy:
>      - pick up work from the completion queue and from other threads,
>        and process it
> 
>    - while idle:
>      - use UMONITOR/UMWAIT to wait on completions and notifications
>        from other threads for a short period
>      - if no work is picked up, let other threads know you will need
>        a kernel wakeup, and use io_uring_enter to wait indefinitely

This is cool, I like it. A few comments:

> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index cfb48bd088e1..4bd7905cee1d 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -77,12 +77,13 @@
>   
>   #define IORING_MAX_ENTRIES	4096
>   #define IORING_MAX_FIXED_FILES	1024
>   
>   struct io_uring {
> -	u32 head ____cacheline_aligned_in_smp;
> -	u32 tail ____cacheline_aligned_in_smp;
> +	u32 head ____cacheline_aligned;
> +	u32 tail ____cacheline_aligned;
> +	u32 reserved_for_user; // for cq ring and UMONITOR/UMWAIT (or similar) wakeups
>   };

Since we have that full cacheline, maybe name this one a bit more
appropriately as we can add others if we need it. Not a big deal.
But definitely use /* */ style comments :-)

> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 1e1652f25cc1..1a6a826a66f3 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -103,10 +103,14 @@ struct io_sqring_offsets {
>    */
>   #define IORING_SQ_NEED_WAKEUP	(1U << 0) /* needs io_uring_enter wakeup */
>   
>   struct io_cqring_offsets {
>   	__u32 head;
> +	// tail is guaranteed to be aligned on a cache line, and to have the
> +	// following __u32 free for user use. This allows using e.g.
> +	// UMONITOR/UMWAIT to wait on both writes to head and writes from
> +	// other threads to the following word.
>   	__u32 tail;
>   	__u32 ring_mask;
>   	__u32 ring_entries;
>   	__u32 overflow;
>   	__u32 cqes;

Ditto on the comments here.

Would be ideal if we could pair this with an example for liburing, a basic
test case would be fine. Something that shows how to use it, and verifies
that it works.

Also, this patch is against master, it should be against for-5.4/io_iuring as
it won't apply there right now.

-- 
Jens Axboe

