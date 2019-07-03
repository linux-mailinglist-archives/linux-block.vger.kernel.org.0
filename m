Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 507E35E762
	for <lists+linux-block@lfdr.de>; Wed,  3 Jul 2019 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfGCPGX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 3 Jul 2019 11:06:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39705 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGCPGX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 11:06:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so912907pgi.6
        for <linux-block@vger.kernel.org>; Wed, 03 Jul 2019 08:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jVLsgvltdtWXaOO5l20EWQ4ylMFDk6XCuj/2P5UsAJQ=;
        b=e/+8pLN5PhpJ0ldLJBM1v12xgSWvt/PITh03WgAwPJqR0QxCwbkcJPsjDUCW5jne6v
         mjkNbyRgopJ2OXOyj1jHGQlhIY3lq4LHcS/i9CP6FbllWI6GQKRZw8/lp/cI1Ayyr3k+
         yks9oe4pEFgRDTSTJQUWNpNS8jp7+YR3nFbSFMwFDstrOj2ZZhPiMCjPAOpHDvfqPHCl
         u4WjD01Pm5mxqQLB91EU7ZVecHhSlyatFa5IMezV+bneINIyxLQocuqR1lYS4LZD29Ah
         wq0b0vEJ0bTaS/Y49u5JnseoBE48S6PnNx5+udCmpimDcFSYZAnlUFSpS0cfKJwZWM6X
         WDjA==
X-Gm-Message-State: APjAAAXJ+k4lxmiVlALc6Zt3i1CsvK/PylAbZvjuhwxWZIbZcpNXHyWt
        KLmk1QGTy2NKCMTND25lghU=
X-Google-Smtp-Source: APXvYqzmMp6BuCLyzumjHMTQEJbM4k40tRhWU9o2K69CRDu3ae7DNnDMrF8gyU1FYY2lYw9JgVJfdg==
X-Received: by 2002:a65:5b8e:: with SMTP id i14mr33909096pgr.188.1562166382501;
        Wed, 03 Jul 2019 08:06:22 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p19sm6135217pfn.99.2019.07.03.08.06.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 08:06:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] blk-mq: Remove blk_mq_put_ctx()
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>, Omar Sandoval <osandov@fb.com>
References: <20190701154730.203795-1-bvanassche@acm.org>
 <20190701154730.203795-2-bvanassche@acm.org>
 <20190703024513.GA30102@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <19f7f7c6-49e1-dc9f-5555-e1b658c1b84f@acm.org>
Date:   Wed, 3 Jul 2019 08:06:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190703024513.GA30102@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/19 7:45 PM, Ming Lei wrote:
> Then there isn't any difference between __blk_mq_get_ctx() and blk_mq_get_ctx(),
> so could you kill __blk_mq_get_ctx()?

I will post a patch that does this unless someone else does this before me.

Bart.
