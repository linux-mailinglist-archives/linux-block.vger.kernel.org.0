Return-Path: <linux-block+bounces-648-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AEE801D92
	for <lists+linux-block@lfdr.de>; Sat,  2 Dec 2023 16:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D3E1F211A4
	for <lists+linux-block@lfdr.de>; Sat,  2 Dec 2023 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B26199D1;
	Sat,  2 Dec 2023 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm5lcZhT"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EBAFD;
	Sat,  2 Dec 2023 07:50:35 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2e1a72fcca58-6cdfb721824so1339924b3a.3;
        Sat, 02 Dec 2023 07:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701532235; x=1702137035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd5HOuEegKoTJGiz25FDlEzvosdY/OfidE22UbIBrzQ=;
        b=Fm5lcZhTdsoVQApZyhfZwDtR3gciTdMbEJuOB4iL0e4iAuyXdwC5hQGoGruwQcMIb0
         Hl/+BAsws9gdG0XGZ9bJCndjXppu1raCT3k1nNIUxr7+mKs17d3O1IhNHoeImOH7/Fgz
         E1mIWp0G5Bstru+LhtXYv1rfeN8fr91kv2NwOYofYBMave9YIdPwbiBfDgBtYIZmDRUu
         +P2uGXSmJ7BtbdfMntC0v2cqqrNKjcf/N8OOS0w+M4SbdjQ3tFwMV98wgZim/JiRtZqS
         Ghv4qPhGoG9yZHnNU39Z39xM/BrICHCtywucTwK1kxA6/PLciHAFXM31HqhNKsHqlkP1
         Y6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701532235; x=1702137035;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fd5HOuEegKoTJGiz25FDlEzvosdY/OfidE22UbIBrzQ=;
        b=mm6zDVVqKYcBFF7DMjZCOc2YB7ybCOBcu3PM/xM99WEp9O/+RfOsAtTw/JusPrhZG+
         FbdlZA/eYizZvTy5+Wzgpo9fRHdbCfKgyb/j8XlHuUyQYLMmtJXHFh5IuWfkMkcT8T4u
         6XvDbOdRPQu26nqiAJY35ETIEBB4slewe5fhi+bi7/YzLxAhtslc8qlvR1gMhYtteQ5p
         f4E9sAv5Y0Vj4FZCdGftGOEVtACSl3V6w7cYaOoxae+siEM+zrB13Kx8drlHdsvq29W7
         wEZGVRLoLJl09OFON4cFzZ1BhY7STWR3WBQr7PQQ28J6ph9XbMUZ0CP0OARWeJ61SDYM
         0ODg==
X-Gm-Message-State: AOJu0Ywo4gkS6+2tPjl5KkTJj6aG3VngBjVc9bEkI7G5NW4q+U3ZSOj6
	ax0IPnjAZPQ6bOd2qJYZwM0=
X-Google-Smtp-Source: AGHT+IFca1WmCGAfcW1bSAACpzBFXnNuSg9Klfi0NOCvHOUB03AUvHSg1kGTOaKuuzymF5BvIl00zg==
X-Received: by 2002:a05:6a00:c8e:b0:6ce:2732:1df9 with SMTP id a14-20020a056a000c8e00b006ce27321df9mr586818pfv.51.1701532235352;
        Sat, 02 Dec 2023 07:50:35 -0800 (PST)
Received: from [10.164.73.138] ([103.136.251.90])
        by smtp.gmail.com with ESMTPSA id z24-20020a62d118000000b0069346777241sm5079977pfg.97.2023.12.02.07.50.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 07:50:35 -0800 (PST)
Message-ID: <b49d6a29-e3a3-4b6b-8892-8ded319b2619@gmail.com>
Date: Sat, 2 Dec 2023 23:50:28 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
 bitmap memory in backing_dev_store
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: minchan@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, lincheng.yang@transsion.com,
 jiajun.ling@transsion.com, ldys2014@foxmail.com,
 Dongyun Liu <dongyun.liu@transsion.com>
References: <20231130152047.200169-1-dongyun.liu@transsion.com>
 <20231201153956.GB404241@google.com>
From: Dongyun Liu <dongyun.liu3@gmail.com>
In-Reply-To: <20231201153956.GB404241@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/1 23:39, Sergey Senozhatsky wrote:
> On (23/11/30 23:20), Dongyun Liu wrote:
>> INFO: task init:331 blocked for more than 120 seconds.  "echo 0 >
>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:init   state:D stack:    0 pid:    1 ppid:     0 flags:0x04000000
>> Call trace:
>>    __switch_to+0x244/0x4e4
>>    __schedule+0x5bc/0xc48
>>    schedule+0x80/0x164
>>    rwsem_down_read_slowpath+0x4fc/0xf9c
>>    __down_read+0x140/0x188
>>    down_read+0x14/0x24
>>    try_wakeup_wbd_thread+0x78/0x1ec [zram]
>>    __zram_bvec_write+0x720/0x878 [zram]
>>    zram_bvec_rw+0xa8/0x234 [zram]
>>    zram_submit_bio+0x16c/0x268 [zram]
>>    submit_bio_noacct+0x128/0x3c8
>>    submit_bio+0x1cc/0x3d0
>>    __swap_writepage+0x5c4/0xd4c
>>    swap_writepage+0x130/0x158
>>    pageout+0x1f4/0x478
>>    shrink_page_list+0x9b4/0x1eb8
>>    shrink_inactive_list+0x2f4/0xaa8
>>    shrink_lruvec+0x184/0x340
>>    shrink_node_memcgs+0x84/0x3a0
>>    shrink_node+0x2c4/0x6c4
>>    shrink_zones+0x16c/0x29c
>>    do_try_to_free_pages+0xe4/0x2b4
>>    try_to_free_pages+0x388/0x7b4
>>    __alloc_pages_direct_reclaim+0x88/0x278
>>    __alloc_pages_slowpath+0x4ec/0xf6c
>>    __alloc_pages_nodemask+0x1f4/0x3dc
>>    kmalloc_order+0x54/0x338
>>    kmalloc_order_trace+0x34/0x1bc
>>    __kmalloc+0x5e8/0x9c0
>>    kvmalloc_node+0xa8/0x264
>>    backing_dev_store+0x1a4/0x818 [zram]
>>    dev_attr_store+0x38/0x8c
>>    sysfs_kf_write+0x64/0xc4
> 
> Hmm, I'm not really following this backtrace. Backing device
> configuration is only possible on un-initialized zram device.
> If it's uninitialized, then why is it being used for swapout
> later in the call stack?

Uh, at this moment, zram has finished initializing and is
working. The backing device is an optional zram-based feature.
I think it can be created later.


