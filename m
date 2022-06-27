Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A421555CF07
	for <lists+linux-block@lfdr.de>; Tue, 28 Jun 2022 15:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiF0HiA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Jun 2022 03:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiF0Hh7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jun 2022 03:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 830A760CF
        for <linux-block@vger.kernel.org>; Mon, 27 Jun 2022 00:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656315477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lE0J18H583vJLkCIOcPVekzofYXmutPDjmazSpLaBtI=;
        b=AbOEKRMGowxYGxYMSH9pSKGwgMd62FE4vbzMbRbYDu+NxAL94QxS6vY1AMUBEqfKHr8577
        Ynra0OTehL26nDAeZpZlLcCxmJ/Ni+oG8/7Qll7xvmysBiggg3jAo6JGeId2L+g5+jLECs
        TPcCmKG9P+vvQiliFM7dLa7lvUUnX5E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-Nqi89_JwMHyUrmb-8ZIcCg-1; Mon, 27 Jun 2022 03:37:52 -0400
X-MC-Unique: Nqi89_JwMHyUrmb-8ZIcCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4305D3C10250;
        Mon, 27 Jun 2022 07:37:52 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C983400F8FD;
        Mon, 27 Jun 2022 07:37:46 +0000 (UTC)
Date:   Mon, 27 Jun 2022 15:37:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [dm-devel] [PATCH 5.20 1/4] block: add bio_rewind() API
Message-ID: <YrleRWRHyvebl6+e@T590>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <YrjRkp9y99KZdwMo@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrjRkp9y99KZdwMo@sol.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 26, 2022 at 02:37:22PM -0700, Eric Biggers wrote:
> On Fri, Jun 24, 2022 at 10:12:52PM +0800, Ming Lei wrote:
> > diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> > index a496aaef85ba..caae2f429fc7 100644
> > --- a/block/blk-crypto.c
> > +++ b/block/blk-crypto.c
> > @@ -134,6 +134,21 @@ void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
> >  	}
> >  }
> >  
> > +/* Decrements @dun by @dec, treating @dun as a multi-limb integer. */
> > +void bio_crypt_dun_decrement(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
> > +			     unsigned int dec)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; dec && i < BLK_CRYPTO_DUN_ARRAY_SIZE; i++) {
> > +		dun[i] -= dec;
> > +		if (dun[i] > inc)
> > +			dec = 1;
> > +		else
> > +			dec = 0;
> > +	}
> > +}
> 
> This doesn't compile.  Also this doesn't handle underflow into the next limb
> correctly.  A correct version would be:
> 
> 		u64 prev = dun[i];
> 
> 		dun[i] -= dec;
> 		if (dun[i] > prev)
> 			dec = 1;
> 		else
> 			dec = 0;

You are right, thanks for the review!

Thanks,
Ming

