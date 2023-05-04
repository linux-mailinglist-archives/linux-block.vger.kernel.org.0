Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8507B6F6DD8
	for <lists+linux-block@lfdr.de>; Thu,  4 May 2023 16:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjEDOk2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 May 2023 10:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEDOk1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 10:40:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14945118
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 07:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683211199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qNvfYNf7RID1m406M40A6JjHQdIvWallHiWKlOcnlGU=;
        b=e1BI3O4vHiCvQLy+JFaoQhBzOkhxUYerUJpT9Ay/DkZvyI2TNzX5Rc+EGN13x2xKmX+m2s
        Akus6HD0PwDicNxubTxZ1525lUBoh0dd2eQgLMbrM1z/N6Wy/dqayczvdltXr8fqa1Lm1y
        o986S/k9rUwjqIlbDjRfSD+MPrD81ZQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-ktWtk1_JOk-mJpUN8m4EAQ-1; Thu, 04 May 2023 10:39:57 -0400
X-MC-Unique: ktWtk1_JOk-mJpUN8m4EAQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3131884371;
        Thu,  4 May 2023 14:39:39 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F7E7492C18;
        Thu,  4 May 2023 14:39:33 +0000 (UTC)
Date:   Thu, 4 May 2023 22:39:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        asml.silence@gmail.com, hch@lst.de, axboe@kernel.dk, leit@fb.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        sagi@grimberg.me, joshi.k@samsung.com, kbusch@kernel.org
Subject: Re: [PATCH v4 1/3] io_uring: Create a helper to return the SQE size
Message-ID: <ZFPDoI8fw0W0A/ZC@ovpn-8-16.pek2.redhat.com>
References: <20230504121856.904491-1-leitao@debian.org>
 <20230504121856.904491-2-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504121856.904491-2-leitao@debian.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 04, 2023 at 05:18:54AM -0700, Breno Leitao wrote:
> Create a simple helper that returns the size of the SQE. The SQE could
> have two size, depending of the flags.
> 
> If IO_URING_SETUP_SQE128 flag is set, then return a double SQE,
> otherwise returns the sizeof of io_uring_sqe (64 bytes).
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

