Return-Path: <linux-block+bounces-5195-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B6C88E60F
	for <lists+linux-block@lfdr.de>; Wed, 27 Mar 2024 15:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69435B3286C
	for <lists+linux-block@lfdr.de>; Wed, 27 Mar 2024 14:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951614D6F2;
	Wed, 27 Mar 2024 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTWrnRZy"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DCD14D6FB
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543546; cv=none; b=E3LahwSLUgifJj128xuyRnY7Qi8r3hg5VIVY9nlzzyGyhgP6pp2oK9SwjtG3KewWf/eGb9aLKE9cn1Z7V8QXA9nXmlugsR4frE4mO3jQiu0/pUvk8vkwUUn8CzcnEy9kzAJZulThIyNblXNX6fxD0nQWCKZ/D6XAjYoI3z5J84A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543546; c=relaxed/simple;
	bh=rkTpT83OyeYcLFTcFWPlfq1EO9ueUCyja/WSxZqw7hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kva205nLlYMPV5K+ZZh+xMnLBjTrlQpDmxKhkxcQcEa7ATXg3CjHFSXGn7lanW+WKXWO3pZ6kj4zJgasGB8snsaHDskdFpxQQuBZt/hQ+E3ypHg70xUfe4uLlNTR8Ee2uUdeiA4v+EGB1Ln4WKn61bNdXQBV8uY3CuYmIsvMn4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CTWrnRZy; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a468226e135so801818266b.0
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711543541; x=1712148341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpODOh8SpqDydjsGmjw6Via7WFpVB11YsZ1xvZ5Vpsw=;
        b=CTWrnRZyHjgopRqWxK71Y9OtyP4jI7P6Yln2eT1A5GdnEYaKtZAlJbwegKWIXTRGwG
         yKyTwOpd0bmP+d+wN+BzHEwRS0dx7Gx+K6NaN2ViVEGy6xmqBJEFgQeFFbOPTi2+6nHd
         V4akdFn6iVaDCwHYAdztfI4v4ReidLZKMpVKeaNRkAaBcrkTEiN73JzHKa6GyOwlQf3i
         QxQLoQ+HH0lrrjFygeUSJqboKR7h5cumnuVJIhKk0V0kC2GQSgjjseCsyqwuvhDbw0NH
         BcpxdmPpNcdlNJba+7J1eZE7AliWoSfGsQKOVzFtnTDVWNVybN2F8PoTJNw5OnfHwQij
         IvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543541; x=1712148341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpODOh8SpqDydjsGmjw6Via7WFpVB11YsZ1xvZ5Vpsw=;
        b=HNZQJNeKEOwiv4nGYd3tIzdWwtXVoOe7BR7430kdiNJmkhIjgkEx1YQLWyeatLdVZi
         uuQ5NRnRO4fzIXMwfhGnjup9pyiERYDfpxaGwRK5zlSHR2RqvDQD3CzCC4ogpFH1F8Gz
         iBhxTDDvk3VBVD0R6pGtEL3/eO/+Hth9p4f9i2IohDWbL0scAe1t/8JALodld+VoTYNY
         EIjs/3XzJ/6T8KVy4qCdFuF0NYeHIg2RP4NfE6aDt3QbnbnwKWlpvTmBBC2v4dpTuuxa
         X6FkbIoiDH5/s1NB25Dja3v6djj6Ua4SPsckvaw3rvpSCqoonNo+qV//yMBiskUjHGQr
         /vzA==
X-Forwarded-Encrypted: i=1; AJvYcCVE84+b2s6k8r5HPwcGb57ctbtNIodIHv1BQoXq6CoxfHdSXdRE8OUvTdcmUsqVdpeVGskHugTYI/9/wqaW9mEun0Ukxg1O3MSh1B8=
X-Gm-Message-State: AOJu0YyGgf4hyI74ykGkECWyCVP2moXTtBEMilfzpV9KUhZZSvK977JW
	7bhlyfGtzt7g2lMNJU6F9WtsagruZ/t3+EuKEoVnmaZCg6DZcdwGvkjPYVkVrnzZpNzgZDkXD5f
	K
