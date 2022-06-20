Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859435512ED
	for <lists+linux-block@lfdr.de>; Mon, 20 Jun 2022 10:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238536AbiFTIhF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 20 Jun 2022 04:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbiFTIhF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 04:37:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C7612ABC
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 01:37:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2AED721B98;
        Mon, 20 Jun 2022 08:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655714223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJNXnYBjhDAa06yP5SWpSUKJllYWXacMJVJLMZYTVao=;
        b=uhlbNa+jv0L1MgZgdbOa3bJSL9leWwuyVJFuclm6owu6M0GIqmMpEdiqfHF5F6IiC12/5c
        EO8ISYxbkoJUhk7F7SqFcGc6mYDnLNu7/KA0souR24AGVsNpnR2x3cY2XNIrIOdlrHDAOh
        GRhGuUrYmwtsRSpPxUE/MIERCp/Nx50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655714223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJNXnYBjhDAa06yP5SWpSUKJllYWXacMJVJLMZYTVao=;
        b=aEsaHHp4zKQkvuRsSQ+22x03JJ4Yn/5anVZIQynd3Tk+e4KC1j20Rln7ZYZ7EXf1Zqul6W
        gJ6Ny6InUzNoBgCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E21CF13638;
        Mon, 20 Jun 2022 08:37:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1RjBNq4xsGIiKQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 08:37:02 +0000
Message-ID: <bf1d0674-c022-5d22-817e-c782e687e9be@suse.de>
Date:   Mon, 20 Jun 2022 10:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 1/6] mtip32xx: remove the device_status debugfs file
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <20220619060552.1850436-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220619060552.1850436-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/19/22 08:05, Christoph Hellwig wrote:
> This file is a huge mess that iterates over all devices and is in the
> way of fixing the device removal in this driver, so remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/mtip32xx/mtip32xx.c | 141 +-----------------------------
>   drivers/block/mtip32xx/mtip32xx.h |   4 -
>   2 files changed, 1 insertion(+), 144 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
