Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21D95DC7E
	for <lists+linux-block@lfdr.de>; Wed,  3 Jul 2019 04:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfGCC03 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jul 2019 22:26:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26322 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfGCC03 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 22:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562120789; x=1593656789;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uYXP/tvfkePzVLr9b/gED5alltN7mwDdJmPo++BSBIo=;
  b=ifO7+UNp9/MdJvJlcoFxQO6L/TN11emSiR8XfSpfwm7Ejxe/xiJ4IpdY
   fZMBFj3MWRtTkFZuiZhQhn5FLoaB/YUwS13I3iKvR6dt+GCe9bDxSJoj/
   kdp3LRVgHirINbnuErLnx0TILA+V+ZUUhev1fHdHOkXz/pG3K8WwST+bo
   2ugEqY2R80qUCtC/vesAEZkK9aZ3pBl53MUCkAVheH3YZTshVw5s0s31H
   gph0Bca8+VR8DS75NsNDCMP3XPYkSFOhQLBhyRO+wIBjvd1j/7s1iAotY
   9fMyM43uJFao+dHLVnTBabiLS7p++FK0jhF88m7Vo7i2nsr6x2LWvmf/l
   w==;
IronPort-SDR: 2ZUgImMyQQwY3lsU/9/Qi9Q9CXfhdO2+2lQfbsgx85AmrkcXkL7MSvWA5SUCE8I/t8JP+9Bcyt
 iVkKsUbHERj5KWjfIBe5NR0oqwxJf18KVijY5rV2JBy3ZgkwmL9hK7l7pF+wtT+ZrNJig9zChx
 R+tx+Ujmwkuzl5zgddu6Yi0iSVrer4ZXJWyHk/9ZWuFAQqQ0XfGr0Jb2U4g0+CinTjDK7NKyN8
 UlygvOyogwBgAZI6Edy9QYa6LYzMpUio/N1uLyhm7iFgTF0CprVfepCDPdV76hrGwlHrhGsh3C
 cBA=
X-IronPort-AV: E=Sophos;i="5.63,445,1557158400"; 
   d="scan'208";a="113721372"
Received: from mail-dm3nam05lp2053.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.53])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2019 10:26:25 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cibTOPyzBfTBhtqterbni9+jlviX1pH2JSCCe5oKGLU=;
 b=JwBNFhqwidnVt2ZoJqWed9zWo6kPEsmlin//5hRk2J2xix7xpfHXhs0cHe0D9nnL03rHnCyfDC6MuwNqdCTtYmIo+BENtCewztSY7WfZCGnCh8vg6UAqlOVTpdSNSQ1NzOwptZIb4EPlFlLHWi++UJjUeHgxJQfCdHpc59KlhH0=
Received: from DM6PR04MB5754.namprd04.prod.outlook.com (20.179.52.22) by
 DM6PR04MB5388.namprd04.prod.outlook.com (20.178.27.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Wed, 3 Jul 2019 02:26:22 +0000
Received: from DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::a07d:d226:c10f:7211]) by DM6PR04MB5754.namprd04.prod.outlook.com
 ([fe80::a07d:d226:c10f:7211%6]) with mapi id 15.20.2052.010; Wed, 3 Jul 2019
 02:26:22 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH 3/5] block: allow block_dump to print all REQ_OP_XXX
Thread-Topic: [PATCH 3/5] block: allow block_dump to print all REQ_OP_XXX
Thread-Index: AQHVMFgLgX/VuwLWwEqQgqcXWabmgA==
Date:   Wed, 3 Jul 2019 02:26:22 +0000
Message-ID: <DM6PR04MB57546ECC4CFDDB5535E3382586FB0@DM6PR04MB5754.namprd04.prod.outlook.com>
References: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
 <20190701215726.27601-4-chaitanya.kulkarni@wdc.com>
 <20190703005023.GC19081@minwoo-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:c10e:84d:47cf:30ea]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 950a896c-2d53-4353-58c5-08d6ff5dd72c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR04MB5388;
