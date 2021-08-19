Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ADA3F177E
	for <lists+linux-block@lfdr.de>; Thu, 19 Aug 2021 12:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhHSKtP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Aug 2021 06:49:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46292 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbhHSKtP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 06:49:15 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B2D511FD8A;
        Thu, 19 Aug 2021 10:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629370118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rlLwsJo8s+V0p1ahIY8HOBEIIwfRO0dwAo701j5Pl4=;
        b=v0bU3WVKyZVZESwlo8X08rmaCgvvZFQb60opd1jsayx5RsSFupCpN1gTXcJb8FTN72+/pS
        ilvwdLESq6smt4Dh4exWNiSzNp9MZUMJLcuEPhm29iHbE8R/QHIng6KxETu6w4kEc1qudy
        TjENBo93UUjevDqR3Omq5AV4q1ha8fs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629370118;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1rlLwsJo8s+V0p1ahIY8HOBEIIwfRO0dwAo701j5Pl4=;
        b=4bBWbzN9CxBeD2IbMWOfZyqPeBfyMz+szkBAOiSGFmzQsRCS6fKFlAi596j8Gpwje2xHaE
        0yq2q23jHseDj8Dg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 757FA139BA;
        Thu, 19 Aug 2021 10:48:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id +SWcGgY3HmFZRQAAGKfGzw
        (envelope-from <hare@suse.de>); Thu, 19 Aug 2021 10:48:38 +0000
Subject: Re: [PATCH 02/11] block: fold register_disk into device_add_disk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-3-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <e9218377-69ac-2b79-e96b-62c61018de0c@suse.de>
Date:   Thu, 19 Aug 2021 12:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210818144542.19305-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/18/21 4:45 PM, Christoph Hellwig wrote:
> There is no real reason these should be separate.  Also simplify the
> groups assignment a bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c | 131 +++++++++++++++++++++++---------------------------
>   1 file changed, 60 insertions(+), 71 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
