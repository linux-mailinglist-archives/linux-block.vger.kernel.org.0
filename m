Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA56739C43E
	for <lists+linux-block@lfdr.de>; Sat,  5 Jun 2021 02:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFEATm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Jun 2021 20:19:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48981 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhFEATm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jun 2021 20:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622852275; x=1654388275;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gFHOWeRCAJbAzhHULmdzTwxIXHcYISdMlDKayZ8kfyo=;
  b=YYR7F5hH0JWAcq3ML8LXIe8NzmrLOs7UsHLmZzrztIjoEdfih+c3CqXs
   9fTGRtMOBDYHmWjLyYImEUMWnObg3ojRDJaV5i/uUbM6av37vyVF2AyW3
   o4H/uYlvuYmoyKyAxzO2pWjRyBd4nS63pW4yCBUtiYSoJHKY7A8s8maTZ
   KpphynsLONYZ2x4FKjHqmJ78rgfKAQtQrQKc+vzbvavmW6ufF6ar5h5gb
   bs5CVTcF5GMQ9A0q6sNBJ7MZF/1cQuLfGMde7o5ueVpHoZ51f+Xw0uYqn
   Y8GMRQ8BJHQ2UzC2DWwlFubnd66EVfyXoU8EnYAbzybxqkxhjKcrlslB/
   Q==;
IronPort-SDR: K7PdezmPcw2YlMs35TF2R6oXNcxTvnXNwTzTD0mn4ItXb0nwbDffXhPeZkrlKNAHCiotzO4Pls
 YWhQ+18Xnn/3kK70dmjjusz2MXgNptqMRI93WPyg6mLdQOyrvH4jbtJUcNZL9mSN2omygcux/k
 /mvTuXc4Z7VTJz8d3f0isG3tU3CPv6BHY8d0Sqx+Rl2AWa88+ThYApctm97jJkNWpYh/R02bJ+
 uoYIxb3w347tYJw/2kxMkTIj1C+Dnfl+FmCmIJXcVwsVtDwGr35xa7s3o3jpshpUEJVw29iMGK
 en8=
X-IronPort-AV: E=Sophos;i="5.83,249,1616428800"; 
   d="scan'208";a="282208558"
Received: from mail-dm6nam08lp2044.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2021 08:17:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvjZkn0lYERFYRtYaxdwOPf30zC4zQJGvW9qS2FqYNBT3F5cj+dUVL+GK52JB4WQGPjimVOrS6pfkazV2OC6SzQTCto8Vk6EANb5flg6+Huh9Y6zsMSEaB6Odbo+ZojcTyj9fX1pwPfe9JzVMA3Hh6+0h9RS3UDBTd8NxxgYcox4msIpJRI2pLuJBRdMeW2ZJ1ZwGrZwesyg9gbxRm9bTyvvmJML6uWPjn6ZEK55VxIpGhtux2XqoYf4vwjC3xjJ01a+RCFJe/4Ao4HZB9hy77d5A/Jde/nrxyBNmID0zJh7ZFnHKO6lZBHVb8HVbPlHX/tHr5GO14ruHIdQPm69uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YHGOr3Kwz1HPSRT5uR5bJ5rwW9gjQkhkVZ3rlNoZfE=;
 b=WMF8Cgwgg00EySatEe95LIB2fKH0c2gAh2Ey8LKEh8XMHn6dsuPcdHqlc0lRJJfT4UGDF9Fj1F+5YaBeODU94akN7M9sp1yPOsb4/nYUqhLxBofmo4YPKPtLU2XGSRhRPNrXvmrQiuOnUkkIQcXOoMGR17gG7kg2VhNJPhNksvli/sOwTiNwSj7glKXTuOycjzRbfE6tGB+CjdK7sm2lX2yBIA5PUbOTk3fotGV8+k8fgPTHWP2RnLjlsYbxdWqsWD0CsZ7b9ZXYQ0LObyYwvWWFWw530om4u+V5E1anhqi9+NAG+0ye0kqOnka9fOnI4RPN/xZsb/iKVb9dKIvMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YHGOr3Kwz1HPSRT5uR5bJ5rwW9gjQkhkVZ3rlNoZfE=;
 b=HoX+Bp6YIuCYpoHcWfrHXNBwY4MOU3c9yq/SIX+WwawifB1fwhN6zjtYMhH6KcXBE2Hmgvn7zC6/ACr4f435uqDApV0w+auhE5+ZwR1wQpdGc341L1l+MOht2C0ecM4g+cL/d5NdC5CYd+Ph2Wx8zMANJ2fRwncCNrdou1ekaCo=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB1244.namprd04.prod.outlook.com (2603:10b6:4:3d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Sat, 5 Jun
 2021 00:17:52 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.024; Sat, 5 Jun 2021
 00:17:52 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5 08/11] dm: Forbid requeue of writes to zones
