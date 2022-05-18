Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4EB52B362
	for <lists+linux-block@lfdr.de>; Wed, 18 May 2022 09:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiERHXu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 18 May 2022 03:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbiERHXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 May 2022 03:23:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3C150020
        for <linux-block@vger.kernel.org>; Wed, 18 May 2022 00:23:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 466F421B2D;
        Wed, 18 May 2022 07:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652858626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ia1dj7NKl9o22jOQRJtZotlEsC74MJf4jTUCXUipxI=;
        b=lf/rAgKJlIAOh6UbzeaA+xjTlgKj3QZvOhO685zod1i/MUQ+6qQYMljvppuQ3TH+w3WjEz
        yAb0WmBuw79o88Py0/CfUowE1qbI+h/NSGv/hgwjqZWtwYc9oERvSV+S67TmEFlYhF9k3P
        NTwCWW0UBc3Paesu8xXHQDEMQE8fFSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652858626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ia1dj7NKl9o22jOQRJtZotlEsC74MJf4jTUCXUipxI=;
        b=H0h3B0xdeetM+GN5/gE06wvaNm+pQ/I75Hl2L3iT95BrqDBbduNaCtfpOgEgOC9qDWCIJX
        cbvCnhkjC3oX85AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 232BA133F5;
        Wed, 18 May 2022 07:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LrhcBwKfhGIATQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 18 May 2022 07:23:46 +0000
Message-ID: <8ff06ce2-0aa7-5999-8987-1f9d9935e4e5@suse.de>
Date:   Wed, 18 May 2022 09:23:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [GIT PULL] nvme updates for Linux 5.19
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YoSWZoB1/38DdP4S@infradead.org>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <YoSWZoB1/38DdP4S@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/22 08:47, Christoph Hellwig wrote:
> The following changes since commit c23d47abee3a54e4991ed3993340596d04aabd6a:
> 
>    loop: remove most the top-of-file boilerplate comment from the UAPI header (2022-05-10 06:30:05 -0600)
> 
Hmm. So how do we progress with the authentication patches?
Shall I resubmit them?
Will you be picking them up?
Is there anything I need to fix up?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
