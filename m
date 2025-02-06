Return-Path: <linux-block+bounces-16991-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B73A2A2D1
	for <lists+linux-block@lfdr.de>; Thu,  6 Feb 2025 09:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4950C16853C
	for <lists+linux-block@lfdr.de>; Thu,  6 Feb 2025 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D22224B18;
	Thu,  6 Feb 2025 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b="iz1MHYHv"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17311FCFCB
	for <linux-block@vger.kernel.org>; Thu,  6 Feb 2025 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828824; cv=none; b=kWXmPfmSXGv0xPxyQH4YdE08BiCNwjp3dtwGm+JEHlhwi4Vt1C1OzQXm/LEd6+mk/DdQ92bJDH2eWvfLYGf6JZwDYU7mr+GT3xJi+auvHrymAH8Vc9TuWBiTT34O+gVLZw9I5tLiog8Sbs0SEBrCIRBU3JcebuQfdRYFLtyx650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828824; c=relaxed/simple;
	bh=hbgZDF5c0CDtttVg1c0iGpgYnifwm2dl79coVeP664g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFLzlEdKvylP0D7XmhkrPVe+XoWq/0ZUNAQhfEfc1ak7ClEHKsnDTpjLK0A6+fF/vQ33XUEyRf/x5/mx7EgIo2qCrjtEgG2tVsXK6oYondqZitVsmOvSKECRJ1C+UN4P3PaBoh08ptCvCbNTWVJbaLanK5RiBWR49Z9P2TftVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com; spf=none smtp.mailfrom=owltronix.com; dkim=pass (2048-bit key) header.d=owltronix-com.20230601.gappssmtp.com header.i=@owltronix-com.20230601.gappssmtp.com header.b=iz1MHYHv; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=owltronix.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so1212486a12.0
        for <linux-block@vger.kernel.org>; Thu, 06 Feb 2025 00:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20230601.gappssmtp.com; s=20230601; t=1738828821; x=1739433621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbgZDF5c0CDtttVg1c0iGpgYnifwm2dl79coVeP664g=;
        b=iz1MHYHvXkcX+boB0DrRXqpMNHTZ+txviSigD5CI+epKZ/mQ3I/ZAsAlCqXRUmYvFa
         KziKeuhEDDzt2ubWJFP7THIJhG04mgWwbfvn6ZPhgWj7Qvr4HgzcGN4IMK3A7RYdUTT7
         uBad4WbnTR15maw8vhDOKw7XuRUpX7Ke7P4K3835wHtshlcFqPtSSMRwVwPYdBj12ncc
         38+oDhpdLtPHkqH0xnjCNPMms9H3ofiXJiOhMeqJfP/ATRtp1HOr2hFaDLcjZzPsznmu
         DOQpB6T9CaOUFgRJsM0v2c5V90FNAVquSH/PXRHbcMGlFlAW1GVhszSpmwugMbV9kul4
         RZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738828821; x=1739433621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbgZDF5c0CDtttVg1c0iGpgYnifwm2dl79coVeP664g=;
        b=rd04hFTpeob63OwPEH2btUApr+O9AgnfXSzaMair2V1g+QZEwM3mGTH3MxDyFM6LZq
         s7VCnMe2+Hpq+JUVgJT3P7xjS9vByuYgrmCBrReYYl5CVQGa5qAI9Cw0eGL8+BXGP5at
         95GvRRtcOzsIAUVOD23TnaB4vtUuebotCkAMa/a9AMyrHkJVs3iam8OfGAkUjaawfuJV
         6xrg4W3TLQJmgxvRxbYhwuDEBWFDCNuckAnwsMR9SX4+yXaSXi4+6lKkLuVRm7pV87w8
         9ZhzQ9PykbnYH4DnaLQHW3pkBh4FcwsAghfyJg9p3qrGgMxH0gJVQARckhNM6sJH0JK7
         zxzw==
X-Forwarded-Encrypted: i=1; AJvYcCW3Xb+IeRxgc3wZ/VCmlRQywqS/MPzDUhUu8Wm4EJaKCPSj+dftpPXSq8yI6uYHafCGxj2+T45xQV/SWg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MS1oUaLSyR+9qH145704tBNc0d6EjMKjGxd5uE5eus802NpO
	DuU7Tutcs03jRvufOr5TSldMz53G+UEYODFVecCPsxjwoHqq2GLl8PiKFN0XzXovd4vx2/5aung
	3hVAdjj9/QTuWk0ACoy5/0xL4Y/ngYd9PJPZzvA==