Thread-Topic: [PATCH v5 08/11] dm: Forbid requeue of writes to zones
Thread-Index: AQHXUax2oCc1akPfNkKbpC9TBPj7Lw==
Date:   Sat, 5 Jun 2021 00:17:52 +0000
Message-ID: <DM6PR04MB70813E6E894DE0D69816CDBDE73A9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210525212501.226888-1-damien.lemoal@wdc.com>
 <20210525212501.226888-9-damien.lemoal@wdc.com> <YLo/LO32+rdrfygC@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:61af:6851:54e6:364]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c19e0bf-5c60-4c14-e4cf-08d927b75c12
x-ms-traffictypediagnostic: DM5PR04MB1244:
x-microsoft-antispam-prvs: <DM5PR04MB1244D3B2E1927FFF61B9952EE73A9@DM5PR04MB1244.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sRdpcwI/pcLx25n/SPUN/xJywg7YZTcGk6s2eDuLhcWXYOdeFT5g+CTV3xiXp4bjx6Xx1J4H93Qcbu0LIjTKllpD601vSmohvoi1mBaj8t+E6GGh5KaTZ5+CisXlHbqZyQ2ddprz/0Z73CLghG5oQPYA5IUHkSERCTnN50Ytsvjzm3MEkp7epmbrRG67IzIxqhR5X0Ii2loO4l7iUZ1yFCDcobhUBydVNLd8J5u6rpnmU+qAWIsoer1osTOvIiV6igMekp2BMFRlVgTqiL9h1FZZe4YMUjXCxwN5XXwGXOTXcHO7ZimeuaTRRn0fjbs57RUyztEKv/LqtBcimcGs0qrLDqx3+7i+/jVI4uk1RUN0m6Jmd4beElQ3+2NamK71j5wQ2f9kHQqyp9wGG0BFGzYYpc1eL/WrbKsst+vnWEyFJzIrYa4Tk2XXc82NGx6Q1iiV4m/L0TENXP+QEEeacr67ARJwPSB3vHuJWleciqjQBtbebmdcyB5V7GXmb+/7NkqgFFuxqqueiZB9lsoyj4KEEOrwLGZUP7FoBqOZpVYcYzNpWt5J9j+1Xaly5n9ORfRAd3xa0oXGTu21KBIYrGgd4i0PIyqoV6Fcg9eFI5oqNtlnQWI+RojRF9xm2njrWikqFHTvrqVi5LGj9ftvrC2BsCyQ80EixLQTTwE+hGQZKbO9ywJJ9gkRkCXHhLMgYvpuQslyMF9ZUtyaLRfCOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(136003)(346002)(376002)(966005)(478600001)(5660300002)(8676002)(122000001)(8936002)(38100700002)(91956017)(55016002)(9686003)(66476007)(66556008)(64756008)(66446008)(66946007)(76116006)(83380400001)(2906002)(6916009)(7696005)(316002)(4326008)(186003)(52536014)(54906003)(71200400001)(6506007)(53546011)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OaEoswdG1eS8vA0xO3wdjTcWEXEoPznvdipQ90XfbBvRAKJHod38sVxtsYzv?=
 =?us-ascii?Q?LVnH468wY8OK7qmOuLwv/T1y6g7WshxnJXiKVKSUS8GEsoui4x4qErzG+jMg?=
 =?us-ascii?Q?Mb2u9D8KJbf8uOvo3awFmfPX35A+irX95TS8Lcomg/GPpuC1SZQkhHX/EU0J?=
 =?us-ascii?Q?8s9HYgXP8tLj7bM+ZE7JYsdRqgy3TmLU6zL+giGnMZiq7Me42KIUCgOIWJh6?=
 =?us-ascii?Q?CB42nl7RcWYE4wuPO2kP6MzoylzU7unrc80Jhidqujt41aL38Wd1JLhqdaQb?=
 =?us-ascii?Q?y38B13lVG9P8Vo5xFoFyWWoGjWHK+5InBfS6BnXMAo3YHSymF1BJNYNG7a7/?=
 =?us-ascii?Q?4+yCRHJj5E+cir4I90FqyWtwm4MyE6nL8B4zONMqx0D8Cku8GBNN2K7B9l+D?=
 =?us-ascii?Q?8LxypYCaPRUq2eJmEOMh53A0shOjeiE0Bwik4k9maOaf89SJAWUDWlXJaX9/?=
 =?us-ascii?Q?14zoZl1T5E6kepcrenWpP1gZ91UWMlX2Oynd8hisA03FT1HJzzqZiMYZpWmz?=
 =?us-ascii?Q?R6hts9fbhCKzIUObD/XoknppzpXrsjEh//KtEowhJs1vZkTUXsaqE02Tcm8y?=
 =?us-ascii?Q?X6yF4yy/rSjMgKjgRXzVc9waLmEFgPPXv2jVASYwR/wqUDEAsUz/yvQh1Lpn?=
 =?us-ascii?Q?zj94Tq1PqU3PEtOmziSPFLJKfsa4+FqFLB9/MsMgKB1NPIxJ8IcXx1qBq//4?=
 =?us-ascii?Q?Lzj8QblzS+yvZndkAca80JXnzlz6wIzkn27uytUI64SpwcPh/X66jdE3XRZA?=
 =?us-ascii?Q?hWkxGa33Kc85RNu553tFq52GWQFaruzLWME5HdS4SJLnfSvnpNqSwwtQuTw9?=
 =?us-ascii?Q?GN61uOTbU3ovPLugfFp1cQThgKJurzbG50rbf1wOvndd3C6cczJ/8zFPicg5?=
 =?us-ascii?Q?8/bdFORbAQ6WJ5ZTfWJp8kbDgA48CCxwsV8rjJO8r+qVl3Zgh9JnCfpMcTsM?=
 =?us-ascii?Q?n6gaZ/HkaIF7mw+DP0xmANwo5f+KrZ49BUzA72uOvcstrI3BVHnHjkLJTXio?=
 =?us-ascii?Q?uhmdRYY6rSCVZ9/rzmvuf9/jDB/WbirJhq0onUbdWEJnlhRm3FtpASP0A57r?=
 =?us-ascii?Q?geOnUrco1HD4LHDlhMOEiUhfKeFdE2ncSHoCd9H6rIOu469CLS8xdTI7XqPN?=
 =?us-ascii?Q?5uNad7M8ggUmaYNgblm8MuzzGXNU01Txwc3Qh6PeHZG/PtGPrAQGPsnuzYg0?=
 =?us-ascii?Q?DNiv+U0LSub65y+97ADg6tJIAS/0vKtiG3owzttxiaVlZ44caA5+w3+sn5wk?=
 =?us-ascii?Q?M9WIRzaGD0aDSiLGOASn8t7KidZ5COUhVQCQ21mh1YznzWszh/II0ybYf9Z4?=
 =?us-ascii?Q?5k5CAQv5rP4FP7NhUGNd9LsvnU5Ch8WG+LJZyDGVjYLQ1f7FSnuM2Y6RnKY6?=
 =?us-ascii?Q?oZnfIpvqtabfkDoklWJjGWx8EOQFYY/8yWqTE2CGAeZFFlh9CA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c19e0bf-5c60-4c14-e4cf-08d927b75c12
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2021 00:17:52.6328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0f6dfvgiFUXR6HzQNrJg0PZdDxlmSxuhlsCIVLZMBDGzx5uXS8i/mJwL6P1AZSJxt33Ld2GMaZXsivqUrT/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1244
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/04 23:56, Mike Snitzer wrote:=0A=
> On Tue, May 25 2021 at  5:24P -0400,=0A=
> Damien Le Moal <damien.lemoal@wdc.com> wrote:=0A=
> =0A=
>> A target map method requesting the requeue of a bio with=0A=
>> DM_MAPIO_REQUEUE or completing it with DM_ENDIO_REQUEUE can cause=0A=
>> unaligned write errors if the bio is a write operation targeting a=0A=
>> sequential zone. If a zoned target request such a requeue, warn about=0A=
>> it and kill the IO.=0A=
>>=0A=
>> The function dm_is_zone_write() is introduced to detect write operations=
=0A=
>> to zoned targets.=0A=
>>=0A=
>> This change does not affect the target drivers supporting zoned devices=
=0A=
>> and exposing a zoned device, namely dm-crypt, dm-linear and dm-flakey as=
=0A=
>> none of these targets ever request a requeue.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> Reviewed-by: Hannes Reinecke <hare@suse.de>=0A=
>> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>=0A=
>> ---=0A=
>>  drivers/md/dm-zone.c | 17 +++++++++++++++++=0A=
>>  drivers/md/dm.c      | 18 +++++++++++++++---=0A=
>>  drivers/md/dm.h      |  5 +++++=0A=
>>  3 files changed, 37 insertions(+), 3 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c=0A=
>> index b42474043249..edc3bbb45637 100644=0A=
>> --- a/drivers/md/dm-zone.c=0A=
>> +++ b/drivers/md/dm-zone.c=0A=
>> @@ -104,6 +104,23 @@ int dm_report_zones(struct block_device *bdev, sect=
or_t start, sector_t sector,=0A=
>>  }=0A=
>>  EXPORT_SYMBOL_GPL(dm_report_zones);=0A=
>>  =0A=
>> +bool dm_is_zone_write(struct mapped_device *md, struct bio *bio)=0A=
>> +{=0A=
>> +	struct request_queue *q =3D md->queue;=0A=
>> +=0A=
>> +	if (!blk_queue_is_zoned(q))=0A=
>> +		return false;=0A=
>> +=0A=
>> +	switch (bio_op(bio)) {=0A=
>> +	case REQ_OP_WRITE_ZEROES:=0A=
>> +	case REQ_OP_WRITE_SAME:=0A=
>> +	case REQ_OP_WRITE:=0A=
>> +		return !op_is_flush(bio->bi_opf) && bio_sectors(bio);=0A=
>> +	default:=0A=
>> +		return false;=0A=
>> +	}=0A=
>> +}=0A=
>> +=0A=
>>  void dm_set_zones_restrictions(struct dm_table *t, struct request_queue=
 *q)=0A=