x-ms-traffictypediagnostic: DM6PR04MB5388:
x-microsoft-antispam-prvs: <DM6PR04MB5388817C41562EECD90A0CCD86FB0@DM6PR04MB5388.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 00872B689F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(189003)(199004)(99286004)(53936002)(6436002)(9686003)(55016002)(71200400001)(7696005)(14454004)(25786009)(73956011)(6506007)(54906003)(186003)(71190400001)(53546011)(316002)(476003)(446003)(91956017)(486006)(6246003)(6116002)(102836004)(76176011)(4326008)(6916009)(229853002)(256004)(5024004)(14444005)(86362001)(76116006)(66446008)(33656002)(68736007)(66556008)(64756008)(8676002)(7736002)(72206003)(46003)(52536014)(478600001)(66946007)(305945005)(8936002)(81156014)(81166006)(2906002)(74316002)(5660300002)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5388;H:DM6PR04MB5754.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: recYYssfJjMPpLPOis0W06Fed9NSjE/9ubs4x3bLoE1sVTbXhl8iy5Bz5xGPYbtMT1Os44IgVje5Jt2dMmgL1VyF0JCLGEILmqJpq2RvJYS8Dsxd91pRuVgdk5QnMGJ0tLXDVs0WKI/Ag2U3oHRcahdEGUciGOscEibzutkzxWT3Ai6OijxQvApqSEwI0sN4udsCxyMjlqVQRd5hYjFY29l3VleycGG8faVoOQ5Rhk86q33n7ACOxW9L9KSEt/QfYQu5PUo7sHFAK3oo+j094n44VSfbpxnm5B9qqk+TuhP0B2x5jh72FFfIUOJK44L+8g1laUktDzg4nOm4PZxYa7ZfBDwX2FF1zwdVD/IYHQ2qba7ZWJF7SIh6FTuLqp5JRDm/NKDG+1uLxIUZdrlfK3jCKgbWYAn/Ox0LSANM/mY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950a896c-2d53-4353-58c5-08d6ff5dd72c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 02:26:22.4654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5388
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/2/19 5:50 PM, Minwoo Im wrote:=0A=
>> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
>> index 5143a8e19b63..9855c5d5027d 100644=0A=
>> --- a/block/blk-core.c=0A=
>> +++ b/block/blk-core.c=0A=
>> @@ -1127,17 +1127,15 @@ EXPORT_SYMBOL_GPL(direct_make_request);=0A=
>>   */=0A=
>>  blk_qc_t submit_bio(struct bio *bio)=0A=
>>  {=0A=
>> +	unsigned int count =3D bio_sectors(bio);=0A=
> Chaitanya,=0A=
>=0A=
> Could it have a single empty line right after this just like you have=0A=
> for the if-statement below for the block_dump.  It's just a nitpick.=0A=
=0A=
Yeah, again can be done at the time of applying patch, if Jens is okay=0A=
with that.=0A=
=0A=
Otherwise I can send V2.=0A=
=0A=
>=0A=
>>  	/*=0A=
>>  	 * If it's a regular read/write or a barrier with data attached,=0A=
>>  	 * go through the normal accounting stuff before submission.=0A=
>>  	 */=0A=
>>  	if (bio_has_data(bio)) {=0A=
>> -		unsigned int count;=0A=
>>  =0A=
>>  		if (unlikely(bio_op(bio) =3D=3D REQ_OP_WRITE_SAME))=0A=
>>  			count =3D queue_logical_block_size(bio->bi_disk->queue) >> 9;=0A=
>> -		else=0A=
>> -			count =3D bio_sectors(bio);=0A=
>>  =0A=
>>  		if (op_is_write(bio_op(bio))) {=0A=
>>  			count_vm_events(PGPGOUT, count);=0A=
>> @@ -1145,15 +1143,16 @@ blk_qc_t submit_bio(struct bio *bio)=0A=
>>  			task_io_account_read(bio->bi_iter.bi_size);=0A=
>>  			count_vm_events(PGPGIN, count);=0A=
>>  		}=0A=
>> +	}=0A=
>>  =0A=
>> -		if (unlikely(block_dump)) {=0A=
>> -			char b[BDEVNAME_SIZE];=0A=
>> -			printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",=0A=
>> -			current->comm, task_pid_nr(current),=0A=
>> -				blk_op_str(bio_op(bio)),=0A=
>> -				(unsigned long long)bio->bi_iter.bi_sector,=0A=
>> -				bio_devname(bio, b), count);=0A=
>> -		}=0A=
>> +	if (unlikely(block_dump)) {=0A=
>> +		char b[BDEVNAME_SIZE];=0A=
>> +=0A=
>> +		printk(KERN_DEBUG "%s(%d): %s block %Lu on %s (%u sectors)\n",=0A=
>> +		current->comm, task_pid_nr(current),=0A=
>> +			blk_op_str(bio_op(bio)),=0A=
>> +			(unsigned long long)bio->bi_iter.bi_sector,=0A=
>> +			bio_devname(bio, b), count);=0A=
> It would be great if non-data command is traced, I think.=0A=
>=0A=
> Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>=0A=
>=0A=
=0A=
