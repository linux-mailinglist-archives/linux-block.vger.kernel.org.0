Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B24C36F439
	for <lists+linux-block@lfdr.de>; Fri, 30 Apr 2021 05:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhD3DGh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Apr 2021 23:06:37 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:35643 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhD3DGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 23:06:36 -0400
Received: by mail-pl1-f175.google.com with SMTP id t21so4757217plo.2
        for <linux-block@vger.kernel.org>; Thu, 29 Apr 2021 20:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FUbWrbAUFMQKu6236LhZho6/j3gJNZ7P8lNGT3czIBE=;
        b=lYhrlkHAjjK81YczqGBjxvGrKBsEerQgVBpJBZ/TnvR50CuVjaQzA0zO9ASrza0YAX
         uSbqy9IG07VJ3RcRHfzmoxq0Xzp2n7tPejwVlH9QyLF1G1D3WFcIfpR9FowTAvErv1ze
         S8vqSS5B0iu1FGTfppQNRFDsfwSrN3FaGbiydLcMchUF/a59SGOunIiSFZoQG2YdIrjk
         WhotVCDAJCnGKQx129sdyiaPdPgIv84IObCj+QmbUe807lP47n4erlzsEsuAAnoYZGcM
         TANqaXqwAFYqvwD3T9maekpukE2qb+eosW6XZa+eJY78CsO3H1hUO6wuuYhKwq6T+5pE
         6fPQ==
X-Gm-Message-State: AOAM5330Q9wikejBe9ma9W5CukJkDUeNAMyn6myGDJZV1knUoEq7Vz2b
        M6ZggW+lNK+JlE+opYb7INM=
X-Google-Smtp-Source: ABdhPJzO6eoeOoXmiOJ218cvaw3YI3lwZAp2T+zHWd0aesaKc0DO67nRvb2qOJuIsparALGeoqupcw==
X-Received: by 2002:a17:90a:e558:: with SMTP id ei24mr3067422pjb.43.1619751949044;
        Thu, 29 Apr 2021 20:05:49 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id h20sm420181pfv.6.2021.04.29.20.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 20:05:48 -0700 (PDT)
Subject: Re: [PATCH V4 4/4] blk-mq: clearing flush request reference in
 tags->rqs[]
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        David Jeffery <djeffery@redhat.com>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
 <20210429023458.3044317-5-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <57ac930a-3da3-eb91-2800-96fb395de44d@acm.org>
Date:   Thu, 29 Apr 2021 20:05:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429023458.3044317-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/28/21 7:34 PM, Ming Lei wrote:
> Before we free request queue, clearing flush request reference in
> tags->rqs[], so that potential UAF can be avoided.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
