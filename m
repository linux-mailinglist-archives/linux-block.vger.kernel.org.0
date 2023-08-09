Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCED775289
	for <lists+linux-block@lfdr.de>; Wed,  9 Aug 2023 08:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHIGIX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Aug 2023 02:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjHIGIX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 02:08:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8160B12D
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 23:08:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 29F782187F;
        Wed,  9 Aug 2023 06:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691561301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0Wu3AscQtJCoQasPGyD24iBdiwAvdR/1vpXf3QvZpk=;
        b=O7Lwg9OyEYO8ojkL8Yd+MhgltyupFM8t5Yte9tkadiemnQ7j8TD/HIPQp/AXtWbWdw1J3o
        VOYkodZ/matHVMGy0+uh1AzIWKzL0ZXBjwZLYblK277nwUqQP7yxozG/NvBFO0uwDlSIBA
        cDeaYSrnacULQ+Q7mF6sx3k7LDPMpv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691561301;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o0Wu3AscQtJCoQasPGyD24iBdiwAvdR/1vpXf3QvZpk=;
        b=YycTK/FPIxIPZKQS/b99toPS+V2lsIYpL4PpS77vD6JMBPO3QAH4q3WkVKPAT7XdpcIJC4
        C5RhD3ltod+oKuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06BE913251;
        Wed,  9 Aug 2023 06:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E0SKAFUt02TwMQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 09 Aug 2023 06:08:21 +0000
Message-ID: <97132312-1872-78db-71c6-807e3ac7648a@suse.de>
Date:   Wed, 9 Aug 2023 08:08:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/5] block: use pr_xxx() instead of printk()
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20230808135702.628588-1-dlemoal@kernel.org>
 <20230808135702.628588-3-dlemoal@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230808135702.628588-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/23 15:56, Damien Le Moal wrote:
> Replace the remaining calls to printk() in the block layer core code
> with the equivalent pr_info(), pr_err() etc calls. The early block
> device lookup code in early-lookup.c is left untouched and continues
> using raw printk() calls.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   block/bio-integrity.c | 11 +++++++----
>   block/blk-ioc.c       |  5 ++++-
>   block/blk-mq.c        | 25 ++++++++++++++-----------
>   block/blk-settings.c  | 19 +++++++++++--------
>   block/bsg.c           |  7 +++++--
>   block/elevator.c      |  5 ++++-
>   block/genhd.c         |  7 +++++--
>   7 files changed, 50 insertions(+), 29 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

