Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E806381654
	for <lists+linux-block@lfdr.de>; Sat, 15 May 2021 08:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhEOGg2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 15 May 2021 02:36:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229980AbhEOGg1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 May 2021 02:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621060514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RaQ+8lKflNIdgcSmYDETfJu5J9jaHh1izvfFpDINoro=;
        b=Nlvym8TXBnPSRaOSJN30jesREyihPpV0/Yul6qJT4s1BQ4Y15/BGTHFbZjDrFGzQ91wp8G
        BV9UD02Nski0r25h8MvrsRa6b7sCqFIlII7JimxXV44nDAedSfii9410A4rwAB0nLJhEVm
        F4GIksTkKPort3UQMt/t8X81OhnKSjI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-Ae3OxlfUOOC4W2S59FLb4Q-1; Sat, 15 May 2021 02:35:11 -0400
X-MC-Unique: Ae3OxlfUOOC4W2S59FLb4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B885801817;
        Sat, 15 May 2021 06:35:10 +0000 (UTC)
Received: from T590 (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFC13131FE;
        Sat, 15 May 2021 06:35:01 +0000 (UTC)
Date:   Sat, 15 May 2021 14:34:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, Gulam Mohamed <gulam.mohamed@oracle.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: prevent block device lookups at the beginning
 of del_gendisk
Message-ID: <YJ9rkRGG5SUyjgsg@T590>
References: <20210514131842.1600568-1-hch@lst.de>
 <20210514131842.1600568-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514131842.1600568-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 14, 2021 at 03:18:41PM +0200, Christoph Hellwig wrote:
> As an artifact of how gendisk lookup used to work in earlier kernels,
> GENHD_FL_UP is only cleared very late in del_gendisk, and a global lock
> is used to prevent opens from succeeding while del_gendisk is tearing
> down the gendisk.  Switch to clearing the flag early and under bd_mutex
> so that callers can use bd_mutex to stabilize the flag, which removes
> the need for the global mutex.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

