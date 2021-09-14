Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D7440A602
	for <lists+linux-block@lfdr.de>; Tue, 14 Sep 2021 07:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239411AbhINFjK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 14 Sep 2021 01:39:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54484 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbhINFjK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Sep 2021 01:39:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B605E220AF;
        Tue, 14 Sep 2021 05:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631597872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93mZYd+lAEcHjlpH7HC7AosvV1JsJgnb29A4POV21Z0=;
        b=RSblGJtUuEl2S2/ObEulipdzro0Fox1CszL7LvtPd24jPz9ioctHlegtlmSF9M9UFvzy7A
        mCdorLXdzLObhFc6WPP5/6pWSNf4ChIdIyfMpixtQNsjXmKCQvFaCil/0/oQhtyllKCZ23
        xU2O6S9MfDXD/8m3Iij8K07iyQ9v0Mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631597872;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93mZYd+lAEcHjlpH7HC7AosvV1JsJgnb29A4POV21Z0=;
        b=CvUL6HC1zRX5PEgRhCVwxo4a6mbdZdHU2a+xy4ezZ4jQovbdJUDVeueU7Pf85Or9SZXSp5
        dVvsMQvUZ3YXsVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6FAE113E4A;
        Tue, 14 Sep 2021 05:37:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Bs+cGTA1QGG+TwAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 14 Sep 2021 05:37:52 +0000
Subject: Re: [PATCH RESEND v3 03/13] blk-mq: Relocate shared sbitmap resize in
 blk_mq_update_nr_requests()
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org
References: <1631545950-56586-1-git-send-email-john.garry@huawei.com>
 <1631545950-56586-4-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <9630cb58-7133-d21b-2c31-05f4369f484b@suse.de>
Date:   Tue, 14 Sep 2021 07:37:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1631545950-56586-4-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/13/21 5:12 PM, John Garry wrote:
> For shared sbitmap, if the call to blk_mq_tag_update_depth() was
> successful for any hctx when hctx->sched_tags is not set, then it would be
> successful for all (due to nature in which blk_mq_tag_update_depth()
> fails).
> 
> As such, there is no need to call blk_mq_tag_resize_shared_sbitmap() for
> each hctx. So relocate the call until after the hctx iteration under the
> !q->elevator check, which is equivalent (to !hctx->sched_tags).
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
