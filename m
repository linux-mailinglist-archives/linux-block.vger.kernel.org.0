Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241703ECE30
	for <lists+linux-block@lfdr.de>; Mon, 16 Aug 2021 07:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbhHPFzs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Aug 2021 01:55:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59858 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhHPFzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 01:55:47 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0DDAD1FE66;
        Mon, 16 Aug 2021 05:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629093316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiS4MO5iMMblnd34sdsJIsBaxp2YN67JanmuIjicNQQ=;
        b=SvyuC2QNRPwWYpdrQ00WG/bA+j/uMDXJM14Gw/NWMw6vjlWjGZ98TFJNdwBLIACIzJ+0+f
        HS5xJ1XwnviGKs+3JvpekJZMqnOR6HopA0xe29Is5ikBmmwMOuhcvCIZCOsri39aTCSey5
        npBm5Z17U0koOtS8DP+x783MFzhvTwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629093316;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AiS4MO5iMMblnd34sdsJIsBaxp2YN67JanmuIjicNQQ=;
        b=UAdOstZA3vhDnwxDaS7A2A2r5B+9dMh0FxnRkiVUN3al5QfhDgXuJv5SIgMbQS/GidXviL
        C1UrnAerS7jn7VBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DE05D136A6;
        Mon, 16 Aug 2021 05:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id bH7oNMP9GWE+UAAAGKfGzw
        (envelope-from <hare@suse.de>); Mon, 16 Aug 2021 05:55:15 +0000
Subject: Re: [PATCH v7 11/11] docs: sysfs-block-device: document
 ncq_prio_supported
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20210816014456.2191776-1-damien.lemoal@wdc.com>
 <20210816014456.2191776-12-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <127a963c-71e3-1c54-b453-39c479c72d8e@suse.de>
Date:   Mon, 16 Aug 2021 07:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816014456.2191776-12-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/21 3:44 AM, Damien Le Moal wrote:
> Add documentation for the new device attribute file ncq_prio_supported,
> and its SAS HBA equivalent sas_ncq_prio_supported.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   Documentation/ABI/testing/sysfs-block-device | 25 +++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
