Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40C83D7146
	for <lists+linux-block@lfdr.de>; Tue, 27 Jul 2021 10:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhG0IdB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Jul 2021 04:33:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45798 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbhG0IdB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 04:33:01 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F63E22150;
        Tue, 27 Jul 2021 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627374780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agyJ3PxeL/rCeznuDJr7kkkcVxlpt1QJ8E6bHYzo+fY=;
        b=ts/InoDOcAaUgvxSUUJlwHB76cP9cG0q4Ywi3sPkOmJJovpHPIdy0IHE2MFnf4VL2ZpYu6
        4Qphe8Os1J7DhJYYSJb4lkD8iBNw2ILAm2NE0RrF9ZEONTSH2bciZdDchpVRNf3qkhZGoY
        s0UAjgcnjqh3pby6daxRmDWFLZitedg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627374780;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agyJ3PxeL/rCeznuDJr7kkkcVxlpt1QJ8E6bHYzo+fY=;
        b=1jnsJ78OcJd/+GeZBsK9fecqotocytlzMmHsg5r74xJZEzEno7g/l09A/Klbh74Ug0er4E
        8EjAG6TLz82GCWCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F14D1377D;
        Tue, 27 Jul 2021 08:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fVeZIrzE/2CNaAAAMHmgww
        (envelope-from <hare@suse.de>); Tue, 27 Jul 2021 08:33:00 +0000
Subject: Re: [PATCH 1/6] block: reduce stack usage in diskstats_show
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
        linux-block@vger.kernel.org
References: <20210727062518.122108-1-hch@lst.de>
 <20210727062518.122108-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <a41dca1b-00de-70c2-da71-780d6e08d406@suse.de>
Date:   Tue, 27 Jul 2021 10:32:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210727062518.122108-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/21 8:25 AM, Christoph Hellwig wrote:
> From: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> 
> I have compiled the kernel with a cross compiler "hppa-linux-gnu-" v9.3.0
> on x86-64 host machine. I got the following warning:
> 
> block/genhd.c: In function ‘diskstats_show’:
> block/genhd.c:1227:1: warning: the frame size of 1688 bytes is larger
> than 1280 bytes [-Wframe-larger-than=]
>  1227  |  }
> 
> By Reduced the stack footprint by using the %pg printk specifier instead
> of disk_name to remove the need for the on-stack buffer.
> 
> Signed-off-by: Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
