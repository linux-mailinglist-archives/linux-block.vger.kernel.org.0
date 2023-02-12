Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6482A693743
	for <lists+linux-block@lfdr.de>; Sun, 12 Feb 2023 13:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBLMTl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 12 Feb 2023 07:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBLMTl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Feb 2023 07:19:41 -0500
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942431AD;
        Sun, 12 Feb 2023 04:19:39 -0800 (PST)
Received: from [192.168.1.103] (31.173.85.253) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.14; Sun, 12 Feb
 2023 15:19:29 +0300
Subject: Re: [PATCH 02/12] pata_parport: Introduce module_pata_parport_driver
 macro
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, <linux-block@vger.kernel.org>,
        <linux-parport@lists.infradead.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230211144232.15138-1-linux@zary.sk>
 <20230211144232.15138-3-linux@zary.sk>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <2e8b5e5b-6e7d-471c-74aa-1c7debebef0f@omp.ru>
Date:   Sun, 12 Feb 2023 15:19:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230211144232.15138-3-linux@zary.sk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [31.173.85.253]
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.59, Database issued on: 02/12/2023 11:56:24
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 175455 [Feb 12 2023]
X-KSE-AntiSpam-Info: Version: 5.9.59.0
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 502 502 69dee8ef46717dd3cb3eeb129cb7cc8dab9e30f6
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.85.253 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.85.253
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/12/2023 11:58:00
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/12/2023 9:38:00 AM
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/23 5:42 PM, Ondrej Zary wrote:

> Introduce module_pata_parport_driver macro and use it in protocol
> drivers to reduce boilerplate code. Remove paride_(un)register
> compatibility defines.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>
[...]

> diff --git a/drivers/ata/pata_parport/bpck6.c b/drivers/ata/pata_parport/bpck6.c
> index d897e2a28efe..3c358e66db25 100644
> --- a/drivers/ata/pata_parport/bpck6.c
> +++ b/drivers/ata/pata_parport/bpck6.c
> @@ -245,23 +245,8 @@ static struct pi_protocol bpck6 = {
>  	.release_proto	= bpck6_release_proto,
>  };
>  
> -static int __init bpck6_init(void)
> -{
> -	printk(KERN_INFO "bpck6: BACKPACK Protocol Driver V"BACKPACK_VERSION"\n");
> -	printk(KERN_INFO "bpck6: Copyright 2001 by Micro Solutions, Inc., DeKalb IL. USA\n");
> -	if(verbose)
> -		printk(KERN_DEBUG "bpck6: verbose debug enabled.\n");

   Hm, perhaps should've been removed in a separate patch?

[...]
> diff --git a/drivers/ata/pata_parport/epat.c b/drivers/ata/pata_parport/epat.c
> index 6ce2dee7657f..eb72bcd0c8da 100644
> --- a/drivers/ata/pata_parport/epat.c
> +++ b/drivers/ata/pata_parport/epat.c
> @@ -327,12 +327,12 @@ static int __init epat_init(void)
>  #ifdef CONFIG_PARIDE_EPATC8

   Hm, this is now called PATA_PARPORT_EPATC8, no?

>  	epatc8 = 1;

   Seems like a dead code?

>  #endif
[...]

MBR, Sergey
