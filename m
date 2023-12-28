Return-Path: <linux-block+bounces-1501-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBCD81F79A
	for <lists+linux-block@lfdr.de>; Thu, 28 Dec 2023 12:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36DF1F23387
	for <lists+linux-block@lfdr.de>; Thu, 28 Dec 2023 11:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6186FBD;
	Thu, 28 Dec 2023 11:10:17 +0000 (UTC)
X-Original-To: linux-block@vger.kernel.org
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7906FB6;
	Thu, 28 Dec 2023 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 991F66343B3D;
	Thu, 28 Dec 2023 12:10:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Ha9HAdblf5Fu; Thu, 28 Dec 2023 12:10:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0F9C76343B4E;
	Thu, 28 Dec 2023 12:10:12 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jBjqUGApe4hb; Thu, 28 Dec 2023 12:10:11 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id CF83F6343B3D;
	Thu, 28 Dec 2023 12:10:11 +0100 (CET)
Date: Thu, 28 Dec 2023 12:10:11 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: hch <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Josef Bacik <josef@toxicpanda.com>, Minchan Kim <minchan@kernel.org>, 
	senozhatsky <senozhatsky@chromium.org>, Coly Li <colyli@suse.de>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-block <linux-block@vger.kernel.org>, nbd@other.debian.org, 
	linux-bcache <linux-bcache@vger.kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1544995699.172154.1703761811676.JavaMail.zimbra@nod.at>
In-Reply-To: <20231228075545.362768-5-hch@lst.de>
References: <20231228075545.362768-1-hch@lst.de> <20231228075545.362768-5-hch@lst.de>
Subject: Re: [PATCH 4/9] ubd: use the default discard granularity
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: use the default discard granularity
Thread-Index: kk75ae1xWs0+YtjBcgdOSaDYaxww3w==

----- Urspr=C3=BCngliche Mail -----
> Von: "hch" <hch@lst.de>
> An: "Jens Axboe" <axboe@kernel.dk>
> CC: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Josef Bacik" <josef@toxicpanda.com>,
> "Minchan Kim" <minchan@kernel.org>, "senozhatsky" <senozhatsky@chromium.o=
rg>, "Coly Li" <colyli@suse.de>, "Miquel
> Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.c=
om>, "linux-um"
> <linux-um@lists.infradead.org>, "linux-block" <linux-block@vger.kernel.or=
g>, nbd@other.debian.org, "linux-bcache"
> <linux-bcache@vger.kernel.org>, "linux-mtd" <linux-mtd@lists.infradead.or=
g>
> Gesendet: Donnerstag, 28. Dezember 2023 08:55:40
> Betreff: [PATCH 4/9] ubd: use the default discard granularity

> The discard granularity now defaults to a single sector, so don't set
> that value explicitly.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> arch/um/drivers/ubd_kern.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index 50206feac577d5..92ee2697ff3984 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -798,7 +798,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
> =09=09ubd_dev->cow.fd =3D err;
> =09}
> =09if (ubd_dev->no_trim =3D=3D 0) {
> -=09=09ubd_dev->queue->limits.discard_granularity =3D SECTOR_SIZE;
> =09=09blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
> =09=09blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST)=
;
> =09}

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

