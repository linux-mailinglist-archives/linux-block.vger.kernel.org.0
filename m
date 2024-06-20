Return-Path: <linux-block+bounces-9179-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A1491122A
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2024 21:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8FE1C22258
	for <lists+linux-block@lfdr.de>; Thu, 20 Jun 2024 19:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D1B1AC765;
	Thu, 20 Jun 2024 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fePBovsf"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5FE1B47B0
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718911992; cv=none; b=Qt1Mn/KAErVMWsrFF+IINHOyCYpIsM7o0dQFhCKpsoXCVX0isiFX6GAoVBNDi4qXNWG4tHwat2NSAaHrkCAiPtyAI5wMw1jNWOewPtjQrjjHzMHxHGHniLrQDaVzr3QHKGdcdv8EVc3h4Yys7nw1EY7cxmG9Noe0nku0vYIXSJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718911992; c=relaxed/simple;
	bh=LMJhwXKqZKwDoZfSA47gsl66tl0ZA7Fm/pP5alDoprs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYXghtMI9gw3jyihY8kbHKoFXSl1vzxrP/ghiHFzNAQZ78mCEDQciA9MhsDtuBeU2AtY5jRvT4PYS/Oo80leDuCtkha1u+n1ZMQ+dVy/mlW4gSmsrp9T9hgWDon09LkkUuhjU/mXdjLorROYSAo6oGC9QxTTXTQyfjZpWa4kxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fePBovsf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a63359aaacaso189226866b.1
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718911989; x=1719516789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rxmltmQrKwAluprbf/AG1nvFIcYg57/7dnDwU0ucSDg=;
        b=fePBovsfiKBSZ/9WgVO2R/dT34vxZxnW7SQA6YJyxV0XBc7afhbaBEXctTb42BptUE
         Yg3mRd/x4R7MPgrcoe3m8c1ArW1SidcFtEWePSn/6Xmyi1Hqqu0bP6jKN+hb0mJ/IOFQ
         sNt2X8MQjedv77NcAKnZTAEoz2XmY0CS8zPDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718911989; x=1719516789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxmltmQrKwAluprbf/AG1nvFIcYg57/7dnDwU0ucSDg=;
        b=rxJFwRRcehzn3mSjYnN4bl3RKChc/LUGzknbMqNvh4n3sw0xEvJ6rCBUYn+NA919E4
         m6nhcKIPYw6/Un8A8StQIw2HdFdrTU8xn+giIu06NmtWwu1UgwvkIrdeDXKdi8P4fm1A
         NfltKmZSvVo3CdXXxKOI0+kxsqnYgWRtWwGNONKbWzGaFLBKRW7bBu0rt4kZXyq7K30B
         xUGQ5ZcqI7scEYi3k284LaH+3q2Ur6JRW9CQ/9NotShiMBUif8yIes4NfeyqAdc4O3jR
         one7/Vc0r1J+d7FhnbXJiQOnzWZWLBPgs8fCm9MIU18N7lWUTlPgBsYWpQu6htXm7HX0
         TGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCvoUvAgonrR9TUyHQQJcj5AgmXKLzvOUWMuv4Qisnt6TwV19b6CITyKziDtZNWrL//eDBARC0H3ooWRXGjZsQhWkpiFeTzjaV4oE=
X-Gm-Message-State: AOJu0Yw3CFHNcOj005IYdVwSGeDXJh3aXQNayPP95xjlaPPMahu0gWag
	l9owFMqawdYI20utn+HoXPLZwkY7AZMCzSJuDzian3qegrj98+O5zL+k5RYaaBJgHGnjen3VHgM
	kYurEnm4s
X-Google-Smtp-Source: AGHT+IG213eNms8Buaizy+esxb9a+aT9jtnBY2+rCu8a+nEstgknswNcgZch16P5t8CRcGoDFZGkgg==
X-Received: by 2002:a17:907:cb88:b0:a6e:fa0a:4899 with SMTP id a640c23a62f3a-a6fab605015mr518630066b.16.1718911989229;
        Thu, 20 Jun 2024 12:33:09 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf560238sm3088966b.143.2024.06.20.12.33.08
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 12:33:09 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f2d723ef0so992785f8f.1
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 12:33:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3pxulCltXK4Vy+8cXGFsXwrxH5eM5WSmuxX+PhoaqPzfwvc9GBGR6yIF/Jbe07PDcQo98FTTb6suOcRKws62g5lfFQi3SdOrZlrM=
X-Received: by 2002:a5d:6152:0:b0:35f:308a:cab0 with SMTP id
 ffacd0b85a97d-363170ecbe5mr4379764f8f.13.1718911595412; Thu, 20 Jun 2024
 12:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175703.605111-1-yury.norov@gmail.com> <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
 <ZnR1tQN01kN97G_F@yury-ThinkPad>
In-Reply-To: <ZnR1tQN01kN97G_F@yury-ThinkPad>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 12:26:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>
Message-ID: <CAHk-=wjv-DkukaKb7f04WezyPjRERp=xfxv34j5fA8cDQ_JudA@mail.gmail.com>
Subject: Re: [PATCH v4 00/40] lib/find: add atomic find_bit() primitives
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	"H. Peter Anvin" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Andersson <andersson@kernel.org>, Borislav Petkov <bp@alien8.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Disseldorp <ddiss@suse.de>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gregory Greenman <gregory.greenman@intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, 
	Jiri Pirko <jiri@resnulli.us>, Jiri Slaby <jirislaby@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Karsten Graul <kgraul@linux.ibm.com>, Karsten Keil <isdn@linux-pingi.de>, 
	Kees Cook <keescook@chromium.org>, Leon Romanovsky <leon@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Neukum <oneukum@suse.com>, Paolo Abeni <pabeni@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ping-Ke Shih <pkshih@realtek.com>, Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	GR-QLogic-Storage-Upstream@marvell.com, alsa-devel@alsa-project.org, 
	ath10k@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	mpi3mr-linuxdrv.pdl@broadcom.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 11:32, Yury Norov <yury.norov@gmail.com> wrote:
>
> Is that in master already? I didn't get any email, and I can't find
> anything related in the master branch.

It's 5d272dd1b343 ("cpumask: limit FORCE_NR_CPUS to just the UP case").

> > New rule: before you send some optimization, you need to have NUMBERS.
>
> I tried to underline that it's not a performance optimization at my
> best.

If it's not about performance, then it damn well shouldn't be 90%
inline functions in a header file.

If it's a helper function, it needs to be a real function elsewhere. Not this:

 include/linux/find_atomic.h                  | 324 +++++++++++++++++++

because either performance really matters, in which case you need to
show profiles, or performance doesn't matter, in which case it damn
well shouldn't have special cases for small bitsets that double the
size of the code.

              Linus

