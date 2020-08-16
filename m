Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF062459F3
	for <lists+linux-block@lfdr.de>; Mon, 17 Aug 2020 00:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgHPWuX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 16 Aug 2020 18:50:23 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36892 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgHPWuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Aug 2020 18:50:22 -0400
Received: from [IPv6:2804:431:c7f5:9f4e:1121:8b00:83b2:86f4] (unknown [IPv6:2804:431:c7f5:9f4e:1121:8b00:83b2:86f4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 911EA2753ED;
        Sun, 16 Aug 2020 23:50:19 +0100 (BST)
Subject: Re: [PATCH] block: blk-mq.c: fix @at_head kernel-doc warning
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20200816222519.313-1-rdunlap@infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <ce836be4-a430-eec3-9268-a9ad080122e7@collabora.com>
Date:   Sun, 16 Aug 2020 19:50:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200816222519.313-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Randy,

On 8/16/20 7:25 PM, Randy Dunlap wrote:
> Fix a new kernel-doc warning in block/blk-mq.c:
> 
> ../block/blk-mq.c:1844: warning: Function parameter or member 'at_head' not described in 'blk_mq_request_bypass_insert'
> 
> Fixes: 105663f73e71 ("blk-mq: Document functions for sending request")

By the time commit 105663f73e71 ("blk-mq: Document functions for sending
request") was merged, the parameter @at_head didn't exist[1].

The commit that inserted this warning is 01e99aeca397 ("blk-mq: insert
passthrough request into hctx->dispatch directly"), that added @at_head
without updating the documentation.

Thanks,
	André

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/blk-mq.c?id=105663f73e71b5e79ecf472c0499c9acde654b28#n1673


