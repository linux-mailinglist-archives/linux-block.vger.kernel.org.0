Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1110240A610
	for <lists+linux-block@lfdr.de>; Tue, 14 Sep 2021 07:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbhINFmd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Sep 2021 01:42:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33924 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239462AbhINFmd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 01:42:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 58A341FDB5;
        Tue, 14 Sep 2021 05:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631598075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sISB2SioNb5EPDX/uRtMx9ZHXJKKf/PBem+DgwoQoFU=;
        b=L/Xy/wa0OvaE1CCdF/o6tfwmGihQldC48hJgju/Sf3Ne7kjepU1k0Vm9cjVLULIsEf5A/T
        LlspilMfbcv1bckjnWA6brPQhkug4a4ApTyeSm04FGj45CFUvTxYy+6eNeiJ0fwdGIO0so
        NdcMuUWFG275LuFkJlWaJkeAi7rgJ38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631598075;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sISB2SioNb5EPDX/uRtMx9ZHXJKKf/PBem+DgwoQoFU=;
        b=13qMxHPZPjcF7yO6J6G0N4CAzl3/pdORYG/ZC9cNINn/HXYjYHzdJqwIf8AqU+FPbQccjx
        4WYzZ1h9lpksWfDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E90E13E4A;
        Tue, 14 Sep 2021 05:41:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kivkAvs1QGEHUQAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 14 Sep 2021 05:41:15 +0000
Subject: Re: [PATCH RESEND v3 06/13] blk-mq-sched: Rename
 blk_mq_sched_free_{requests -> rqs}()
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org
References: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
 <1631545950-56586-7-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <402beece-60d0-71ab-e7a3-1837ae8891c2@suse.de>
Date:   Tue, 14 Sep 2021 07:41:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1631545950-56586-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/13/21 5:12 PM, John Garry wrote:
> To be more concise and consistent in naming, rename
> blk_mq_sched_free_requests() -> blk_mq_sched_free_rqs().
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-core.c     | 2 +-
>   block/blk-mq-sched.c | 6 +++---
>   block/blk-mq-sched.h | 2 +-
>   block/blk.h          | 2 +-
>   4 files changed, 6 insertions(+), 6 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
