Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47A85CC61
	for <lists+linux-block@lfdr.de>; Tue,  2 Jul 2019 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGBJHk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jul 2019 05:07:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:33978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727035AbfGBJHj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jul 2019 05:07:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7316B128;
        Tue,  2 Jul 2019 09:07:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Jul 2019 11:07:38 +0200
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH liburing 2/2] Fix the use of memory barriers
In-Reply-To: <20190701214232.29338-3-bvanassche@acm.org>
References: <20190701214232.29338-1-bvanassche@acm.org>
 <20190701214232.29338-3-bvanassche@acm.org>
Message-ID: <5d5931e08e338a8a8edb1e58a33a120e@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On 2019-07-01 23:42, Bart Van Assche wrote:

...

> +#if defined(__x86_64__)
> +#define smp_store_release(p, v)			\
> +do {						\
> +	barrier();				\
> +	WRITE_ONCE(*(p), (v));			\
> +} while (0)
> +
> +#define smp_load_acquire(p)			\
> +({						\
> +	typeof(*p) ___p1 = READ_ONCE(*(p));	\
> +	barrier();				\
> +	___p1;					\
> +})

Can we have these two macros for x86_32 as well?
For i386 it will take another branch with full mb,
which is not needed.

Besides that both patches looks good to me.

--
Roman

