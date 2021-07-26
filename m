Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3173D544E
	for <lists+linux-block@lfdr.de>; Mon, 26 Jul 2021 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhGZGyQ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Jul 2021 02:54:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38008 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhGZGyQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 02:54:16 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 551E121E76;
        Mon, 26 Jul 2021 07:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627284884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4N4ev2SrDl1UUdxFrnUf1aaZxb6vFHIR2LAR2WIsNag=;
        b=RIRQCYvmdV+xql0YNUsrj0TH+01t0fgtNKYMsflq9Z50HRsUMERu1z9P1nK7qUqd6Jf61s
        1sE6N6mUiDGVIGCl9y76CdQ2oEiS+0x8LfkOUIdkxpWnxrjrLE3BqVpk/I+FgoqKiLolxH
        MOHAzNTtffrdaSTUTwMERfTJstfTSis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627284884;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4N4ev2SrDl1UUdxFrnUf1aaZxb6vFHIR2LAR2WIsNag=;
        b=SW/ZqvOj+eOkigyo+BvzRk0uXNruQy1RPorlxCfyV0Qff/+kxY1dPvxMakZI1uK3aeX06X
        ypjJFWeBuxPegLAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3A6CF13A7B;
        Mon, 26 Jul 2021 07:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Kw+EDZRl/mBjEAAAGKfGzw
        (envelope-from <hare@suse.de>); Mon, 26 Jul 2021 07:34:44 +0000
Subject: Re: [PATCH v3 3/4] libata: support concurrent positioning ranges log
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org
References: <20210726013806.84815-1-damien.lemoal@wdc.com>
 <20210726013806.84815-4-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <800d5183-e62c-063f-c4ec-ccd21bea6d43@suse.de>
Date:   Mon, 26 Jul 2021 09:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726013806.84815-4-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/21 3:38 AM, Damien Le Moal wrote:
> Add support to discover if an ATA device supports the Concurrent
> Positioning Ranges Log (address 0x47), indicating that the device is
> capable of seeking to multiple different locations in parallel using
> multiple actuators serving different LBA ranges.
> 
> Also add support to translate the concurrent positioning ranges log
> into its equivalent Concurrent Positioning Ranges VPD page B9h in
> libata-scsi.c.
> 
> The format of the Concurrent Positioning Ranges Log is defined in ACS-5
> r9.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   drivers/ata/libata-core.c | 52 +++++++++++++++++++++++++++++++++++++++
>   drivers/ata/libata-scsi.c | 48 +++++++++++++++++++++++++++++-------
>   include/linux/ata.h       |  1 +
>   include/linux/libata.h    | 15 +++++++++++
>   4 files changed, 107 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
