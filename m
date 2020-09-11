Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFA2266847
	for <lists+linux-block@lfdr.de>; Fri, 11 Sep 2020 20:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgIKSev (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Sep 2020 14:34:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45592 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgIKSes (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 14:34:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id 67so7225465pgd.12
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2020 11:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Uu5tIP1oLvFbOHEfS2a+Mm367EAxag99Qk3ziYJ4aQ=;
        b=fGFRToLS7ehwE2OEuyLuX7opTW3KOLiwzwIGbXCPNrfXVT1EYHdgTco0e+B3YkOV85
         UzIEIq5miU/zmiNZVN5N5qFv4i8B0TEijvkdtTGkFQnRy/iR9XmbBvQfte7iMjLA0Exu
         u45a2vDQ/KEmdBrehoSuH8bsHjgFo6TjMOR+QDE/F1cH1fVhCHfPFMFH1Ky6PzGHQQVB
         WbqJDqURF4DWleVwaIdHMRO3ZRImwORUSf1L6FJlEBtVIOHohUJsxJmSVsbiOWTQxVik
         U4O3mAzLig6CrXDUonGBl73ilwz+lkdEOKWdI1yfI2yOmdqEJst3XrP/SM9D9tSl21vB
         Diag==
X-Gm-Message-State: AOAM53023VqSe/Y1JQkS8CaSt/pMdKuGayMnxN0Debrg4W3uSTpVx/IO
        TEvGWPJnYKWO43oMAOyaub4=
X-Google-Smtp-Source: ABdhPJyXzn6p2rpLBz0aKKu0U05TK8yAUs0t8q7iU1ffy3xPEE67hIY/pPfOK2Z5X35ghzlq85sEJg==
X-Received: by 2002:a63:4c1b:: with SMTP id z27mr2595260pga.69.1599849287399;
        Fri, 11 Sep 2020 11:34:47 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4428:73d8:a159:7fcc? ([2601:647:4802:9070:4428:73d8:a159:7fcc])
        by smtp.gmail.com with ESMTPSA id 203sm2919525pfz.131.2020.09.11.11.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 11:34:46 -0700 (PDT)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chao Leng <lengchao@huawei.com>
References: <20200911024117.62480-1-ming.lei@redhat.com>
 <4fb604fd-c081-5eb1-cb3a-860746b6952a@grimberg.me>
Message-ID: <09d5cb96-b442-6965-96b3-d884c95a3ca7@grimberg.me>
Date:   Fri, 11 Sep 2020 11:34:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4fb604fd-c081-5eb1-cb3a-860746b6952a@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Hi Jens,
>>
>> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
>> and prepares for replacing srcu with percpu_ref.
>>
>> The 2nd patch replaces srcu with percpu_ref.
>>
>> The 3rd patch adds tagset quiesce interface.
>>
>> The 4th patch applies tagset quiesce interface for NVMe subsystem.
> 
> Tested some reset storms and target restarts during traffic with
> nvme-tcp.
> 
> Seems that no apparent breakage.
> 
> So:
> 
> Tested-by: Sagi Grimberg <sagi@grimberg.me>

Probably unrelated to this patches, but I do see new
kmemleak complaints in the form of:
--
unreferenced object 0xffff9440dbf3c240 (size 64):
   comm "systemd", pid 1, jiffies 4306444056 (age 25034.440s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 b0 fe 13 99 ff ff ff ff  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000f1d0b20e>] percpu_ref_init+0x5f/0xf0
     [<000000009598103f>] cgroup_mkdir+0xe9/0x440
     [<0000000001b93c19>] kernfs_iop_mkdir+0x57/0x80
     [<000000001ed0f985>] vfs_mkdir+0x10e/0x1d0
     [<00000000cac65f7e>] do_mkdirat+0xec/0x120
     [<00000000956db630>] do_syscall_64+0x33/0x80
     [<000000001c2b0e1a>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
--
