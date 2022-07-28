Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9645F583C28
	for <lists+linux-block@lfdr.de>; Thu, 28 Jul 2022 12:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiG1Kha (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 28 Jul 2022 06:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiG1Kh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 06:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69D94558E3
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659004647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Pt9UGM5sL/4q0ANiVGEpiameCcnFg9RmfFRb3A4csQ=;
        b=TwQBuQnaNyNysxGYXKHoNkRXruKxj23kYrj8twKso/9q9N4bR6HsD0Y129beqFpY/1Ak6T
        gh5TCau/e+kz25iDmp3uNqxLZaA3Iw3fVX9Q5jDaeSlQMqV6pfb3jWSK95MRyam1fV+MmR
        9C8ax9vp+MJxJ7IX9wTbqyyVKwASioA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-PFn0PLCzPhKyfBGYZqHKzQ-1; Thu, 28 Jul 2022 06:37:26 -0400
X-MC-Unique: PFn0PLCzPhKyfBGYZqHKzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88D45280049C;
        Thu, 28 Jul 2022 10:37:25 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A307918EB5;
        Thu, 28 Jul 2022 10:37:21 +0000 (UTC)
Date:   Thu, 28 Jul 2022 18:37:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [PATCH V3 1/2] ublk_cmd.h: add one new ublk command:
 UBLK_IO_NEED_GET_DATA
Message-ID: <YuJm3eJpLPH+XUB1@T590>
References: <cover.1658999030.git.ZiyangZhang@linux.alibaba.com>
 <bc8848ba3de5a9c75b8eeb638a95999921d11596.1658999030.git.ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8848ba3de5a9c75b8eeb638a95999921d11596.1658999030.git.ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 28, 2022 at 05:31:23PM +0800, ZiyangZhang wrote:
> Add one new ublk command: UBLK_IO_NEED_GET_DATA. It is prepared for a new
> feature designed for a user application who wants to allocate IO buffer
> and set IO buffer address only after it receives an IO request from
> ublksrv.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

