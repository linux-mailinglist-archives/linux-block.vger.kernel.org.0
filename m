Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EEB1A7346
	for <lists+linux-block@lfdr.de>; Tue, 14 Apr 2020 08:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405746AbgDNGFq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Apr 2020 02:05:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405711AbgDNGFq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Apr 2020 02:05:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50D37AD23;
        Tue, 14 Apr 2020 06:05:43 +0000 (UTC)
Subject: Re: [PATCH 02/10] sbitmap: add helpers for updating allocation hint
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Omar Sandoval <osandov@fb.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
References: <20200211121135.30064-1-ming.lei@redhat.com>
 <20200211121135.30064-3-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6217456a-0acf-f752-6dbb-5a29468a9465@suse.de>
Date:   Tue, 14 Apr 2020 08:05:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200211121135.30064-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/20 1:11 PM, Ming Lei wrote:
> Add helpers for updating allocation hint, so that we can
> avoid to duplicate code.
> 
> Prepare for moving allocation hint into sbitmap.
> 
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> Cc: Chaitra P B <chaitra.basappa@broadcom.com>
> Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> Cc: Kashyap Desai <kashyap.desai@broadcom.com>
> Cc: Sumit Saxena <sumit.saxena@broadcom.com>
> Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> Cc: Ewan D. Milne <emilne@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   lib/sbitmap.c | 93 ++++++++++++++++++++++++++++++---------------------
>   1 file changed, 54 insertions(+), 39 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
