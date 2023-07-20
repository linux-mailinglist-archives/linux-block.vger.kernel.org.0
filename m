Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744C175A97C
	for <lists+linux-block@lfdr.de>; Thu, 20 Jul 2023 10:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGTIlO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 20 Jul 2023 04:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjGTIah (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jul 2023 04:30:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2174BFD
        for <linux-block@vger.kernel.org>; Thu, 20 Jul 2023 01:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QC9DirWmKDSO1e/ljLAnzvbzTAa+Sx967kBwtx0OJ4E=; b=rI68IIqs4q3Kf8pVwYkd8Lmltv
        33dJnkE9N4auSov1R9C96SOUyeZ3mdN2irgt9d9bYsbLgxsCayi+OpCex8sOeaZkZWnD/9/NZa4Hw
        RX3uTXAKr7QQMlGMbl3Nk4nb/NPHcTEWITsdBiBJfTTiV9vKkf3VntQosPhl653ru1Q4Tp47Fr+j6
        cm/4UUt+M8RUgOoIpuBEIC8k6oF3Gn/Ilb08HKGk1z0Wx2LRPbexNdeRdatrRVJ57OfJlinB/XWCO
        8IXFaSTA+VuIp4qtdxQJwCpPPs6tjHrkj2hgnqaI6EH4weeGHQRK5SIlmGiweNKVcdW/mnPEmsupp
        A4XUdZsA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMP3U-00AJpb-16;
        Thu, 20 Jul 2023 08:30:36 +0000
Date:   Thu, 20 Jul 2023 01:30:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>
Subject: Re: [PATCH RESEND 1/2] loop: deprecate autoloading callback
 loop_probe()
Message-ID: <ZLjwrNntqIEb7QQe@infradead.org>
References: <20230717191628.582363-1-mfo@canonical.com>
 <20230717191628.582363-2-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717191628.582363-2-mfo@canonical.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 17, 2023 at 04:16:27PM -0300, Mauricio Faria de Oliveira wrote:
> The 'probe' callback in __register_blkdev() is only used
> under the CONFIG_BLOCK_LEGACY_AUTOLOAD deprecation guard.
> 
> The loop_probe() function is only used for that callback,
> so guard it too, accordingly.
> 
> See commit fbdee71bb5d8 ("block: deprecate autoloading based on dev_t").
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> ---
>  drivers/block/loop.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 37511d2b2caf..7268ff71c92c 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2093,6 +2093,7 @@ static void loop_remove(struct loop_device *lo)
>  	put_disk(lo->lo_disk);
>  }
>  
> +#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
>  static void loop_probe(dev_t dev)
>  {
>  	int idx = MINOR(dev) >> part_shift;
> @@ -2101,6 +2102,7 @@ static void loop_probe(dev_t dev)
>  		return;
>  	loop_add(idx);
>  }
> +#endif

Turn this into..

#else
#define loop_probe	NULL
#endif /* !CONFIG_BLOCK_LEGACY_AUTOLOAD */

and you can skip the pretty ugly second hunk.

