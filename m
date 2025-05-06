Return-Path: <linux-block+bounces-21257-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 740EAAAB68D
	for <lists+linux-block@lfdr.de>; Tue,  6 May 2025 07:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E06616063A
	for <lists+linux-block@lfdr.de>; Tue,  6 May 2025 05:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2C02DD795;
	Tue,  6 May 2025 00:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sFlCGbSi"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76436AAE3
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485781; cv=none; b=ZUdDB7g/rWM5cUkMQLp/yrZpxv0Lshd0+EU+Sr3VhDE7IbWI02veczHDfLF5q2b3GtrlrnqtwLzVuLi1q83TZqg8qh0QdHhavi1JpeDNVKqZGnGRhNbumsMpN+D9OeZaB+n/WR7uGlLhM/VL4ZXn7iJkt6VDAXee14msh5kx6qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485781; c=relaxed/simple;
	bh=wHRy5AQPRQxiU54IBvGuKaPKDlgm5NQZxV6K6w1Qve0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2Me5uWGMugXw5sSFfRbuefWONWIujVW9mjPfiJkslNnS/DNCkAZl+jTOfj0yEXg4cnPwChuUyL92flCRtgRsLnt9yu0IKCZi+EF19Ix5R58YBd9d0jW6g50Zkx0WISPsE1DE1Y2FiNwOVP2pvxXZPKyaCGyxysm8EAq5iFCLK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=sFlCGbSi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so4082152b3a.3
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 15:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1746485777; x=1747090577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TZtudP8whc5JWyiBQCvGvrdC2CkTXwDmcdreRv5eyPQ=;
        b=sFlCGbSihnoYn+Kn6Ve0Gh8tuPRq1NcVQO2MQUIv+qmjUC3NmvPzE7viNKog5tDLZ+
         ef+tNdSxOUt4ulpPQlh06Vgvll1qBPPgxa2WhC9W5hNViNNwfPfcaduA3iOUtuncKOMA
         M1fNiPLON5L5Xsje0BSrNVkykZyTVwl3CK8bEB/TEXykNXuECeJG5EgoK84jlorpYPNP
         STpGGXncQR5ljQ0Vx7J26PvhGYGDWrU74vUTcVPyaqyVE9lO5Z3ZcmdBnnpuqPx/0JEU
         3Zh4NjfBW87ron4uEOvysJuKRHDq79F21+0eExMuABzRsIED8r89PtVmd+pkrkuFupwP
         I6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485777; x=1747090577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZtudP8whc5JWyiBQCvGvrdC2CkTXwDmcdreRv5eyPQ=;
        b=fSvcItn2eGMlHcl9TW61BlDwYTbsuVVuo3U3fSdrv9ofUoeGw8MGYbf+jhsNax2Tcn
         LgAu+58KdsO9MqGjZnyTWzdMvzOXQ+yyzJEQxhul1Ua9vrAvMx4Ug0DnrT4mhiPPYF6J
         yxlptvMrXxRV53FZuaKO2RY4uXnEG/89UDiQERUCuDUWr+Y8cvvD2z7Q3Jw65ekFJEMU
         W3MfotovsOUDp3/x5vzY8OVOhXnhqr4IQedVvwKY9lKmczvDfGdaYAQoYzIOPW2BJBPH
         Xcz/Le+FSCUjPbODNioY+YfcNVyz+0Tx6pEE2+fIfhJqVi//vJ+sL9/+hiNwBs7OBEUX
         Qo3A==
X-Forwarded-Encrypted: i=1; AJvYcCWzY9mAMmiKd74PV7oSXKKFHqxkWDaQqKcb2rtm56rn59ME4a29L8j9pVcwQwL8EtLEPFO8jgwkS14/vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwI6izuWHGevPFG8UWVLLkN2/Cg2dWmVBv/UGygq/yzZAyISfnL
	mZecPKGyzUiGkNcVvWk1APXz2b6pjJn1zFz5ca7agLxqLHl/K8CjF+Ddsn4DimM=
