Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D756A39AF11
	for <lists+linux-block@lfdr.de>; Fri,  4 Jun 2021 02:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFDAeL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 3 Jun 2021 20:34:11 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:35568 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDAeK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Jun 2021 20:34:10 -0400
Received: by mail-pj1-f47.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso6488122pjb.0
        for <linux-block@vger.kernel.org>; Thu, 03 Jun 2021 17:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7alkpOp1DlbOdC35NOtmSBF/QsgvP/iK1ol+FbTZegQ=;
        b=s8J7PRkvfvg01I3c9eIzayH+9ETesaSfqB/FnEoV9xTKuokEe5hitqOsTell4xYhw4
         MzJTag2w8/tmlz21Od0qrJ71evdDVVGScfClVoFOWbdQCqgkYWgod2NYDNQHY9Wy9jM+
         07QP+yDQo3N3IH2aQTZ2vdfIGUozoelAk2dO0dywkWA3hCjneQqYu0pDNuk5zoOKOqJr
         gPa+Qzj9BQTWHdhliAolD9z/t5DX1Mcyh2f9SYMGQ4IKpRKLAq4m1fFURHxMYFvHf2P2
         iNimghARxyTF06nXwVrj+ULA+Q0Ms9xmsXVW6D8x4VIGvrZsFmVKHj1AAeGCJLhyGgY0
         gbqw==
X-Gm-Message-State: AOAM5324t2aVFvykQW7PwzPLgnFsqJORwUdmGyqqSAjYnuG0Xsghs1u5
        kj4gpDSX9IWVrt97+upxsNo=
X-Google-Smtp-Source: ABdhPJyO0vkpWz0zmnfm+ewn4dSs8LxsYOkwmelPtHqM9RPadWtwvR9qKx0KJENWD5LHeqgGB8twfw==
X-Received: by 2002:a17:902:b683:b029:ee:f0e3:7a50 with SMTP id c3-20020a170902b683b02900eef0e37a50mr1688435pls.7.1622766730547;
        Thu, 03 Jun 2021 17:32:10 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id p14sm237545pgb.2.2021.06.03.17.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 17:32:09 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: split wbt_init() into two parts
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Yi Zhang <yi.zhang@redhat.com>
References: <20210525080442.1896417-1-ming.lei@redhat.com>
 <20210525080442.1896417-2-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0470daf8-91fe-8659-c011-831b73307c82@acm.org>
Date:   Thu, 3 Jun 2021 17:32:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525080442.1896417-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/25/21 1:04 AM, Ming Lei wrote:
> +int wbt_init(struct request_queue *q)
> +{
> +	int ret = wbt_alloc(q);
> +	struct rq_wb *rwb;
> +
> +	if (ret)
> +		return ret;

A coding style nit: please move the 'ret = wbt_alloc(q)' assignment to a
line of its own since wbt_alloc() allocates memory. Otherwise this patch
looks good to me.

Thanks,

Bart.
