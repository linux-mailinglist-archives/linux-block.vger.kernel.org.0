Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F2F72B521
	for <lists+linux-block@lfdr.de>; Mon, 12 Jun 2023 03:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjFLBh2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 11 Jun 2023 21:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFLBh1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Jun 2023 21:37:27 -0400
Received: from out-20.mta0.migadu.com (out-20.mta0.migadu.com [IPv6:2001:41d0:1004:224b::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4111B3
        for <linux-block@vger.kernel.org>; Sun, 11 Jun 2023 18:37:26 -0700 (PDT)
Message-ID: <8059fd70-f4ac-a1db-47e9-4a44715ec1be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686533844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfN5YFsFlBI8yxKCqg3ffjSu6YhY++hBq7YbqlxkGg4=;
        b=WeorYBZ1pHEMqezRZdeualYsBbGM4XWx/Lg9NM+jf4TQqOlM9HZhXo+LwTb16drbSYI0Xv
        IF40yCumWERimJIoSLS63xNxq+C0jLaD+ZfC4ZvWVLPdJaIHeZjN6rQ0sKcg9ISUHIxuWF
        ZRc6GHE1hbzAltnW7nnyd+65oiEFGZQ=
Date:   Mon, 12 Jun 2023 09:37:17 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCH V2 0/8] misc patches for rnbd
To:     axboe@kernel.dk
Cc:     jinpu.wang@ionos.com, haris.iqbal@ionos.com,
        linux-block@vger.kernel.org
References: <20230524070026.2932-1-guoqing.jiang@linux.dev>
Content-Language: en-US
In-Reply-To: <20230524070026.2932-1-guoqing.jiang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Jack had acked all the patches, could you merge this series?

Thanks,
Guoqing

On 5/24/23 15:00, Guoqing Jiang wrote:
> V2 changes:
> 1. two patches are dropped
> 2. collect tags from Jack
> 3. replace "int mode" with "enum rnbd_access_mode" in the 3rd one
>
> Hi,
>
> This series mostly do cleanup and other trival things, pls review.
>
> Thanks,
> Guoqing
>
> Guoqing Jiang (8):
>    block/rnbd: kill rnbd_flags_supported
>    block/rnbd-srv: remove unused header
>    block/rnbd: introduce rnbd_access_modes
>    block/rnbd-srv: no need to check sess_dev
>    block/rnbd-srv: rename one member in rnbd_srv_dev
>    block/rnbd-srv: init ret with 0 instead of -EPERM
>    block/rnbd-srv: init err earlier in rnbd_srv_init_module
>    block/rnbd-srv: make process_msg_sess_info returns void
>
>   drivers/block/rnbd/Makefile         |  6 ++--
>   drivers/block/rnbd/rnbd-clt-sysfs.c |  4 +--
>   drivers/block/rnbd/rnbd-common.c    | 23 ---------------
>   drivers/block/rnbd/rnbd-proto.h     | 31 ++++++--------------
>   drivers/block/rnbd/rnbd-srv-sysfs.c |  3 +-
>   drivers/block/rnbd/rnbd-srv.c       | 44 +++++++++++++----------------
>   drivers/block/rnbd/rnbd-srv.h       |  2 +-
>   7 files changed, 34 insertions(+), 79 deletions(-)
>   delete mode 100644 drivers/block/rnbd/rnbd-common.c
>

