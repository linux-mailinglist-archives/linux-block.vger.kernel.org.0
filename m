Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93F6554749
	for <lists+linux-block@lfdr.de>; Wed, 22 Jun 2022 14:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351485AbiFVJVv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Jun 2022 05:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352484AbiFVJVt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 05:21:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3723134BAB
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 02:21:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E6C3B21B8C;
        Wed, 22 Jun 2022 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655889706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DC4fSQxzYVJgOCPdofhmw8nRsQYL1Bste3kBbNOw6z4=;
        b=bvG+jDMbCIz+MzCZFhHoKBl7SAdxW6a2raMUbsRd9rDzO2nHjgBmHhPmHRCSBID7y9Y2Tb
        Wn0lAwUbZ9olusoS9fnxqXjbi5ukcGbfD1YxOrYNbGRKVZ3NPFgbbThFv+DxAPPeoCtJBC
        PzF6NsdtM2JktJx35fcAhUC+zH3KIXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655889706;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DC4fSQxzYVJgOCPdofhmw8nRsQYL1Bste3kBbNOw6z4=;
        b=4aBwD+hWYmtT4CBKEMztwwAfkYNstfUz4rKp1RZgLZr0NWrapInNcCLElvpIyPVLmPO12i
        IYzdtR496UQuzKAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5FA692C141;
        Wed, 22 Jun 2022 09:21:46 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D67DBA062B; Wed, 22 Jun 2022 11:21:45 +0200 (CEST)
Date:   Wed, 22 Jun 2022 11:21:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 0/9 v4] block: Fix IO priority mess
Message-ID: <20220622092145.npw6nqzmq72ynv2z@quack3.lan>
References: <20220621102201.26337-1-jack@suse.cz>
 <d00ef1fa-9f6e-28f9-0b98-ad018837f924@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00ef1fa-9f6e-28f9-0b98-ad018837f924@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 21-06-22 22:03:54, Damien Le Moal wrote:
> On 6/21/22 19:24, Jan Kara wrote:
> > Hello,
> > 
> > This is the fourth revision of my patches fixing IO priority handling in the
> > block layer.
> 
> Thanks for this. I reviewed and this all looks good to me.
> Nevertheless, I will give this a spin tomorrow (with ATA drives that have
> NCQ priority).

Great, thanks for the review and the testing! I will wait for the results
and then post the final version of the patchset.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
