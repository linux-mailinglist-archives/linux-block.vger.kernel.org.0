Return-Path: <linux-block+bounces-103-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65747E8717
	for <lists+linux-block@lfdr.de>; Sat, 11 Nov 2023 01:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA20281359
	for <lists+linux-block@lfdr.de>; Sat, 11 Nov 2023 00:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF63C1C35;
	Sat, 11 Nov 2023 00:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="tuqhm9i2"
X-Original-To: linux-block@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08A1C03
	for <linux-block@vger.kernel.org>; Sat, 11 Nov 2023 00:57:00 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD8E4229
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 16:56:57 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-587b1231dbeso1362559eaf.3
        for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 16:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1699664216; x=1700269016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WJjV0M8MGipSibP/l63xjUDxPGkLG8AjMcqPGszYTU=;
        b=tuqhm9i2u/aQ7PoskTQCu9yyc1Xbr0z8N1FpX/NJnt+Tb7RWfemd7GMxL+oCL+3c0z
         VJ9iZfdGDgmKXNccLi6CDEV49HMJD7gGULK+xPwBPAPd+jiDUGKu+7GYHP4D3cnGhX/e
         PElAtWOw1HDPcu92ZzNYAJaFCK3+aFsM/ihEYzc25ofE1JSYsoEJyHogQhzAtOJ288dN
         d23aBRx8DKj/EQwO2mPgALX9M35XdfcuTUAiH1hjLoEgEknuNoZpG5Aa9SMlx5lXBMQV
         F26o41Jdu34xXCewj0+C+8NCE/IXTY/M8Bn/FlLN5IudCqGtdchy2ftPJ9Y18llLhRwA
         LIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699664216; x=1700269016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WJjV0M8MGipSibP/l63xjUDxPGkLG8AjMcqPGszYTU=;
        b=kvqnIMLcFxdWjsxG9W8Wv4SbF4+XwXat9xBwZHufG5S1iCrR+lNuqbM128biAhWGO0
         BWfUUhVNwpvtbtGjkKqUeF3BSROZQSmRatngOVlRUw6lShKHwsQ57rY+ZRM68SQz9+9v
         nsI93ZbeTH7UIZLVZYov9r2yM/FvW0m2aYUMt3FTc6BcbLF2OfUA/cHQEc01TPJaQkQ5
         xpGeX3sIqrDEJHjpgKhE3KO89TwAsgMkpi16fJecDwsX4KTr7nqMb9WD5YBPz/U0WptN
         y3fQPCKbpIO8VmvlZBqBZjCJpnk2gJ3PDBuE9j34zolSfBKx9iEzWXmtxJeKiI+ApCgL
         5foA==
X-Gm-Message-State: AOJu0YwfcCzmzJ0ExmVoHrpxuF+5fLpBsqLprIpdiVFlAiMoCskkOLgK
	H5noYPrsC6G6JUPg/lBunPPhKw==
X-Google-Smtp-Source: AGHT+IGX3k4QQhob2VPoP+c6SxcbxGB2OaDpjeV49tKk6N1SJY4rWQ5U6++lwQ6APk6XaIzKjwMPLA==
X-Received: by 2002:a05:6358:e9c5:b0:16b:c414:ae2 with SMTP id hc5-20020a056358e9c500b0016bc4140ae2mr660358rwb.8.1699664216492;
        Fri, 10 Nov 2023 16:56:56 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id w12-20020a63f50c000000b005b8ebef9fa0sm295729pgh.83.2023.11.10.16.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 16:56:55 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1r1cIu-00Ays6-25;
	Sat, 11 Nov 2023 11:56:52 +1100
Date: Sat, 11 Nov 2023 11:56:52 +1100
From: Dave Chinner <david@fromorbit.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v9 0/3] [PATCH v9 0/3] Introduce provisioning primitives
Message-ID: <ZU7RVKJIzm8ExGGH@dread.disaster.area>
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110010139.3901150-1-sarthakkukreti@chromium.org>

On Thu, Nov 09, 2023 at 05:01:35PM -0800, Sarthak Kukreti wrote:
> Hi,
> 
> This patch series is version 9 of the patch series to introduce
> block-level provisioning mechanism (original [1]), which is useful for
> provisioning space across thinly provisioned storage architectures (loop
> devices backed by sparse files, dm-thin devices, virtio-blk). This
> series has minimal changes over v8[2], with a couple of patches dropped
> (suggested by Dave).
> 
> This patch series is rebased from the linux-dm/dm-6.5-provision-support
> [3] on to (a12deb44f973 Merge tag 'input-for-v6.7-rc0' ...). The final 
> patch in the series is a blktest (suggested by Dave in 4) which was used
> to test out the provisioning flow for loop devices on sparse files on an
> ext4 filesystem.

What happened to the XFS patch I sent to support provisioning for
fallocate() operations through XFS?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

