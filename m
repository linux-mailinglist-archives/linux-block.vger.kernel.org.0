Return-Path: <linux-block+bounces-5441-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971F891F73
	for <lists+linux-block@lfdr.de>; Fri, 29 Mar 2024 16:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8FE28ABA2
	for <lists+linux-block@lfdr.de>; Fri, 29 Mar 2024 15:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AC9142E90;
	Fri, 29 Mar 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAX6OoVD"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93134142916
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718922; cv=none; b=RktWPmyuqRITJAcCrPXTzuwluYFR9ma1VfHAEmL5dVoF9rvDSfgIVysENmydvmJuIToFrvFDGO7Nn2CwHY7AJUqfusWex7/8eBxGhZepP5cTEeZ29u9/m5PUH3LtojFh1AEV0x+cxBbwdsLKZ3mR+ndNEtU1Ey7ZTgLITYND78k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718922; c=relaxed/simple;
	bh=zlmV0sBDPPllGZWjPqa2/c1/r7nXDK5/rzJZO9Fvals=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9kHh8zt8OPkDBCbUXWPuUVnwEW4JIexL7R2x7SpqHqRC6o3gTjpKzW41gw0VQ0V9iFxrhRwG5pgxfpVXZxFGZ6SYcGbyhzxbXUkJ0HtRXs3GSlb7YG8XJReFIbAXht7NW+cYKNz9EKp8UwTaYM0pqEVxMHUa76RNxvqaIwp72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAX6OoVD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711718919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9b2+syugljaMrrOP++3j3QqL3+aM8ytb7iOaLk3Q4wQ=;
	b=CAX6OoVDVnn52AkgtNnO3Pc2KcUioajNI90CLWKUrPSq4ltweMNUzvIELD8senVcJ0GUbF
	N0NgMJrwzTSm+/4p5AoQcnc4xptC4GKZOcFGmutNKXHp2YLmT5iOWKr+QuJnhECCY4WBiE
	yWeh1JnPEuYKzpzT5i9TCnhPmhKn+5c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-FwEgI0nmOhSbPiUKmtJ2cg-1; Fri, 29 Mar 2024 09:28:36 -0400
X-MC-Unique: FwEgI0nmOhSbPiUKmtJ2cg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed26afd99so1048596f8f.0
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 06:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711718915; x=1712323715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b2+syugljaMrrOP++3j3QqL3+aM8ytb7iOaLk3Q4wQ=;
        b=b/Gwug3oovL8gS+hRCoSP8lvVM6OYwIa81c14mO2aZ8oWxuIicVgpdbqQddxo6pG/t
         GMgtqrrpA9GcHe/28cAgjCD6Vua9zx95X/dyT/3H1WZbdSgrk/vjGIjSmuq1mbkguBVR
         K0Tz46UCH0E3UO/dfRr7d+hYO9BX/dFTpdSq/AKhebhYAfsrusFBKcTdX7W2OgCnB4Fl
         bwEr73MXESVDByFRlsV4ucaUCgx9ZrzPcO+BWvPwVf9tJUhAPfCgXDKALYVfMX6Argq1
         SbvsuURdLVe80vm0whxs8bHmoc4+vNESQpvMdjCDWS5CiwzaEJGFynOu2f5ItkYCZT+k
         FjBA==
X-Forwarded-Encrypted: i=1; AJvYcCWHDTLRScpsiP5cjFZN6SeL6NpmOrD3/s5UDzcYg4tMpuvSbv1OtJD98YEygnRk1LG0iCPYgB30OWQklgYq1ZBPscb0a7fXLy6Xqsk=
X-Gm-Message-State: AOJu0Yzkr3uNDhxigvLEnCOL2zEkPXnZdrNE02+OsfdkJ95df0ZiDXin
	KXmGmXhDV1At74f5PlacGCMD3DUFiv0ItviO58OiHrariaFqSspF3sAOWX/ns7mQbeksQyhUoIp
	ttyparIVbFijJnJEX32lpONmLO9fHqrEP/Cqzi7YCIlNFji/2IDGh85b9h714
X-Received: by 2002:a05:6000:258:b0:343:3e54:6208 with SMTP id m24-20020a056000025800b003433e546208mr405064wrz.55.1711718915570;
        Fri, 29 Mar 2024 06:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0y693U6Mrafzyu7YFm6f17FVsvRLIAvGL111PeLg9URymVxfxN4rrw7+XNw571qiaGR1ycw==
X-Received: by 2002:a05:6000:258:b0:343:3e54:6208 with SMTP id m24-20020a056000025800b003433e546208mr405040wrz.55.1711718915211;
        Fri, 29 Mar 2024 06:28:35 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id e11-20020a056000194b00b00341c6b53358sm4171063wry.66.2024.03.29.06.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:28:34 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:28:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gonglei <arei.gonglei@huawei.com>, 
	"David S. Miller" <davem@davemloft.net>, Viresh Kumar <vireshk@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, Kalle Valo <kvalo@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Anton Yakovlev <anton.yakovlev@opensynergy.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	v9fs@lists.linux.dev, kvm@vger.kernel.org, linux-wireless@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 01/22] virtio: store owner from modules with
 register_virtio_driver()
Message-ID: <e2xy5kjdctpitcrev2byqc5gcwntvsd6pfutrvp3l2kfe3llgs@l2xp5opj7xu2>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-1-0feffab77d99@linaro.org>
 <oaoiehcpkjs3wrhc22pwx676pompxml2z5dcq32a6fvsyntonw@hnohrbbp6wpm>
 <d01cc73e-a365-4ce8-a25f-780ea45bc581@linaro.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d01cc73e-a365-4ce8-a25f-780ea45bc581@linaro.org>

On Fri, Mar 29, 2024 at 01:07:31PM +0100, Krzysztof Kozlowski wrote:
>On 29/03/2024 12:42, Stefano Garzarella wrote:
>>> };
>>>
>>> -int register_virtio_driver(struct virtio_driver *driver)
>>> +int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
>>> {
>>> 	/* Catch this early. */
>>> 	BUG_ON(driver->feature_table_size && !driver->feature_table);
>>> 	driver->driver.bus = &virtio_bus;
>>> +	driver->driver.owner = owner;
>>> +
>>
>> `.driver.name =  KBUILD_MODNAME` also seems very common, should we put
>> that in the macro as well?
>
>This is a bit different thing. Every driver is expected to set owner to
>itself (THIS_MODULE), but is every driver name KBUILD_MODNAME?

Nope, IIUC we have 2 exceptions:
- drivers/firmware/arm_scmi/virtio.c
- arch/um/drivers/virt-pci.c

>Remember that this overrides whatever driver actually put there.

They can call __register_virtio_driver() where we can add the `name`
parameter. That said, I don't have a strong opinion, we can leave it
as it is.

Thanks,
Stefano


