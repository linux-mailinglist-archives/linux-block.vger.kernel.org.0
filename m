Return-Path: <linux-block+bounces-27023-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C93B50333
	for <lists+linux-block@lfdr.de>; Tue,  9 Sep 2025 18:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC987A66FA
	for <lists+linux-block@lfdr.de>; Tue,  9 Sep 2025 16:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8E835336F;
	Tue,  9 Sep 2025 16:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b="NPtZY0ZT"
X-Original-To: linux-block@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A62797A7
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436656; cv=pass; b=EBE3cJZiCoWcyTvgNVMcEp/d68fLxlsX4VlR/rXjMsAj/0mLKHwGY85hcKSN42wZnRY3sFqMwqFuTOpSDS16yTNPnA67YRz7uy0lelvKhx/Nf9stbq5KEHyd7icxac9a16WhvPBnRvd1Q7usrX/Drg8AcmpqRSJxvFWxrHs/fX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436656; c=relaxed/simple;
	bh=JBBoQ8TWsmsHOqvf2YeTeo1MD7sBN48rrpem15UnyQQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=QjctDa0kN/qQ+1JqBUypr2VqJ/uVmXDHhlFyF3K+9Cn6DJQhEb2j3jhAfhWcrQ8nOKS88aMcNSn5XfnWU4mIPpVLpi2pBiUtgWaZKun9a85/SeRVTjqW6R5JockiHgChP371nT4GNGNojukHGDYzVxptJD7JEyzmM89r02ZHaes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=bob.beckett@collabora.com header.b=NPtZY0ZT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757436640; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DFoUism+IkLw9QreGKfBd587z+dU2pfKH45vQfnR6AsOni2A+hcYqvb0eGI5YmP0lq33PHLYpyXQZmh1YJwkfxISYJUKg68yyZSh1NZCqJ1ostCEyx2l97rCm756hRVHRCOdqcpQXeb1QRDmdK+siHuOz66gmoVyk1IbP4aZ1kI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757436640; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hitEiwKn4XLBjoJ1lCdJpzRdbm/tiRsfKolLG73pv3k=; 
	b=M2KVLwJSfHfdo+Xacet1g35b8bMJt8er1wQJRxUMHzdKyeNhUI3G0go1HZlMpHHPI1VP/aFHLo60B3mEdnE+z0Gi35zjHMDFoAp204x1N/jxlMzUJJ9fLGQ9SBQmIVSw/ICLR5Y+kjb9QMeE61mZmjUU/gYJT9EwLfoR/lcvKjM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757436640;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hitEiwKn4XLBjoJ1lCdJpzRdbm/tiRsfKolLG73pv3k=;
	b=NPtZY0ZTs1uZMmPyQZqWH78qPNAYYP5jII/updbH0dJsvbAFUK2svy/rNcS+Rv6M
	vRZFn/BEH/w2u6Cg4c8dmJWeD9c6aYoVkS9eyfGfj/TyYv1N6JVPZdFC0xjifazROcg
	aK2xSuk98UdanRwzbnNTeLpJh7Wl73eAZ0Pvn5p4=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1757436608797953.4772012543705; Tue, 9 Sep 2025 09:50:08 -0700 (PDT)
Date: Tue, 09 Sep 2025 17:50:08 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "Mikulas Patocka" <mpatocka@redhat.com>
Cc: "dm-devel" <dm-devel@lists.linux.dev>,
	"linux-block" <linux-block@vger.kernel.org>,
	"kernel" <kernel@collabora.com>
Message-ID: <1992f628105.2bf0303b1373545.4844645742991812595@collabora.com>
In-Reply-To: <2d517844-b7bf-3930-e811-e073ec347d4a@redhat.com>
References: <1992a9545eb.1ec14bf0659281.6434647558731823661@collabora.com> <2d517844-b7bf-3930-e811-e073ec347d4a@redhat.com>
Subject: Re: deadlock when swapping to encrypted swapfile
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail


 ---- On Tue, 09 Sep 2025 15:37:09 +0100  Mikulas Patocka <mpatocka@redhat.com> wrote --- 
 > 
 > 
 > On Mon, 8 Sep 2025, Robert Beckett wrote:
 > 
 > > Hi,
 > > 
 > > While testing resiliency of encrypted swap using dmcrypt we encounter easily reproducible deadlocks.
 > > The setup is a simple 1GB encrypted swap file [1] with a little mem chewer program [2] to consume all ram.
 > > 
 > > [1] Swap file setup
 > > ```
 > > $ swapoff /home/swapfile
 > > $ echo 'swap /home/swapfile /dev/urandom swap,cipher=aes-cbc-essiv:sha256,size=256' >> /etc/crypttab
 > > $ systemctl daemon-reload
 > > $ systemctl start systemd-cryptsetup@swap.service
 > > $ swapon /dev/mapper/swap
 > > ```
 > 
 > I have tried to swap on encrypted block device and it worked for me.
 > 
 > I've just realized that you are swapping to a file with the loopback 
 > driver on the top of it and with the dm-crypt device on the top of the 
 > loopback device.
 > 
 > This can't work in principle - the problem is that the filesystem needs to 
 > allocate memory when you write to it, so it deadlocks when the machine 
 > runs out of memory and needs to write back some pages. There is no easy 
 > fix - fixing this would require major rewrite of the VFS layer.
 > 
 > When you swap to a file directly, the kernel bypasses the filesystem, so 
 > it should work - but when you put encryption on the top of a file, there 
 > is no way how to bypass the filesystem.
 > 
 > So, I suggest to create a partition or a logical volume for swap and put 
 > dm-crypt on the top of it.
 > 
 > Mikulas
 > 
 > 

Yeah, unfortunately we are currently restricted to using a swapfile due to many units already shipped with that.
We have longer term plans to dynamically allocate the swapfiles as neded based on a new query for estimated size
required for hibernation etc. Moving to swap partition is just not viable currently.

I tried halving /sys/module/dm_mod/parameters/swap_bios but it didn't help, which based on your more recent
reply is not unexpected.

I have a work around for now, which is to run a userland earlyoom daemon. That seems to get in and oomkill in time.
I guess another option would be to have the swapfile in a luks encrypted partition, but that equally is not viable for
steamdeck currently.

However, I'm still interested in the longer term solution of fixing the kernel so that it can handle scenarios
like this no matter how ill advised they may be. Telling users not to do something seems like a bad solution :)

Do you have any ideas about the unreliable kernel oomkiller stepping in? I definitely fill ram and swap, seems like
it should be firing.

Thanks

Bob




