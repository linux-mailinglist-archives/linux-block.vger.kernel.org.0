Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF375E015
	for <lists+linux-block@lfdr.de>; Sun, 23 Jul 2023 08:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGWGcM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 23 Jul 2023 02:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWGcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Jul 2023 02:32:12 -0400
X-Greylist: delayed 451 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Jul 2023 23:32:08 PDT
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39671BD8
        for <linux-block@vger.kernel.org>; Sat, 22 Jul 2023 23:32:08 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 17E068356D;
        Sun, 23 Jul 2023 02:24:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1690093476; bh=/eHC6WOxgAZGwc8tJFiPdsG6pcm1JR1vRJJA0J5xY6w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cutynh1tWmIsI0jxai2a7QXiWVBOTRcyDzpCTn2TyhD4Of5yqq6aq8gG26VDP9Iju
         g3TDnpJ3uFOMsL+dYSFn8TF1EW+dBRUgBOthLw/flKOttrxzvE8DEyGhBi9fRTW6GH
         jq+0YiBwRuV8uBARn4weA2sYjHP7bw5dr9LR6e4/lKb/AyiHdoJqMbjeeI/VfMugfF
         CU8L3FYOUr6cwtOmO22rnSn9n2dDIbulN8mNLDWg+BzAZfdMma2xYJDRhFfear6fUT
         3pLHoBdSAo7Tjtthe7BIdp46C1BB0S0QC4WmF+onEEExLTtgHjQM0KzfdsmClR5gxp
         MuQKyapL9Vw7A==
Message-ID: <509f4916-a95f-216e-b0ab-7b7a108a48a0@dorminy.me>
Date:   Sun, 23 Jul 2023 02:24:32 -0400
MIME-Version: 1.0
Subject: Re: [vdo-devel] [PATCH v2 00/39] Add the dm-vdo deduplication and
 compression device mapper target.
Content-Language: en-US
To:     Kenneth Raeburn <raeburn@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     linux-block@vger.kernel.org, vdo-devel@redhat.com,
        dm-devel@redhat.com, ebiggers@kernel.org, tj@kernel.org
References: <20230523214539.226387-1-corwin@redhat.com>
 <ZLa086NuWiMkJKJE@redhat.com>
 <CAK1Ur396ThV5AAZx2336uAW3FqSY+bHiiwEPofHB_Kwwr4ag5A@mail.gmail.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <CAK1Ur396ThV5AAZx2336uAW3FqSY+bHiiwEPofHB_Kwwr4ag5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> We use a sort of message-passing arrangement where a worker thread is 
> responsible for updating certain data structures as needed for the I/Os 
> in progress, rather than having the processing of each I/O contend for 
> locks on the data structures.  It gives us some good throughput under load but it does mean upwards of a dozen handoffs per 4kB write, depending on compressibility, whether the block is a duplicate, and various other factors. So processing 1 GB/s means handling over 3M messages per second, though each step of processing is generally lightweight. 

  There seems a natural duality between
work items passing between threads, each exclusively owning a structure, 
vs structures passing between threads, each exclusively owning a work 
item. In the first, the threads are grabbing a notional 'lock' on each 
item in turn to deal with their structure, as VDO does now; in the 
second, the threads are grabbing locks on each structure in turn to deal 
with their item.

If kernel workqueues have higher overhead per item for the lightweight 
work VDO currently does in each step, perhaps the dual of the current 
scheme would let more work get done per fixed queuing overhead, and thus 
perform better? VIOs could take locks on sections of structures, and 
operate on multiple structures before requeueing.

This might also enable more finegrained locking of structures than the 
chunks uniquely owned by threads at the moment. It would also be 
attractive to let the the kernel work queues deal with concurrency 
management instead of configuring the number of threads for each of a 
bunch of different structures at start time.

On the other hand, I played around with switching messagepassing to 
structurelocking in VDO a number of years ago for fun on the side, just 
extremely naively replacing each message passing with releasing a mutex 
on the current set of structures and (trying to) take a mutex on the 
next set of structures, and ran into some complexity around certain 
ordering requirements. I think they were around recovery journal entries 
going into the slab journal and the block map in the same order; and 
also around the use of different priorities for some different items. I 
don't have that code anymore, unfortunately, so I don't know how hard it 
would be to try that experiment again.

Sweet Tea
