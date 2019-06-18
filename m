Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59E26497D1
	for <lists+linux-block@lfdr.de>; Tue, 18 Jun 2019 05:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbfFRDnA (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 17 Jun 2019 23:43:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52928 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbfFRDnA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 23:43:00 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hd51A-0001Hk-N6; Tue, 18 Jun 2019 11:42:44 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hd516-0004RQ-Ap; Tue, 18 Jun 2019 11:42:40 +0800
Date:   Tue, 18 Jun 2019 11:42:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, drbd-dev@lists.linbit.com,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drbd: dynamically allocate shash descriptor
Message-ID: <20190618034240.m4cnyjsbe4txth72@gondor.apana.org.au>
References: <20190617132440.2721536-1-arnd@arndb.de>
 <20190617144335.q243r7l7ox7galhl@gondor.apana.org.au>
 <CAK8P3a2g4ZDcyxuSOkYzOmqV3Hc3YF3Anc3GQysvGo9bijYufQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2g4ZDcyxuSOkYzOmqV3Hc3YF3Anc3GQysvGo9bijYufQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 17, 2019 at 10:58:58PM +0200, Arnd Bergmann wrote:
>
> The warning is gone with this patch. Instead of 1280 bytes for drbd_receiver,
> I now see 512 bytes, and 768 bytes for drbd_get_response, everything else is
> under 160 bytes in this file.
> 
> However, with the call chain of
> 
> drbd_receiver
>    conn_connect
>        drbd_do_auth
>              drbd_get_response
> 
> This still adds up to as much as before, so it only shuts up the
> warning but does not reduce the maximum stack usage.

OK so it doesn't really reduce it.  Let's just go with your patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
