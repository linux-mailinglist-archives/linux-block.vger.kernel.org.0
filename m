Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD3D6933C4
	for <lists+linux-block@lfdr.de>; Sat, 11 Feb 2023 21:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjBKUr5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 11 Feb 2023 15:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBKUr4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Feb 2023 15:47:56 -0500
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1C8017CEE;
        Sat, 11 Feb 2023 12:47:54 -0800 (PST)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id C8A877A0308;
        Sat, 11 Feb 2023 21:47:53 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 03/12] pata_parport: remove devtype from struct pi_adapter
Date:   Sat, 11 Feb 2023 21:47:50 +0100
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230211144232.15138-1-linux@zary.sk> <20230211144232.15138-4-linux@zary.sk> <909afe94-d786-a94c-5142-818e540705cc@omp.ru>
In-Reply-To: <909afe94-d786-a94c-5142-818e540705cc@omp.ru>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202302112147.50725.linux@zary.sk>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Saturday 11 February 2023 20:11:06 Sergey Shtylyov wrote:
> On 2/11/23 5:42 PM, Ondrej Zary wrote:
> 
> > Only bpck driver uses devtype but it never gets set in pata_parport.
> > Remove it.
> > 
> > Signed-off-by: Ondrej Zary <linux@zary.sk>
> > ---
> >  drivers/ata/pata_parport/bpck.c | 2 +-
> >  include/linux/pata_parport.h    | 3 ---
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
> > index b9174cf8863c..451a068fe28a 100644
> > --- a/drivers/ata/pata_parport/bpck.c
> > +++ b/drivers/ata/pata_parport/bpck.c
> > @@ -241,7 +241,7 @@ static void bpck_connect ( PIA *pi  )
> >  
> >  	WR(5,8);
> >  
> > -	if (pi->devtype == PI_PCD) {
> > +	if (1 /*pi->devtype == PI_PCD*/) {	/* FIXME */
> >  		WR(0x46,0x10);		/* fiddle with ESS logic ??? */
> 
>    Why not drop this entire *if* stmt? 

I decided to keep it (for now) as a marker of a possible bug. I currently don't have HW to test this driver.

> 
> >  		WR(0x4c,0x38);
> >  		WR(0x4d,0x88);
> [...]
> 
> MBR, Sergey
> 


-- 
Ondrej Zary
