Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DB22DF6AB
	for <lists+linux-block@lfdr.de>; Sun, 20 Dec 2020 20:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgLTThg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-block@lfdr.de>); Sun, 20 Dec 2020 14:37:36 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20435 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbgLTThg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Dec 2020 14:37:36 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-258-etBc06yiPzKTMw-Lqw-vPw-1; Sun, 20 Dec 2020 19:35:56 +0000
X-MC-Unique: etBc06yiPzKTMw-Lqw-vPw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 20 Dec 2020 19:35:54 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 20 Dec 2020 19:35:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Amey Narkhede' <ameynarkhede03@gmail.com>,
        "justin@coraid.com" <justin@coraid.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] block: aoe: replace use of __constant_htons to htons
Thread-Topic: [PATCH] block: aoe: replace use of __constant_htons to htons
Thread-Index: AQHW1vAHBqUXkIF40UC4A8T++dsZC6oAYGdw
Date:   Sun, 20 Dec 2020 19:35:54 +0000
Message-ID: <d708db73308747feb0484287a09c443e@AcuMS.aculab.com>
References: <20201220164625.94105-1-ameynarkhede03@gmail.com>
In-Reply-To: <20201220164625.94105-1-ameynarkhede03@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Amey Narkhede
> Sent: 20 December 2020 16:46
> 
> The macro htons expands to __swab16 which has special
> case for constants in little endian case. In big
> endian case both __constant_htons and htons macros
> expand to the same code. So, replace __constant_htons
> with htons to get rid of the definition of __constant_htons
> completely.
> 
...
>  static struct packet_type aoe_pt __read_mostly = {
> -	.type = __constant_htons(ETH_P_AOE),
> +	.type = htons(ETH_P_AOE),
>  	.func = aoenet_rcv,

Does this cause grief if someone is doing a COMPILE_TEST on LE?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