X-Gm-Gg: ASbGnctzUWxdrc/ZpxDH9QaKQtkRrU0FPMCC15IHMOoDo3jZXPWOp0Ac7Xm2V/tQLtB
	c+kH8/gGjELdI9YG7d+oXlp3zyeEIWUqSxysRpx18OqitLvkW3OKUWlKkfO6xDbH6s27CnLxVIg
	==
X-Google-Smtp-Source: AGHT+IElRzdXU9ihnCWisqkyOvOPlw1yUKPT3RVc8XB0QIPGKptq6RLAqxQ6e7F7OtfcIdOIWTr8PicD7kCqwOpbH3A=
X-Received: by 2002:a05:6402:3491:b0:5d9:f3fb:fa45 with SMTP id
 4fb4d7f45d1cf-5dcecd03156mr2299095a12.16.1738828820703; Thu, 06 Feb 2025
 00:00:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123202455.11338-1-slava@dubeyko.com> <fd012640-5107-4d44-9572-4dffb2fd4665@wdc.com>
 <f44878932fd26bb273c7948710b23b0e2768852a.camel@ibm.com> <CANr-nt2+Yk5fVVjU2zs+F1ZrLZGBBy3HwNOuYOK9smDeoZV9Rg@mail.gmail.com>
 <063856b9c67289b1dd979a12c8cfe8d203786acc.camel@ibm.com> <CANr-nt2bbienm=L48uEgjmuLqMnFBXUfHVZfEo3VBFwUsutE6A@mail.gmail.com>
 <a09665a84d11c3d184346b1f55515ac912b061c3.camel@ibm.com> <CANr-nt0nRZp=g2kbUqd5PoNbH-m9MWd_4x+LmR6x-gTT92MoVQ@mail.gmail.com>
 <4907d1ff5cd5a846188b2c9d77d110d926a37ac7.camel@ibm.com>
In-Reply-To: <4907d1ff5cd5a846188b2c9d77d110d926a37ac7.camel@ibm.com>
From: Hans Holmberg <hans@owltronix.com>
Date: Thu, 6 Feb 2025 09:00:09 +0100
X-Gm-Features: AWEUYZk1oWymAO0tivzc4PDnt_uFIZ6c8QzmNk589SrSt0_xIRlit5PPTit-q4Y
Message-ID: <CANr-nt2qRQUJJF_WwFGndANjb9=uSuY2Yzc-wsgtSZ9fUycgHw@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce generalized data temperature estimation framework
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "Johannes.Thumshirn@wdc.com" <Johannes.Thumshirn@wdc.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"javier.gonz@samsung.com" <javier.gonz@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 7:31=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2025-01-29 at 11:23 +0100, Hans Holmberg wrote:
> > On Tue, Jan 28, 2025 at 11:31=E2=80=AFPM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > >
>
> <skipped>
>
> > > >
> > >
> > > Another trouble here. What is the way to measure write amplification,=
 from your
> > > point of view? Which benchmarking tool or framework do you suggest fo=
r write
> > > amplification estimation?
> >
> > FDP drives expose this information. You can retrieve the stats using
> > the nvme cli.
>
> Do you mean that FDP drives has some additional info in S.M.A.R.T subsyst=
em?
> Does it some special subsystem in FDP drives? Is it regular statistics or=
 some
> debug feature of the device?

It's mandatory for FDP drives.

The "nvme fdp stats" nvme-cli command will report host and media bytes writ=
ten,
and you can calculate write amplification based on that.


>
> > If you are using zoned storage, you can add write amp metrics inside
> > the file system
> > or just measure the amount of blocks written to the device using iostat=
.
> >
>
> I see the point with iostat or blktrace, for example. But what do you imp=
ly by
> adding write amp metric inside the file system? Especially, if you are
> mentioning zoned storage. What is the difference here between conventiona=
l and
> zoned storage devices?

Since garbage collection happens on the host side for zoned storage, you ha=
ve to
measure the write amp there. It would be convenient to have the write
amp statistics
in the file system for this case (otherwise you have to count user
writes and device
writes through some other method). It adds some overhead though.

Cheers,
Hans

