Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CEF57F9EA
	for <lists+linux-block@lfdr.de>; Mon, 25 Jul 2022 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiGYHK2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 25 Jul 2022 03:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiGYHK0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 03:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F40229FED
        for <linux-block@vger.kernel.org>; Mon, 25 Jul 2022 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658733024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=onlISrKOwpltqPX+flGP9VcruRUveSxQFVBOAG0Sxg4=;
        b=YFgFcchj5OEDnyauQiUlRr+AOVBjy02aLwoqebxIOqsYYyeEHMVa8cgQnBcJ41tIm7qRqB
        qgbCGVmUwPr3v1X1oDKtX42D1QtPV//2hBTcJQSrh0qNAgMBldiVadnj5QOtBlWlf7Nxms
        rYELSYTz4BoKua+ZddydG8WBZXTzbGg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-392-SJr4wvRTOhOsiCtNcVg42Q-1; Mon, 25 Jul 2022 03:10:23 -0400
X-MC-Unique: SJr4wvRTOhOsiCtNcVg42Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA7B585A588;
        Mon, 25 Jul 2022 07:10:22 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8E771121314;
        Mon, 25 Jul 2022 07:10:19 +0000 (UTC)
Date:   Mon, 25 Jul 2022 15:10:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH 0/2] ublk_drv: add generic mechanism to get/set parameters
Message-ID: <Yt5B1jOu4gYVwjZa@T590>
References: <20220723150713.750369-1-ming.lei@redhat.com>
 <20220725064716.GC20796@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725064716.GC20796@lst.de>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 25, 2022 at 08:47:16AM +0200, Christoph Hellwig wrote:
> While we're at it, can we clean up how the logical block size,
> device size and max transfer size are set?
> 
> I think we can drop setting all of them from the ADD_DEV ioctl,
> as none of them is needed.  start_dev then just sets the device
> size, and everything else goes through the SET_PARAM ioctl?
 
Yeah, that is exactly the plan to cleanup all, including removing
block_size, dev_blocks and rq_max_blocks from ublksrv_ctrl_dev_info.


Thanks, 
Ming

