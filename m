Return-Path: <linux-block+bounces-1257-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29622817C46
	for <lists+linux-block@lfdr.de>; Mon, 18 Dec 2023 21:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D671C21849
	for <lists+linux-block@lfdr.de>; Mon, 18 Dec 2023 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68EE7346E;
	Mon, 18 Dec 2023 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nY+BpKP5"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C37206D
	for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c1f8b0c149so1457847a12.3
        for <linux-block@vger.kernel.org>; Mon, 18 Dec 2023 12:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702932620; x=1703537420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VYuhGNACrh4RxyK7vwhYZLcFzB1f10C6T9YQ9W4h0I=;
        b=nY+BpKP5a7NV8lBnYEvh6u9ZeBnp/zbTuylqEjJNVDUQB0d1I4HvQmFJBIoeqXik18
         H/bYy1bZGe85sLtmQ4JYggNYHT9ZzHGf+AfAFA2Qr+9nF4Q6pbMSeu9xekx9sbQ/gKag
         hCco2a5m62y6x8EGd4Zs25pcpKIxBiwlUQwMiuGzcwXOOLuSBx8as+OEtQ2f2BP6H1GW
         uKjoaD5KZTmuqJEYzKelEdy9WoWmgJdA/qCU5I6SVxCijtYbZ391gZrKfSoEdaiiI3ZU
         BS5CZG/rHB6PTaxldUyy0OJiWZrU0IX9I5uQ33l3lkYUqxS7hOtf/8/0atu7ITVKVcAY
         6ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702932620; x=1703537420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VYuhGNACrh4RxyK7vwhYZLcFzB1f10C6T9YQ9W4h0I=;
        b=fKpMVFlNLELy9AUtaJbI/Of/a4JoBBjza0YeuCtcIWC18uZJoQyvHjlgtQDuieEERV
         Up9iXlXc6//V0YTJGaqLiSm6MF07K3MW941Rff2bUNONuBL2spbAKgA4Li4JBjy9UUr+
         FZUMVltLeLUM+JB0rk10zpph3/8C31H6ALVCsGR9VM8qseAOjRVYSbfsKXdMZ/F+keVd
         ZZ2Fjsr3CngWABpa7i0uLXfbI2mJalwhI+VsAZLSQsKsLDtjDMwLH3Pi9yvjv5Xkf2/4
         HmFIrwRp/A8iyYWvJdG+hU9CWGBnGSESKFb3DgvSK7ZSmIfPwUPWjgzXuO7KZaXLttyn
         SVhQ==
X-Gm-Message-State: AOJu0YzpDvbgdq5eyxBLtlYDNAB1MofCU+fLAraw4Nfs8Y5EbA4gyz5V
	h1ULO4UtkQ+OV2SE9HWJHgoWLQ==
X-Google-Smtp-Source: AGHT+IEcehJB+ZsazS59hM/1fa/WGZjE8Vnyh7uwh2p3+WD/I5U+59Kjmr50pBpBUNXzLwVtu1jPKg==
X-Received: by 2002:a17:90b:3b87:b0:28b:7643:e65c with SMTP id pc7-20020a17090b3b8700b0028b7643e65cmr1027749pjb.56.1702932620479;
        Mon, 18 Dec 2023 12:50:20 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id jv14-20020a17090b31ce00b0028aecd6b29fsm10415331pjb.3.2023.12.18.12.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 12:50:19 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rFKZ5-00A8Va-2x;
	Tue, 19 Dec 2023 07:50:15 +1100
Date: Tue, 19 Dec 2023 07:50:15 +1100
From: Dave Chinner <david@fromorbit.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v7 05/19] block, fs: Restore the per-bio/request data
 lifetime fields
Message-ID: <ZYCwh7RJ4EpXD+7X@dread.disaster.area>
References: <20231218185705.2002516-1-bvanassche@acm.org>
 <20231218185705.2002516-6-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218185705.2002516-6-bvanassche@acm.org>

On Mon, Dec 18, 2023 at 10:56:28AM -0800, Bart Van Assche wrote:
> Restore support for passing data lifetime information from filesystems to
> block drivers. This patch reverts commit b179c98f7697 ("block: Remove
> request.write_hint") and commit c75e707fe1aa ("block: remove the
> per-bio/request write hint").
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

...

> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index bcd3f8cf5ea4..97e20911b45f 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -380,6 +380,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  					  GFP_KERNEL);
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> +		bio->bi_write_hint =
> +			file_inode(dio->iocb->ki_filp)->i_write_hint;

We already have an inode pointer in this function (from
iter->inode), so:

		bio->bi_write_hint = inode->i_write_hint;

-Dave.
-- 
Dave Chinner
david@fromorbit.com