X-Google-Smtp-Source: AGHT+IEcvI6eWDqWD1PBGrew0jG/V5c4yhsfSwGlGbpPcqAQ0aJsRX7Gtm1g92tL7NJRpTYESthDyw==
X-Received: by 2002:a17:906:5910:b0:a4d:f0c3:a9e9 with SMTP id h16-20020a170906591000b00a4df0c3a9e9mr3515531ejq.28.1711543541620;
        Wed, 27 Mar 2024 05:45:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.205])
        by smtp.gmail.com with ESMTPSA id gx16-20020a170906f1d000b00a4707ec7c34sm5379175ejb.166.2024.03.27.05.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:45:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 13:41:05 +0100
Subject: [PATCH 12/22] misc: nsm: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-virtio-v1-12-0feffab77d99@linaro.org>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
In-Reply-To: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Jens Axboe <axboe@kernel.dk>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Olivia Mackall <olivia@selenic.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Amit Shah <amit@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Gonglei <arei.gonglei@huawei.com>, "David S. Miller" <davem@davemloft.net>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Kalle Valo <kvalo@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, 
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Anton Yakovlev <anton.yakovlev@opensynergy.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev, 
 kvm@vger.kernel.org, linux-wireless@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, alsa-devel@alsa-project.org, 
 linux-sound@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=780;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rkTpT83OyeYcLFTcFWPlfq1EO9ueUCyja/WSxZqw7hc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBBPkwT30jL7yE3CaV8BYCN+/iF2QF578w++SH
 K+O+AlOBQGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgQT5AAKCRDBN2bmhouD
 1+hfD/9LpFlPpmo0LIxovBV8yHSMe527wWwFBJ/jtDNTokOT1qr5tsLO6Gblc437dKLraA6Id5O
 jyjhJkIiVy3XO1NdcfudmUFdTqABE9vcJJKQhW2nT4ribKRBHNQme4adAnbw7QNCLUPa806/fgS
 hkQlx8/2Did8dJ5+92jQUozhcu9vo3nLWq0cSjHv/Venr0g8dJXzd8FiQQGQMeeBd1VPS1E491n
 GYPDAvFyKRPnmetuDQm7BK2utJbC9d0MLMFC5wI875XRWP0DQAEaXM7H0Yehh08/eq7Wh9WO3Di
 UZfnUJ1mB4s8b2z5PL7WG2MTG/EClvSwWR7VW8CT/hTsmT8N0qeBl31u/eygtYUrOn0XZiNYhSL
 YgP1CFY7lKJOkXB0n4rHAuFcdTNRFe4DL6uh2reZdn5D4tM7z0KursxDh3t5J7uDGR6XbLzueIo
 19ZZXkrXjB+eF9EnnUO6Q3loSOL2FDGBs0yP9CvyrDFeo4Ly3qbfLqqQxcoUysY/PtlCvOuJK/H
 54zdsxocH/qjiDsZwX9NxtaTbc5uj5fQhJAUrGSetA3lLsGQ+GXf7Nter9+bEVuW3gUjfj0hGM0
 wooTlvC1TzDHtqrYqiqdZa/UE9CD5vso4YDeEkuh03eSXDjDIwsAWssPYOOxEY20BlNvAOen5cF
 w6kXIs+XeHqgVjA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/misc/nsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/nsm.c b/drivers/misc/nsm.c
index 0eaa3b4484bd..ef7b32742340 100644
--- a/drivers/misc/nsm.c
+++ b/drivers/misc/nsm.c
@@ -494,7 +494,6 @@ static struct virtio_driver virtio_nsm_driver = {
 	.feature_table_legacy      = 0,
 	.feature_table_size_legacy = 0,
 	.driver.name               = KBUILD_MODNAME,
-	.driver.owner              = THIS_MODULE,
 	.id_table                  = id_table,
 	.probe                     = nsm_device_probe,
 	.remove                    = nsm_device_remove,

-- 
2.34.1


