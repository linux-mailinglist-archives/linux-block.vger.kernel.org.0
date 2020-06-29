Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1606520D673
	for <lists+linux-block@lfdr.de>; Mon, 29 Jun 2020 22:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbgF2TUS (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 29 Jun 2020 15:20:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:33182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732105AbgF2TUR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 15:20:17 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 033B82559A;
        Mon, 29 Jun 2020 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593449521;
        bh=lAWJH6y2JHj7l3WROnIUTbAtWV6gbRyKvK+nJkOMGac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oR2Fa16jrQK3sMyMD5a6gGmQM7P77YD+h8hX8rj3ASdSIYAXXX02sL3PQmhSOOM0N
         D6G2X8WiBIyh7uOl2qxS5BAWBdAhdiw2UQzz+zVfObp3FFeTajZ589ADx9CXvZnhLd
         PcsBL9h1xaeN/tSw7v8b84c2PWQKyXxjfrn11Gug=
Date:   Mon, 29 Jun 2020 09:51:59 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH] block/keyslot-manager: use kvfree_sensitive()
Message-ID: <20200629165159.GB20492@sol.localdomain>
References: <20200616155654.191263-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616155654.191263-1-ebiggers@kernel.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 16, 2020 at 08:56:54AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make blk_ksm_destroy() use the kvfree_sensitive() function (which was
> introduced in v5.8-rc1) instead of open-coding it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  block/keyslot-manager.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index c2ef41b3147b..35abcb1ec051 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -374,8 +374,7 @@ void blk_ksm_destroy(struct blk_keyslot_manager *ksm)
>  	if (!ksm)
>  		return;
>  	kvfree(ksm->slot_hashtable);
> -	memzero_explicit(ksm->slots, sizeof(ksm->slots[0]) * ksm->num_slots);
> -	kvfree(ksm->slots);
> +	kvfree_sensitive(ksm->slots, sizeof(ksm->slots[0]) * ksm->num_slots);
>  	memzero_explicit(ksm, sizeof(*ksm));
>  }
>  EXPORT_SYMBOL_GPL(blk_ksm_destroy);
> -- 

Ping?
