Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E7A5A419F
	for <lists+linux-block@lfdr.de>; Mon, 29 Aug 2022 05:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiH2D6Z (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 28 Aug 2022 23:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH2D6Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Aug 2022 23:58:24 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC27941D3B;
        Sun, 28 Aug 2022 20:58:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VNW3tRh_1661745498;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VNW3tRh_1661745498)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 11:58:20 +0800
Date:   Mon, 29 Aug 2022 11:58:16 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Re: [PATCH] Docs: ublk: add ublk document
Message-ID: <Yww5WIqBHysu0CmT@B-P7TQMD6M-0146.local>
Mail-Followup-To: "Richard W.M. Jones" <rjones@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220828045003.537131-1-ming.lei@redhat.com>
 <20220828150911.GW7484@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220828150911.GW7484@redhat.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 28, 2022 at 04:09:11PM +0100, Richard W.M. Jones wrote:

...

> > +
> > +ublk driver doesn't handle any IO logic, and its function is well defined
> > +so far, and very limited userspace interfaces are needed, and each one is
> > +well defined too, then it is very likely to make ublk device one
> > +container-ware block device in future, as Stefan Hajnoczi suggested[3], by
> > +removing ADMIN privilege.
> 
> Is it advisable for non-root to be able create arbitrary /dev devices?
> It sounds like a security nightmare because you're exposing
> potentially any arbitrary, malicious filesystem to the kernel to
> parse.

+1, such malicious daemons can also dynamically update/attack fs metadata
runtimely, I think most current fs corruption tests are for pre-built fs
images but not for runtime attack via daemon itself or network,
unprivileged daemon makes all local fses life harder.

Also for swap device use cases, malicious unprivileged daemons enlarge
the possibility of corrupting/attacking any anonymous memory (maybe
belong to privileged processes) on purpose regardless of other concerns.

Thanks,
Gao Xiang
