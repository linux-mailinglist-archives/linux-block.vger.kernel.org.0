Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DD66645F0
	for <lists+linux-block@lfdr.de>; Tue, 10 Jan 2023 17:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbjAJQXm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 Jan 2023 11:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjAJQXO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jan 2023 11:23:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7839F71884;
        Tue, 10 Jan 2023 08:23:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 30C6F6AAEC;
        Tue, 10 Jan 2023 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673367792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9hyjLUNjtNULZ/LG99sWsCqQ+Lj+rAH7XIxFCm80oI=;
        b=ritgdUwrH9M/INRWvNO8lrcJtNVlPlw7Zox4sUTK6BVI5xONZmmNvFUbSMZW3fSgn9qfvl
        teXd4gcNP5i3ClDOJM3FDFu1dJMl7ovVpbNAEp3p5DFDUa9xqvmcmcmjkglrliKhq0hpeA
        PkXbriHYlnx2x9Z0YBr7bfACVNM2iYA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673367792;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9hyjLUNjtNULZ/LG99sWsCqQ+Lj+rAH7XIxFCm80oI=;
        b=FOaCZNsbJo+EKvPIKdvfGCe4YLCRjF7M59/fRd9gjte9vAU0S0xN7tV4zeMcKlomUIBgxH
        3Gt4N0Sago4b9JBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11B551358A;
        Tue, 10 Jan 2023 16:23:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oaStA/CQvWOkIAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 10 Jan 2023 16:23:12 +0000
Message-ID: <9ede335b-9e28-d171-58b1-8daa7f144f2e@suse.de>
Date:   Tue, 10 Jan 2023 17:22:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v8 1/6] block: add a sanity check for non-write flush/fua
 bios
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Christoph Hellwig <hch@lst.de>
References: <20230110131503.251712-1-damien.lemoal@opensource.wdc.com>
 <20230110131503.251712-2-damien.lemoal@opensource.wdc.com>
Content-Language: en-US
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230110131503.251712-2-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/10/23 14:14, Damien Le Moal wrote:
> From: Christoph Hellwig <hch@infradead.org>
> 
> Check that the PREFUSH and FUA flags are only set on write bios,
> given that the flush state machine expects that.
> 
> [Damien] The check is also extended to REQ_OP_ZONE_APPEND operations as
> these are data write operations used by btrfs and zonefs and may also
> have the REQ_FUA bit set.
> 
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>   block/blk-core.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
