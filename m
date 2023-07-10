Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF75274D12C
	for <lists+linux-block@lfdr.de>; Mon, 10 Jul 2023 11:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGJJPT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 Jul 2023 05:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjGJJPS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2023 05:15:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81FA8E
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2023 02:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688980472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ZxZGq4D+R9v/uHRHPVTjCJO+HqCh9drWSD3QE0wPss=;
        b=gq18U63a8jWewdJu02mmdWb9YgJwiViLwJ3P0dqwX4qINFYBNcMkr1PQ8J5hc+ttBNsMcu
        ZoKcEznhDX0wniPkn460XRYlGFNlkABXxMTpdWxVST13WKFrUsti8ZI0SY7aBUAnH2/8RW
        kHwGRTZk1hr1MIGmID53ZFkAD+0Vk8k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-dq1Pi2d5OE2_NXrRq89yKg-1; Mon, 10 Jul 2023 05:14:28 -0400
X-MC-Unique: dq1Pi2d5OE2_NXrRq89yKg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 358492A59568;
        Mon, 10 Jul 2023 09:14:28 +0000 (UTC)
Received: from ovpn-8-31.pek2.redhat.com (ovpn-8-33.pek2.redhat.com [10.72.8.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 427E32017DCB;
        Mon, 10 Jul 2023 09:14:19 +0000 (UTC)
Date:   Mon, 10 Jul 2023 17:14:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] nvme-pci: use blk_mq_max_nr_hw_queues() to calculate
 io queues
Message-ID: <ZKvL58L58rY3GWnt@ovpn-8-31.pek2.redhat.com>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
 <20230708020259.1343736-3-ming.lei@redhat.com>
 <20230710064109.GB24519@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710064109.GB24519@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 10, 2023 at 08:41:09AM +0200, Christoph Hellwig wrote:
> On Sat, Jul 08, 2023 at 10:02:59AM +0800, Ming Lei wrote:
> > Take blk-mq's knowledge into account for calculating io queues.
> > 
> > Fix wrong queue mapping in case of kdump kernel.
> > 
> > On arm and ppc64, 'maxcpus=1' is passed to kdump command line, see
> > `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> > still returns all CPUs.
> 
> That's simply broken.  Please fix the arch code to make sure
> it does not return a bogus num_possible_cpus value for these

That is documented in Documentation/admin-guide/kdump/kdump.rst.

On arm and ppc64, 'maxcpus=1' is passed for kdump kernel, and "maxcpu=1"
simply keep one of CPU cores as online, and others as offline.

So Cc our arch(arm & ppc64) & kdump guys wrt. passing 'maxcpus=1' for
kdump kernel.

> setups, otherwise you'll have to paper over it in all kind of
> drivers.

The issue is only triggered for drivers which use managed irq &
multiple hw queues.


Thanks,
Ming

