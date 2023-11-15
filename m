Return-Path: <linux-block+bounces-132-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C273A7EA730
	for <lists+linux-block@lfdr.de>; Tue, 14 Nov 2023 00:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90F81C20848
	for <lists+linux-block@lfdr.de>; Mon, 13 Nov 2023 23:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CE83E470;
	Mon, 13 Nov 2023 23:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABF3E461
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 23:57:41 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479519E;
	Mon, 13 Nov 2023 15:57:40 -0800 (PST)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so3998660a12.1;
        Mon, 13 Nov 2023 15:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699919860; x=1700524660;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2O33Z20Hw5m9jWPSsRRvDoAMyIPjKTQaup/hA8pvVwg=;
        b=rQzftL3T3jXjBlwlBEdQwrraDjCYgUR7plDSi6DH5jUJRjUDtvGNIt8au6aR2oZho4
         E5pDrByXLDc0Uj9e8QRSmqmSmtGCfqD1kM5fdHR04QunTjS3zGhQS/Gwozaer+sOnY68
         q7kOIsWSytpcgUr38fGR91P2qn2j5ZfItvKPu19vM8vfU6q6uN4HNWSHJV4HhVVHKXws
         wQlqbdVAuvTIo9dbLdI5uWZjPoBVeiyPNl48BIiYkj/iMXzA6pwXn5/8RamECrwfw1jg
         SQPY4Gc6pCoFT3DfQ/v3XOtqk3X3jr+qqwVbWeDrzh4ORUcqx9fd6iqhF3Yvcy9rfkei
         DbVg==
X-Gm-Message-State: AOJu0YzC2uhvltaviwnhdkM/Q5Zy/ocLiUoOevkgARFDkjntb129AeIh
	I9MtcMFKD2NXXwdptUA2gIw1iGhoW4M=
X-Google-Smtp-Source: AGHT+IHuHxh5mqX7RqLGEoVItvxSJ0QEO1HWwHcQdsilEu8FzLk6SzflzOyi+wzsLftN0NQJT9fDDg==
X-Received: by 2002:a05:6a20:8408:b0:186:736f:7798 with SMTP id c8-20020a056a20840800b00186736f7798mr5840594pzd.11.1699919859795;
        Mon, 13 Nov 2023 15:57:39 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:7575:f839:a613:3f5b? ([2620:0:1000:8411:7575:f839:a613:3f5b])
        by smtp.gmail.com with ESMTPSA id x14-20020aa784ce000000b006b97d5cbb7csm143897pfn.60.2023.11.13.15.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 15:57:39 -0800 (PST)
Message-ID: <3f2c2d33-2e5d-4c7b-80ea-e76885981dfb@acm.org>
Date: Mon, 13 Nov 2023 15:57:38 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [syzbot] [block?] WARNING in blk_mq_start_request
Content-Language: en-US
To: Chengming Zhou <zhouchengming@bytedance.com>,
 syzbot <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>,
 axboe@kernel.dk, chaitanyak@nvidia.com, eadavis@qq.com, hch@infradead.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.lei@redhat.com, syzkaller-bugs@googlegroups.com
References: <00000000000077ca930609aa9f86@google.com>
 <7ed9f6f9-d309-4d30-9b3b-c465cfa48a52@bytedance.com>
 <f4a6ff9e-d631-42c4-a5e1-87e767771488@acm.org>
 <d9f1ee3b-c303-44af-ba30-b52137fc29cb@bytedance.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d9f1ee3b-c303-44af-ba30-b52137fc29cb@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/23 07:05, Chengming Zhou wrote:
> Ok, I reviewed the code of virtio_queue_rqs(), found the main difference
> is that request won't fail after blk_mq_start_request().
> 
> But in null_blk case, the request will fail after blk_mq_start_request(),
> return BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE. If we return these rqs
> back to the block layer core, they will be queued individually once again.
> So caused the warning.

I think it is safe to move the blk_mq_start_request() call under the if-block
that decides whether or not to requeue a request in null_queue_rq()

Thanks,

Bart.

