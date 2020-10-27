Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5DB29CAFE
	for <lists+linux-block@lfdr.de>; Tue, 27 Oct 2020 22:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505290AbgJ0VKZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Oct 2020 17:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442629AbgJ0VKY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 17:10:24 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC3C020738;
        Tue, 27 Oct 2020 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603833024;
        bh=NjdeQ+vCUNaMff+Zj42NKK898b5WXU5E7ZwpLNsxI24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZUHLyoqYeo0kxq3pzrosakhNdPQ3Fssqmxudvr8kQ3krHs179HqCqjRiwBbrtpxa
         yuuAz0t3lZxaUb2bVblS7bzjX7lmbstyjrKyhHH17IvwRiA1ma6ciIhTBRPsQcfEO8
         Z9swqO32NXuPft1Cpj70BOYVrMSId1wpSGqRfVCc=
Date:   Tue, 27 Oct 2020 14:10:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH v2 4/4] dm: enable may_passthrough_inline_crypto on some
 targets
Message-ID: <20201027211022.GB2416412@gmail.com>
References: <20201015214632.41951-1-satyat@google.com>
 <20201015214632.41951-5-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015214632.41951-5-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 15, 2020 at 09:46:32PM +0000, Satya Tangirala wrote:
> dm-linear and dm-flakey obviously can pass through inline crypto support.
> 
> Co-developed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  drivers/md/dm-flakey.c | 1 +
>  drivers/md/dm-linear.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/md/dm-flakey.c b/drivers/md/dm-flakey.c
> index a2cc9e45cbba..655286dacc35 100644
> --- a/drivers/md/dm-flakey.c
> +++ b/drivers/md/dm-flakey.c
> @@ -253,6 +253,7 @@ static int flakey_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	ti->num_discard_bios = 1;
>  	ti->per_io_data_size = sizeof(struct per_bio_data);
>  	ti->private = fc;
> +	ti->may_passthrough_inline_crypto = true;
>  	return 0;
>  
>  bad:
> diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
> index 00774b5d7668..345e22b9be5d 100644
> --- a/drivers/md/dm-linear.c
> +++ b/drivers/md/dm-linear.c
> @@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  	ti->num_secure_erase_bios = 1;
>  	ti->num_write_same_bios = 1;
>  	ti->num_write_zeroes_bios = 1;
> +	ti->may_passthrough_inline_crypto = true;
>  	ti->private = lc;
>  	return 0;

How about instead using a flag DM_TARGET_PASSES_CRYPTO in target_type::features,
analogous to DM_TARGET_PASSES_INTEGRITY?

- Eric
