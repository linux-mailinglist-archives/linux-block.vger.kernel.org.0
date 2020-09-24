Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2498276577
	for <lists+linux-block@lfdr.de>; Thu, 24 Sep 2020 02:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgIXA44 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 23 Sep 2020 20:56:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726572AbgIXA44 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 20:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600909015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31qQ9q1/STA/QmkIuu+mwGgqJ664JXpjEXNoWEZn0Ys=;
        b=IaLKyP++ooTKQ9iYtjKYulbV7zG2t/qVM3DmhfvjLXALBaug2/OpC5WNGJEpRZ2p0zvL7U
        r8Qv8opEsr2jmoiLYmvB45rQBXb2laj8CFsmPn3iPIsMtxk2/1Kc1Nr9Tn4UvcRUOJBE6y
        3csvlSVJN5WPm8D2XVfHRPP1R5l1xMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-Y1gWnueJOSmyAZ-VVb9FQA-1; Wed, 23 Sep 2020 20:56:53 -0400
X-MC-Unique: Y1gWnueJOSmyAZ-VVb9FQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D67571DE15;
        Thu, 24 Sep 2020 00:56:51 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECB175C1C7;
        Thu, 24 Sep 2020 00:56:47 +0000 (UTC)
Date:   Wed, 23 Sep 2020 20:56:47 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Miaohe Lin <linmiaohe@huawei.com>, dm-devel@redhat.com,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v2 1/3] block: make bio_crypt_clone() able to fail
Message-ID: <20200924005647.GB10500@redhat.com>
References: <20200916035315.34046-1-ebiggers@kernel.org>
 <20200916035315.34046-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916035315.34046-2-ebiggers@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 15 2020 at 11:53pm -0400,
Eric Biggers <ebiggers@kernel.org> wrote:

> From: Eric Biggers <ebiggers@google.com>
> 
> bio_crypt_clone() assumes its gfp_mask argument always includes
> __GFP_DIRECT_RECLAIM, so that the mempool_alloc() will always succeed.
> 
> However, bio_crypt_clone() might be called with GFP_ATOMIC via
> setup_clone() in drivers/md/dm-rq.c, or with GFP_NOWAIT via
> kcryptd_io_read() in drivers/md/dm-crypt.c.
> 
> Neither case is currently reachable with a bio that actually has an
> encryption context.  However, it's fragile to rely on this.  Just make
> bio_crypt_clone() able to fail, analogous to bio_integrity_clone().
> 
> Reported-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Satya Tangirala <satyat@google.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>

