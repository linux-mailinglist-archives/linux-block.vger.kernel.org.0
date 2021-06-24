Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD0B3B29C0
	for <lists+linux-block@lfdr.de>; Thu, 24 Jun 2021 09:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhFXHzU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 24 Jun 2021 03:55:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50036 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhFXHzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 03:55:20 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DAB331FD54;
        Thu, 24 Jun 2021 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624521180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yRvGEsBDZaGHMG91LKznyhOZXFu6ZZcGZx2TsWs/TI=;
        b=yZjcwsldGeVjDRMpP7beZHgDhEwbcC53cpVXC0KXLmYQEAYsCK9Sv8m77RF67fQYyhm4xR
        uVFzRPInqgISLOYltkQ5Ukb7TQMTFCWr54Z+BVuGCrXP/eZGNSgnOV62LbnCQ1ZSY7cx16
        cw+gxThLJroRkUIUX6HKVeZ2yupBVZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624521180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yRvGEsBDZaGHMG91LKznyhOZXFu6ZZcGZx2TsWs/TI=;
        b=s40w/k4uqJNMD8lsUyicoKc/3v3phwO0FUtUol0h2OzDKqUcRcO1ZX8GA4BDlhRIIB7SPe
        iMideyRqM1MOMgCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C5A1111A97;
        Thu, 24 Jun 2021 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624521180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yRvGEsBDZaGHMG91LKznyhOZXFu6ZZcGZx2TsWs/TI=;
        b=yZjcwsldGeVjDRMpP7beZHgDhEwbcC53cpVXC0KXLmYQEAYsCK9Sv8m77RF67fQYyhm4xR
        uVFzRPInqgISLOYltkQ5Ukb7TQMTFCWr54Z+BVuGCrXP/eZGNSgnOV62LbnCQ1ZSY7cx16
        cw+gxThLJroRkUIUX6HKVeZ2yupBVZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624521180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6yRvGEsBDZaGHMG91LKznyhOZXFu6ZZcGZx2TsWs/TI=;
        b=s40w/k4uqJNMD8lsUyicoKc/3v3phwO0FUtUol0h2OzDKqUcRcO1ZX8GA4BDlhRIIB7SPe
        iMideyRqM1MOMgCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id AebmL9w51GBMDQAALh3uQQ
        (envelope-from <hare@suse.de>); Thu, 24 Jun 2021 07:53:00 +0000
Subject: Re: [PATCH 1/2] block: move the disk events code to a separate file
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
References: <20210624073843.251178-1-hch@lst.de>
 <20210624073843.251178-2-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <23b45c88-a968-9c8e-d111-22aea6e81827@suse.de>
Date:   Thu, 24 Jun 2021 09:53:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210624073843.251178-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/24/21 9:38 AM, Christoph Hellwig wrote:
> Move the code for handling disk events from genhd.c into a new file
> as it isn't very related to the rest of the file while at the same
> time requiring lots of forward declarations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/Makefile      |   3 +-
>  block/blk.h         |   5 +
>  block/disk-events.c | 484 +++++++++++++++++++++++++++++++++++++++++++
>  block/genhd.c       | 492 --------------------------------------------
>  4 files changed, 491 insertions(+), 493 deletions(-)
>  create mode 100644 block/disk-events.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
