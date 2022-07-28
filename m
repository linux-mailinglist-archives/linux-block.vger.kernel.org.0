Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E087C583A0E
	for <lists+linux-block@lfdr.de>; Thu, 28 Jul 2022 10:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiG1IIg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jul 2022 04:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbiG1IIf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 04:08:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5756161D72
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 01:08:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1696A20D58;
        Thu, 28 Jul 2022 08:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658995714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zK0Mm2z9vbknqkLEB5kQWG3idwkwtggudTRBFg9Cyuw=;
        b=mPJzn5bg4/tHRJ7zMORCqWFuIqdNaB2/yRLqqRm3yOkTwAVTG5QJDC7OysyC/DMjtsyCfU
        kVWAYYh+rpIra+KVlHb3jRlTdNWZtrTQHriqJe0WCxD6z+yFbxkKowUv8OohCnyxWE3Unt
        5nBovpeGEghwB1N8811UZePcq+G+oJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658995714;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zK0Mm2z9vbknqkLEB5kQWG3idwkwtggudTRBFg9Cyuw=;
        b=xUUeX2VLcOtEkSnE/bJe7ouKKGceW73LOgoKo6/O471aCcQvNCyf9X8XOiWvuORLh9KKmF
        DGZ7WN9lcH7aYiCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02BCA13A7E;
        Thu, 28 Jul 2022 08:08:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XgIfAAJE4mIIJwAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 28 Jul 2022 08:08:34 +0000
Message-ID: <b3999801-edbb-209b-9f99-f5b95bd21e65@suse.de>
Date:   Thu, 28 Jul 2022 10:08:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/6] block: move the call to get_max_io_size out of
 blk_bio_segment_split
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20220727162300.3089193-1-hch@lst.de>
 <20220727162300.3089193-5-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220727162300.3089193-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/22 18:22, Christoph Hellwig wrote:
> Prepare for reusing blk_bio_segment_split for (file system controlled)
> splits of REQ_OP_ZONE_APPEND bios by letting the caller control the
> maximum size of the bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk-merge.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
