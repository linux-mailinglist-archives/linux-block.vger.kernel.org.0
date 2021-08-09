Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0413E3F90
	for <lists+linux-block@lfdr.de>; Mon,  9 Aug 2021 08:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbhHIGLz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 Aug 2021 02:11:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46062 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbhHIGLy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 02:11:54 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5CC751FD8E;
        Mon,  9 Aug 2021 06:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628489493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFQh0oA5Syl9UjKiLA13hTSzBTaOpipEYKqV2K3tg68=;
        b=kzsOIzlZoTdwCN5roQls8koEEpV6pJ+OaqzwrtSLyBxZ1C7VzqGG6t1dnKulGFs4uIRLmt
        F2Le66EIYIzta1M/zthlj7YC38SFX3ViZCReH5oXnIMmgATyGvjydbu+LBp0617BlVbeHg
        /ZgXh/dk/0IURURxiLqpWyVMein6SDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628489493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFQh0oA5Syl9UjKiLA13hTSzBTaOpipEYKqV2K3tg68=;
        b=5ayX8TCxdQoupKEEWVhzdaxYsIkEEN2L/QzxJyoAN+kVtmDs3g1C6Vp2QKK6gMf7aCU676
        g0fHxhfeZ9MM6bDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 02E6713318;
        Mon,  9 Aug 2021 06:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id d1krOxTHEGHeBwAAGKfGzw
        (envelope-from <hare@suse.de>); Mon, 09 Aug 2021 06:11:32 +0000
Subject: Re: [PATCH v4 09/10] libahci: Introduce ncq_prio_supported sysfs
 sttribute
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
References: <20210807041859.579409-1-damien.lemoal@wdc.com>
 <20210807041859.579409-10-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e0862e8e-6014-cb9b-9fc5-20fec12d50a5@suse.de>
Date:   Mon, 9 Aug 2021 08:11:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807041859.579409-10-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/21 6:18 AM, Damien Le Moal wrote:
> Currently, the only way a user can determine if a SATA device supports
> NCQ priority is to try to enable the use of this feature using the
> ncq_prio_enable sysfs device attribute. If enabling the feature fails,
> it is because the device does not support NCQ priority. Otherwise, the
> feature is enabled and indicates that the device supports NCQ priority.
> 
> Improve this odd interface by introducing the read-only
> ncq_prio_supported sysfs device attribute to indicate if a SATA device
> supports NCQ priority. The value of this attribute reflects if the
> device flag ATA_DFLAG_NCQ_PRIO is set or cleared.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>   drivers/ata/libahci.c     |  1 +
>   drivers/ata/libata-sata.c | 24 ++++++++++++++++++++++++
>   include/linux/libata.h    |  1 +
>   3 files changed, 26 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
