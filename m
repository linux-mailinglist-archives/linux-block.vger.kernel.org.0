Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C331E20EE14
	for <lists+linux-block@lfdr.de>; Tue, 30 Jun 2020 08:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgF3GLC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Jun 2020 02:11:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:51714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgF3GLB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 02:11:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ADCA0AAC3;
        Tue, 30 Jun 2020 06:11:00 +0000 (UTC)
Subject: Re: [PATCH 2/3] blk-mq: move blk_mq_put_driver_tag() into blk-mq.c
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20200630022356.2149607-1-ming.lei@redhat.com>
 <20200630022356.2149607-3-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <15018566-bf92-8c84-8355-638bcb90a3c7@suse.de>
Date:   Tue, 30 Jun 2020 08:10:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630022356.2149607-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/20 4:23 AM, Ming Lei wrote:
> It is used by blk-mq.c only, so move it to the source file.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 20 ++++++++++++++++++++
>   block/blk-mq.h | 20 --------------------
>   2 files changed, 20 insertions(+), 20 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
