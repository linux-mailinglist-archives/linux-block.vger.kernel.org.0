Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0BB7D78D5
	for <lists+linux-block@lfdr.de>; Thu, 26 Oct 2023 01:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjJYXp1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Oct 2023 19:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJYXp0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Oct 2023 19:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC6892
        for <linux-block@vger.kernel.org>; Wed, 25 Oct 2023 16:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698277478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fRRiWcvSu7O2wHI18XO/8e5fxTg1mwMcO9kFULNLUJ8=;
        b=SC4DcMPLCCKLR6OwuaGNDv0JaLOomuJIXj5sOdQ3cLQ2EkRjD2zu1SgkQws9Cq67n0BuLR
        BmC8pjjDMJ/b+JliXHWbCbi/np/nv9Oc96G5IMo1vkWY5n6HRw88yawxJWfaKaQL65hj7S
        moTuLSQg/K4yVNPtlDLMQSLz8oW7oRA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-anuM-sPDOlKNamihA20Ijg-1; Wed, 25 Oct 2023 19:44:35 -0400
X-MC-Unique: anuM-sPDOlKNamihA20Ijg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D36B4185A782;
        Wed, 25 Oct 2023 23:44:34 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F06AD2166B26;
        Wed, 25 Oct 2023 23:44:30 +0000 (UTC)
Date:   Thu, 26 Oct 2023 07:44:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, axboe@kernel.dk, ming.lei@redhat.com
Subject: Re: [PATCH v2] dm: respect REQ_NOWAIT flag in bios issued to DM
Message-ID: <ZTmoWiulrM8Jx1Tc@fedora>
References: <15ca26cc-174a-d4e8-9780-d09f8e5a6ea5@redhat.com>
 <ZTgFtseG3m3WPWn/@redhat.com>
 <e796de8-bac1-8f7a-c6eb-74d39aad8a2b@redhat.com>
 <ZTgb3lkNmEUIYpsl@redhat.com>
 <ZTlt0HPbVZf0gYcI@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTlt0HPbVZf0gYcI@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 25, 2023 at 03:34:40PM -0400, Mike Snitzer wrote:
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> Update DM core's IO submission to allocate required memory using
> GFP_NOWAIT if REQ_NOWAIT is set.  Lone exception is in the error path
> where DM's requeue support needs to allocate a clone bio in
> dm_io_rewind() to allow the IO to be resubmitted: GFP_NOWAIT is used
> first but if it fails GFP_NOIO is used as a last resort.
> 
> Tested with simple test provided in commit a9ce385344f916 ("dm: don't
> attempt to queue IO under RCU protection") that was enhanced to check
> error codes.  Also tested using fio's pvsync2 with nowait=1.
> 
> But testing with induced GFP_NOWAIT allocation failures wasn't
> performed.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  drivers/md/dm-io-rewind.c | 13 ++++++--
>  drivers/md/dm.c           | 66 ++++++++++++++++++++++++++++++++-------
>  2 files changed, 65 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/md/dm-io-rewind.c b/drivers/md/dm-io-rewind.c
> index 6155b0117c9d..bde5a53e2d88 100644
> --- a/drivers/md/dm-io-rewind.c
> +++ b/drivers/md/dm-io-rewind.c
> @@ -143,8 +143,17 @@ static void dm_bio_rewind(struct bio *bio, unsigned int bytes)
>  void dm_io_rewind(struct dm_io *io, struct bio_set *bs)
>  {
>  	struct bio *orig = io->orig_bio;
> -	struct bio *new_orig = bio_alloc_clone(orig->bi_bdev, orig,
> -					       GFP_NOIO, bs);
> +	struct bio *new_orig;
> +
> +	new_orig = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOWAIT, bs);
> +	if (unlikely(!new_orig)) {
> +		/*
> +		 * Returning early and failing rewind isn't an option, even
> +		 * if orig has REQ_NOWAIT set, so retry alloc with GFP_NOIO.
> +		 */
> +		new_orig = bio_alloc_clone(orig->bi_bdev, orig, GFP_NOIO, bs);
> +	}

dm_bio_rewind() is only called in requeue work fn, so there shouldn't
be issue with NOWAIT, cause upper IO submission code path won't be blocked
by requeue.


Thanks, 
Ming

