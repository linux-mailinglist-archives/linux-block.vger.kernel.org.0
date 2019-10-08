Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7023CF125
	for <lists+linux-block@lfdr.de>; Tue,  8 Oct 2019 05:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfJHDQQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 7 Oct 2019 23:16:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37343 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbfJHDQQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Oct 2019 23:16:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id y5so9948785pfo.4
        for <linux-block@vger.kernel.org>; Mon, 07 Oct 2019 20:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=poSeUmgsFcrtpobHMzRXdKMeRSGiKvfSXp6vT7FntzM=;
        b=EC8MmHG9FC6YdTgUY8O+2sWYnZ3kCo7s/m9v/l6q117ZinMXs8MDYsdyyOyBdSpqn7
         3pKah4hWrMigWpyKw96dKQKk9jcBZ6rTForIQjYmrodIeQhx0xUp6YmeNWoiMNeh8fj6
         aXSwXoM4+WcrzwrI/3QLatcAHwjfpY5coBnY6gTMzMeN8mC0iMhxoc6asdx680n9QBnj
         kQhwMNTb1OBsGLuR6/vdYhq2dZUudsVptvY5wHZN2DNVaSc0qMAhn4mW+ZQE+g01KaDM
         rLCOszqBWsXJzfVG5RCPEBJmYVpmkEO2BPiC0Arx5eeSgNjwomJoa+pAqSqox/L4XS5Z
         Gstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=poSeUmgsFcrtpobHMzRXdKMeRSGiKvfSXp6vT7FntzM=;
        b=TlW9GicePyzDRVYmXRUJVlBc1uN4DPdfFt9d4nIwM506K+E5vokG9laO45bGFo+7IX
         liJChHXrk/fGYOm1K2U6KnlseEPm46rHm7vufnGfX4/PQTFGLSOoZJ9ejjK/TnuimUqY
         JUKg+3xiaqplGGR9E1kdbc7AJDuh2HKCLR3cPCfX/gS+Ze8Z5sQL42oiQ9RAbU25g1kx
         2EMCvJNmc778u+Euk9BewUVTUkFi+KuOB/ZxROPhaMkOvDAZ1cYwP2YYx6SJAYSyXEtb
         DwTGKAgoygOT30XKhXmZ+SpasjYQrxRirpmTZvnDwdumJCN8RAU8Y7Q2hHSbJmyfl25a
         ikyQ==
X-Gm-Message-State: APjAAAVRyF8JhAUixiLwJbRIyFulRnkGc+nARk6U+lVBeDJEzTFJxDBc
        k1NtFm0oBhD8rKljpRSpmcNwlsw3i11Mng==
X-Google-Smtp-Source: APXvYqxI/PH0k5yN2ZewrIuX/p/y+QoJg1zBhrX+rYKTptAO/sK5tV4g7b/X5hI5cgPiijAdtrD4ww==
X-Received: by 2002:a17:90a:5d0f:: with SMTP id s15mr2965996pji.126.1570504575619;
        Mon, 07 Oct 2019 20:16:15 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id l62sm20530031pfl.167.2019.10.07.20.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 20:16:14 -0700 (PDT)
Subject: Re: [PATCH] io_uring: remove wait loop spurious wakeups
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e11a0716-eb18-4ce3-9902-3247beafe65a@kernel.dk>
Date:   Mon, 7 Oct 2019 21:16:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <936cd758d6c694fe1b8b9de050e24cfecdc2e60d.1570489620.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/19 5:18 PM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> Any changes interesting to tasks waiting in io_cqring_wait() are
> commited with io_cqring_ev_posted(). However, io_ring_drop_ctx_refs()
> also tries to do that but with no reason, that means spurious wakeups
> every io_free_req() and io_uring_enter().
> 
> Just use percpu_ref_put() instead.

Looks good, this is a leftover from when the ctx teardown used
the waitqueue as well.

-- 
Jens Axboe

