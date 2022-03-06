Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9BF4CE88F
	for <lists+linux-block@lfdr.de>; Sun,  6 Mar 2022 04:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiCFDfD (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 5 Mar 2022 22:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiCFDfD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 5 Mar 2022 22:35:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C0C844757
        for <linux-block@vger.kernel.org>; Sat,  5 Mar 2022 19:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646537651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pr+j4mXfAlc/ICkOtYJzzj7HLGl+1lv/qj92noE3UHI=;
        b=JCrWKqjc290kHlKe8nNW8l0fvpWvuvfigX8EFQEQZKdOP0mih1rPHziNISFwMUINaAkB1R
        LnbTdcIMAFMbcgO3h5XN9So2BkZF2B80YL7jjyFTDJZX248ktghPIqUxJzaz0mRrqixEBo
        kiuipNpf1/dUUV++RtFlE7z5Aq0VLs8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-ooNNvD4iM6yvksmY57dLCw-1; Sat, 05 Mar 2022 22:34:08 -0500
X-MC-Unique: ooNNvD4iM6yvksmY57dLCw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A41BC1800D50;
        Sun,  6 Mar 2022 03:34:06 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 026B37012A;
        Sun,  6 Mar 2022 03:33:58 +0000 (UTC)
Date:   Sun, 6 Mar 2022 11:33:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 05/14] sd: call sd_zbc_release_disk before releasing the
 scsi_device reference
Message-ID: <YiQroe4/PQReEM2G@T590>
References: <20220304160331.399757-1-hch@lst.de>
 <20220304160331.399757-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304160331.399757-6-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 04, 2022 at 05:03:22PM +0100, Christoph Hellwig wrote:
> sd_zbc_release_disk accesses disk->device, so ensure that actually still has
> a valid reference.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