X-Gm-Gg: ASbGncsXmcg39U/qMvFJZGBfo0N8XEWQJLbKtdyH+pIGAp55KHhPXb9qj+YNkx/0mKV
	vgcrGdjM3kDNx8Ikmlsd7rff4CmnShsGNMm5X3EAzYcl4jTkVlt0RW59PQF0yQqXzzeFDllhug2
	Y8LFPP/ajDC4do5nU4YpJjUcjZWDYaq2oCpWg1muN25lobKhdi65P+4kq1isBIRRBQrk4VIWh7b
	MQpiAH/3Kzm7U9R1HOqYaHRRLt1dBueOb5xFf+zrp4C8QyYYIdJhghoibpzYL2lCG6kGvrcKYyt
	A6LCo4DuF3P3ZW4Dn1pIDvV3Ayc55y7N5SWEIgUb7en8DYvwynzy79xLgL5XwT0USqk/eipLSxB
	paH+N/kCOzqgxCQ==
X-Google-Smtp-Source: AGHT+IG0junclw7g29Tiqwx2VjZpghoTqY/gPZ70p9955vnBkCywMNmCzZAK8v7YO3Z5zsZcGqWWmQ==
X-Received: by 2002:a05:6a20:cf90:b0:1f5:64a4:aeac with SMTP id adf61e73a8af0-21182ec067cmr1039329637.33.1746485777257;
        Mon, 05 May 2025 15:56:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058db9200sm7423761b3a.42.2025.05.05.15.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 15:56:16 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uC4jN-0000000HT0R-0Pro;
	Tue, 06 May 2025 08:56:13 +1000
Date: Tue, 6 May 2025 08:56:13 +1000
From: Dave Chinner <david@fromorbit.com>
To: Laurence Oberman <loberman@redhat.com>
Cc: Anton Gavriliuk <antosha20xx@gmail.com>, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: Sequential read from NVMe/XFS twice slower on Fedora 42 than on
 Rocky 9.5
Message-ID: <aBlCDTm-grqM4WtY@dread.disaster.area>
References: <CAAiJnjoo0--yp47UKZhbu8sNSZN6DZ-QzmZBMmtr1oC=fOOgAQ@mail.gmail.com>
 <aBaVsli2AKbIa4We@dread.disaster.area>
 <CAAiJnjor+=Zn62n09f-aJw2amX2wxQOb-2TB3rea9wDCU7ONoA@mail.gmail.com>
 <aBfhDQ6lAPmn81j0@dread.disaster.area>
 <7c33f38a52ccff8b94f20c0714b60b61b061ad58.camel@redhat.com>
 <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f322ab801e7f7037951578d289c5d18c6adc4d.camel@redhat.com>

On Mon, May 05, 2025 at 09:21:19AM -0400, Laurence Oberman wrote:
> On Mon, 2025-05-05 at 08:29 -0400, Laurence Oberman wrote:
> > On Mon, 2025-05-05 at 07:50 +1000, Dave Chinner wrote:
> > > So the MD block device shows the same read performance as the
> > > filesystem on top of it. That means this is a regression at the MD
> > > device layer or in the block/driver layers below it. i.e. it is not
> > > an XFS of filesystem issue at all.
> > > 
> > > -Dave.
> > 
> > I have a lab setup, let me see if I can also reproduce and then trace
> > this to see where it is spending the time
> > 
> 
> 
> Not seeing 1/2 the bandwidth but also significantly slower on Fedora42
> kernel.
> I will trace it
> 
> 9.5 kernel - 5.14.0-503.40.1.el9_5.x86_64
> 
> Run status group 0 (all jobs):
>    READ: bw=14.7GiB/s (15.8GB/s), 14.7GiB/s-14.7GiB/s (15.8GB/s-
> 15.8GB/s), io=441GiB (473GB), run=30003-30003msec
> 
> Fedora42 kernel - 6.14.5-300.fc42.x86_64
> 
> Run status group 0 (all jobs):
>    READ: bw=10.4GiB/s (11.2GB/s), 10.4GiB/s-10.4GiB/s (11.2GB/s-
> 11.2GB/s), io=313GiB (336GB), run=30001-30001msec

So is this MD chunk size related? i.e. what is the chunk size
the MD device? Is it smaller than the IO size (256kB) or larger?
Does the regression go away if the chunk size matches the IO size,
or if the IO size vs chunk size relationship is reversed?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

