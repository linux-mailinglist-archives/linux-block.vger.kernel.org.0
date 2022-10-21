Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9BE606D60
	for <lists+linux-block@lfdr.de>; Fri, 21 Oct 2022 04:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJUCCM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Oct 2022 22:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiJUCCJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 22:02:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61131EEA18
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 19:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666317725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g7aHMjfc6+v+JPibLxPGhaDqSlu1GgV9Rxa5oIrSaP4=;
        b=b0fJlG14mIiKsizFJgHRX8j8GdAP88qBXlF2y7nnjMIZPRA/YNGh1PAsWf6PVdzcItFTwL
        Tf4mzh9H7PIEcg+xo643DYa56qC/N1DKA8WdrDCES241MHNLms1S41uVgWJdirRiUU2BIQ
        WWHqFpLvF1i+vJjRiPsclYxaYfQ3YuI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-_A8nWDcsN_KulZ07tOCh3A-1; Thu, 20 Oct 2022 22:02:01 -0400
X-MC-Unique: _A8nWDcsN_KulZ07tOCh3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B96B2101A5AD;
        Fri, 21 Oct 2022 02:02:00 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CCEC62166B33;
        Fri, 21 Oct 2022 02:01:53 +0000 (UTC)
Date:   Fri, 21 Oct 2022 10:01:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 02/10] block: Constify most queue limits pointers
Message-ID: <Y1H9ivAaE1megy67@T590>
References: <20221019222324.362705-1-bvanassche@acm.org>
 <20221019222324.362705-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019222324.362705-3-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 19, 2022 at 03:23:16PM -0700, Bart Van Assche wrote:
> Document which functions do not modify the queue limits.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/blk-map.c      |  2 +-
>  block/blk-merge.c    | 29 ++++++++++++++++-------------
>  block/blk-settings.c |  6 +++---
>  block/blk.h          | 11 ++++++-----
>  4 files changed, 26 insertions(+), 22 deletions(-)

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

