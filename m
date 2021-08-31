Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0263FC2EC
	for <lists+linux-block@lfdr.de>; Tue, 31 Aug 2021 08:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbhHaGnY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 31 Aug 2021 02:43:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46076 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbhHaGnY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Aug 2021 02:43:24 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6552F22169;
        Tue, 31 Aug 2021 06:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630392148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4bO1uDoPyVjXMyarbRCwKRvMnsekjXSwph97qcH7zY=;
        b=JO4eC3QcygtWx5imvpsA2ldcboiSaDXucxQpLO8sktYQGLuwi/4nTdoIaWtL7ewTotMfKk
        oNn8lrDdQ1HCjc/3WCV8VzradAHtzgxsEV+HZtTyRg3Dz0TPB3dPyeCE1uiMtXLA8qDbda
        YXw+31I0uGBteCMZP9BNu/Z4a0DWErM=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 248FD12FC5;
        Tue, 31 Aug 2021 06:42:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EW61BVTPLWFIQAAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 31 Aug 2021 06:42:28 +0000
Subject: Re: [PATCH] blk-mq: Use helpers to access rq->state
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        axboe@kernel.dk
References: <20210512095017.235295-1-nborisov@suse.com>
 <36615406-97c4-5273-364b-8f2b5b1fb35f@acm.org>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <4ec372d9-a234-8208-b8e3-e545d6658bd2@suse.com>
Date:   Tue, 31 Aug 2021 09:42:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <36615406-97c4-5273-364b-8f2b5b1fb35f@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 30.08.21 г. 20:29, Bart Van Assche wrote:
<snip>

> Is the above patch complete? I think even with the above patch applied
> there are still two functions in the block layer that use WRITE_ONCE() to
> modify rq->state directly:
> 
> $ git grep -nH 'WRITE_ONCE(rq->state,'
> block/blk-mq.c:532:    WRITE_ONCE(rq->state, MQ_RQ_IDLE);
> block/blk-mq.c:648:    WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
> block/blk-mq.c:728:    WRITE_ONCE(rq->state, MQ_RQ_IN_FLIGHT);
> block/blk-mq.c:747:        WRITE_ONCE(rq->state, MQ_RQ_IDLE);
> block/blk-mq.c:2416:    WRITE_ONCE(rq->state, MQ_RQ_IDLE);
> include/linux/blk-mq.h:521:    WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);

On just-updated master I get:

$ git grep 'WRITE_ONCE(rq->state,'
block/blk-mq.c: WRITE_ONCE(rq->state, MQ_RQ_IDLE);
block/blk-mq.c: WRITE_ONCE(rq->state, MQ_RQ_IN_FLIGHT);
block/blk-mq.c:         WRITE_ONCE(rq->state, MQ_RQ_IDLE);
block/blk-mq.c: WRITE_ONCE(rq->state, MQ_RQ_IDLE);
include/linux/blk-mq.h: WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);


> 
> Thanks,
> 
> Bart.
> 