>>  {=0A=
>>  	if (!blk_queue_is_zoned(q))=0A=
>> diff --git a/drivers/md/dm.c b/drivers/md/dm.c=0A=
>> index c49976cc4e44..ed8c5a8df2e5 100644=0A=
>> --- a/drivers/md/dm.c=0A=
>> +++ b/drivers/md/dm.c=0A=
>> @@ -846,11 +846,15 @@ static void dec_pending(struct dm_io *io, blk_stat=
us_t error)=0A=
>>  			 * Target requested pushing back the I/O.=0A=
>>  			 */=0A=
>>  			spin_lock_irqsave(&md->deferred_lock, flags);=0A=
>> -			if (__noflush_suspending(md))=0A=
>> +			if (__noflush_suspending(md) &&=0A=
>> +			    !WARN_ON_ONCE(dm_is_zone_write(md, bio)))=0A=
>>  				/* NOTE early return due to BLK_STS_DM_REQUEUE below */=0A=
>>  				bio_list_add_head(&md->deferred, io->orig_bio);=0A=
>>  			else=0A=
>> -				/* noflush suspend was interrupted. */=0A=
>> +				/*=0A=
>> +				 * noflush suspend was interrupted or this is=0A=
>> +				 * a write to a zoned target.=0A=
>> +				 */=0A=
>>  				io->status =3D BLK_STS_IOERR;=0A=
>>  			spin_unlock_irqrestore(&md->deferred_lock, flags);=0A=
>>  		}=0A=
> =0A=
> So I now see this incremental fix:=0A=
> https://patchwork.kernel.org/project/dm-devel/patch/20210604004703.408562=
-1-damien.lemoal@opensource.wdc.com/=0A=
> =0A=
> And I've folded it in...=0A=
=0A=
Thanks.=0A=
=0A=
>> @@ -947,7 +951,15 @@ static void clone_endio(struct bio *bio)=0A=
>>  		int r =3D endio(tio->ti, bio, &error);=0A=
>>  		switch (r) {=0A=
>>  		case DM_ENDIO_REQUEUE:=0A=
>> -			error =3D BLK_STS_DM_REQUEUE;=0A=
>> +			/*=0A=
>> +			 * Requeuing writes to a sequential zone of a zoned=0A=
>> +			 * target will break the sequential write pattern:=0A=
>> +			 * fail such IO.=0A=
>> +			 */=0A=
>> +			if (WARN_ON_ONCE(dm_is_zone_write(md, bio)))=0A=
>> +				error =3D BLK_STS_IOERR;=0A=
>> +			else=0A=
>> +				error =3D BLK_STS_DM_REQUEUE;=0A=
>>  			fallthrough;=0A=
>>  		case DM_ENDIO_DONE:=0A=
>>  			break;=0A=
> =0A=
> But I'm left wondering why dec_pending, now dm_io_dec_pending, needs=0A=
> to be modified to also check dm_is_zone_write() if clone_endio() is=0A=
> already dealing with it?=0A=
=0A=
The way I understand the code is that if the target ->map_bio() method retu=
rns=0A=
DM_MAPIO_REQUEUE (in __map_bio()), then clone_endio() is not called since t=
he=0A=
clone BIO is not submitted. But we still need to fail orig_bio, hence the c=
heck=0A=
in dm_io_dec_pending() to cover the submission path. Am I missing something=
 ? Is=0A=
clone_endio() also called in that case ?=0A=
=0A=
> Not that big a deal, just not loving how we're sprinkling special=0A=
> zoned code around...=0A=
=0A=
I do not like it either. It makes maintenance harder. But as explained abov=
e, I=0A=
did not see any other way to cover both the submission and completion cases=
.=0A=
=0A=
> =0A=
> Mike=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
