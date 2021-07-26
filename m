Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BFB3D5455
	for <lists+linux-block@lfdr.de>; Mon, 26 Jul 2021 09:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhGZGyo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 26 Jul 2021 02:54:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45126 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbhGZGyn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 02:54:43 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4A6E1FE46;
        Mon, 26 Jul 2021 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627284911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5dvr0LHy8dYG8onIBBCDYTGz+HpEoDCyFWl8cDv/bRQ=;
        b=gy0aFZ3NRoSGzCqRJzY2e0o+TBRl3taKQ64RuJGfAqC+zJMNrn2Ljg09NImx14CNDAXc+E
        BKbQ9H1ZI2Z/qGwFVtcyTC/EaKx/R7Hz1926eonDkpA+J2dO5ILw7dKWQiOe+Mmit5kouh
        2ImcDTexXQVFTt7ENY30IyXEOjRA8MU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627284911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5dvr0LHy8dYG8onIBBCDYTGz+HpEoDCyFWl8cDv/bRQ=;
        b=1NEqoR6amop8G9C4HX44z6sj2n2JQjsQzo9BB2nFogK+RNVbHQSZG6UgWgFop1S71z5InF
        D1Q3vgA2Dobzj5Aw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9ED9E13A7B;
        Mon, 26 Jul 2021 07:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id jIktJq9l/mCCEAAAGKfGzw
        (envelope-from <hare@suse.de>); Mon, 26 Jul 2021 07:35:11 +0000
Subject: Re: [PATCH v3 4/4] doc: document sysfs queue/cranges attributes
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org
References: <20210726013806.84815-1-damien.lemoal@wdc.com>
 <20210726013806.84815-5-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e7d11017-39d7-2f1f-eb67-de6331715f4a@suse.de>
Date:   Mon, 26 Jul 2021 09:35:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726013806.84815-5-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/26/21 3:38 AM, Damien Le Moal wrote:
> Update the file Documentation/block/queue-sysfs.rst to add a description
> of a device queue sysfs entries related to concurrent sector ranges
> (e.g. concurrent positioning ranges for multi-actuator hard-disks).
> 
> While at it, also fix a typo in this file introduction paragraph.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   Documentation/block/queue-sysfs.rst | 30 ++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
