Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BE040163C
	for <lists+linux-block@lfdr.de>; Mon,  6 Sep 2021 08:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239192AbhIFGOG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 6 Sep 2021 02:14:06 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51802 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhIFGOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Sep 2021 02:14:06 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DBEA2007A;
        Mon,  6 Sep 2021 06:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630908780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IW2wXTx3q9w67ADlEVFXdIL/3i+IwIgYXJEPTjHUFLE=;
        b=cdu5Kcxe5T45mIwBh0hw5uWrJPqfhaqUy5AHnSDVpWr1VK0bTyeuKnb89d220mhGRehvQW
        WgVnj92lYOZLF1AnZwORbLX3ndF3hIZDm6+JpSQAsQrIiN2KtbNFQE+CpuJYDhxwP8JLlN
        yAYZwubaK7d4XijvWC+NBBJgEaO76CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630908780;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IW2wXTx3q9w67ADlEVFXdIL/3i+IwIgYXJEPTjHUFLE=;
        b=Haxu3h4FqB2gptSDa9nivWLj+aYZ7FbLfzRJIqR39E3EULT0+f8Kcko3XuIE76ycB1eNXX
        XqOcs6STyIW2LQBg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C1BE713299;
        Mon,  6 Sep 2021 06:12:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EQ1rLGixNWGdTgAAGKfGzw
        (envelope-from <hare@suse.de>); Mon, 06 Sep 2021 06:12:56 +0000
Subject: Re: [PATCH v3 1/8] scsi/sd: add error handling support for add_disk()
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        martin.petersen@oracle.com, jejb@linux.ibm.com, kbusch@kernel.org,
        sagi@grimberg.me, adrian.hunter@intel.com, beanhuo@micron.com,
        ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
        agk@redhat.com, snitzer@redhat.com, josef@toxicpanda.com
Cc:     hch@infradead.org, bvanassche@acm.org, ming.lei@redhat.com,
        linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-mmc@vger.kernel.org, dm-devel@redhat.com,
        nbd@other.debian.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20210830212538.148729-1-mcgrof@kernel.org>
 <20210830212538.148729-2-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <10e3756d-09fb-7c5b-83d8-b1c527880b6c@suse.de>
Date:   Mon, 6 Sep 2021 08:13:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210830212538.148729-2-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/30/21 11:25 PM, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   drivers/scsi/sd.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
