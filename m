Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D7940A632
	for <lists+linux-block@lfdr.de>; Tue, 14 Sep 2021 07:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbhINFvi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Sep 2021 01:51:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56006 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbhINFvi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 01:51:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 90EA821A82;
        Tue, 14 Sep 2021 05:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631598620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4izNTayNpBPgK5BBEhBrNJipHk2klZzanheh9jekqy4=;
        b=x6U8VFQPMjnAPchcdgswn8RhOnZbNUNJU52cU6rVHO0QhyToblPphaSXdt+RDSrel5oXW+
        xahg8nSDL/aok0e4HDuydtNkuiSsLGidAa/Y5gm4hplpPLEu2IL9fzPf/tWAkgWUxNLOe5
        HMlrw/IMNT+WINJEcxojr528DpOIm2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631598620;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4izNTayNpBPgK5BBEhBrNJipHk2klZzanheh9jekqy4=;
        b=jTwHSAdzpeIFK7nK00QshXcDOI3ku7kuzsdyR6evHBKu7Wx8/Ex3P+/gBZ2u+/sk8clk+d
        sE05E6RwUY4TfTDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61EDD13E4A;
        Tue, 14 Sep 2021 05:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uCP8Fhw4QGEqVAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 14 Sep 2021 05:50:20 +0000
Subject: Re: [PATCH RESEND v3 11/13] blk-mq: Refactor and rename
 blk_mq_free_map_and_{requests->rqs}()
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org
References: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
 <1631545950-56586-12-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <633b747f-66ec-9562-bcab-090636ec35e0@suse.de>
Date:   Tue, 14 Sep 2021 07:50:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1631545950-56586-12-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/13/21 5:12 PM, John Garry wrote:
> Refactor blk_mq_free_map_and_requests() such that it can be used at many
> sites at which the tag map and rqs are freed.
> 
> Also rename to blk_mq_free_map_and_rqs(), which is shorter and matches the
> alloc equivalent.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq-tag.c |  3 +--
>   block/blk-mq.c     | 40 ++++++++++++++++++++++++----------------
>   block/blk-mq.h     |  4 +++-
>   3 files changed, 28 insertions(+), 19 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
