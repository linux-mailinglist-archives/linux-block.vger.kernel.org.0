Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C34640A607
	for <lists+linux-block@lfdr.de>; Tue, 14 Sep 2021 07:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbhINFjv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Sep 2021 01:39:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33606 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbhINFju (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 01:39:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C30D21FDCA;
        Tue, 14 Sep 2021 05:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631597912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eb31X9wNyWIMw+VBDs7ourfgf+3cN+Xonthf0PtZNlY=;
        b=FfxMinIyIoEC3F5QnwWW8bypmkxglnPteCO1RTKRq5acj2XNp9n+/CD0b+i+A2JrE9igFo
        i6C+D7j2j2PbLCh8wl9cOEsIsrGTGaG8AY3pArqk3ft5LxKnrHahN2ewbUAklqgT+OdaGi
        2wNoNhp5WjHQe2wcRZDk+Hf3aicyksQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631597912;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eb31X9wNyWIMw+VBDs7ourfgf+3cN+Xonthf0PtZNlY=;
        b=XjrYn6izxG2I/DmE78PtEGYb5HVILBpEXbrWwG+MbZh9/vS2J9Lg91Qm5HRbS1ya4MUQOi
        pXF3DyeDC6HvKDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46F8F13E4A;
        Tue, 14 Sep 2021 05:38:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gUgrDlg1QGHzTwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 14 Sep 2021 05:38:32 +0000
Subject: Re: [PATCH RESEND v3 04/13] blk-mq: Invert check in
 blk_mq_update_nr_requests()
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org
References: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
 <1631545950-56586-5-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <ce0ed313-4d69-cbc7-22f7-3ab8f785fbce@suse.de>
Date:   Tue, 14 Sep 2021 07:38:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1631545950-56586-5-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/13/21 5:12 PM, John Garry wrote:
> It's easier to read:
> 
> if (x)
> 	X;
> else
> 	Y;
> 
> over:
> 
> if (!x)
> 	Y;
> else
> 	X;
> 
> No functional change intended.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
