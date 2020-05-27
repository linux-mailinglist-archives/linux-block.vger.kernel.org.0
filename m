Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8147B1E4CEE
	for <lists+linux-block@lfdr.de>; Wed, 27 May 2020 20:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391928AbgE0SSQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 May 2020 14:18:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:45136 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391927AbgE0SSQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 May 2020 14:18:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 524EDAEB9;
        Wed, 27 May 2020 18:18:18 +0000 (UTC)
Subject: Re: [PATCH 5/8] blk-mq: use BLK_MQ_NO_TAG in more places
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200527180644.514302-1-hch@lst.de>
 <20200527180644.514302-6-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c41925f1-26ac-1ecc-bf07-970624dcfd82@suse.de>
Date:   Wed, 27 May 2020 20:18:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527180644.514302-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/20 8:06 PM, Christoph Hellwig wrote:
> Replace various magic -1 constants for tags with BLK_MQ_NO_TAG.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-mq-tag.c |  8 ++++----
>   block/blk-mq.c     | 14 +++++++-------
>   block/blk-mq.h     |  4 ++--
>   3 files changed, 13 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
