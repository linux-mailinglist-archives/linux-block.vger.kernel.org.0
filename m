Return-Path: <linux-block+bounces-5497-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AC189308B
	for <lists+linux-block@lfdr.de>; Sun, 31 Mar 2024 10:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A56DB212EB
	for <lists+linux-block@lfdr.de>; Sun, 31 Mar 2024 08:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B809D143C6A;
	Sun, 31 Mar 2024 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aG0O5Vyu"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9A14386C
	for <linux-block@vger.kernel.org>; Sun, 31 Mar 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874751; cv=none; b=a9LyUkZCa6M7YEyx4MndwbyUO428pWKzmL+kf0uuzR5u9pk7ARr49BYkH7aIRK4g5P+igWm0o+6D7VSQxfRtAwyDi8wuH7ZzWEa7AUXGr8WtV9exzT2BTpVmvOJnLpSy8tzN4Wo3mKP3CAmwiMSLtuK8Qqz+CL/L0ziHMfKVRbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874751; c=relaxed/simple;
	bh=PP3MFzXOn0y5/ZwEiMfjnPaChdOWdaVsrRcHCUE4yLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyrvzNwzQ7Zf3W/ZvZSJosBgrVl+KqCHcnwQLo4FshaP4BLaQOW5TeSnCmCPEfWigi/LwtGPOj0Pn1OWn9AOJRyZ0yXmYtHkoGy2JYSYGHttF+AgZGtqvDq0GixxQ6EKMf99UaUzq5HiLtRnd+VENclO/oWpFiVJXapuTZ7UBz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aG0O5Vyu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-341cf28e013so2263244f8f.3
        for <linux-block@vger.kernel.org>; Sun, 31 Mar 2024 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711874746; x=1712479546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcNHdYD3uD4iwF1+LVPcIdLIGHnCmbVJHNncy5BFB3I=;
        b=aG0O5VyujCC81koLD95TDTDEG4uCpHUaAYiSGNt+boCc9zPZ/fXpH2PXP9kOkV91tB
         x63Pn6QEDck2OqgvWgGdXtP4VZ4aJ/arUwwh5GXW5G4gGY80g7K7N0kzoo8J225oCwfn
         L0LJgc4Kbz/THKIX95sCC4PNL0obTTE+wCKMWixEywVBE8bVsrGD9ws2OvVSQKaZV3H0
         a2tzj6fFGkfYuY5ZmT3zq560Bp2deH8ec2RrvwjpzMakeeYczWxPusQWj+i4lz+uO3mG
         Cnc9Y0fGq/1yQKTXs/HLE+trGki09rH5wVXKVDU5wxmvRc6x5Qy5AhbrTphWCGODVtUw
         sisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711874746; x=1712479546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcNHdYD3uD4iwF1+LVPcIdLIGHnCmbVJHNncy5BFB3I=;
        b=c5wVXWmUJAFjM6UJUdmHIh74AtBL7WoWqgpB6I1Z3RT5OF4EJSvRYJ5JquG+IbYHal
         IviCWLzBL4uNJ3D8tkwGse+YNsIFv2EM9q58On0Gp9L4ox1g8QLH0loMlTyMM6B2EkgF
         jaqIH1pKTiJJcX4SWs6URgKVqIPD22zp/BOErBOk2WeAHQ43RcJRq6aAJygpJfYIfRHD
         ztQikwVPigYrv+VxazqreBTdG0F2KD63g9XRR+tJGSAvVOGz+M66NaOQBBIQ4i0FfL0T
         oiQA8FcvLHWmB7TTgg/urMndGc0BC5p2k9DCHrlDHlRR/vBbbgMiW0C5DVI6hsJzXPAG
         jzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlwGHD5VisuzdHAM25+OfTmzTDO+dj1/la91HSEAe4mTq7Kikz+nDqSE9yBLKq4XJ0JBAh1APiDdop2F4AiON0P2GdcYNRzUXXzK8=
X-Gm-Message-State: AOJu0YzF5WSMPWlnAnDj8YQY6gPz483qGL5r+GI6zN4GT7BJdECaDTqC
	4JEJyRIfgsjd3A4BNssGHRZ0B7vgFsXz1EN0Y8+DJMgV6qLHPysMEenMWXScmLU=
X-Google-Smtp-Source: AGHT+IF/DueA2PBRDGmO2TtuT13FgHrtD/WPr3XSdbfSoaU6s/njcw/s8MH4eYl/SKdnKp3BHlPy/g==
X-Received: by 2002:a5d:5cd2:0:b0:33e:b7f8:7c66 with SMTP id cg18-20020a5d5cd2000000b0033eb7f87c66mr4407740wrb.41.1711874746454;
        Sun, 31 Mar 2024 01:45:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id k17-20020adff5d1000000b00341b7388dafsm8436003wrp.77.2024.03.31.01.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 01:45:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 31 Mar 2024 10:44:04 +0200
Subject: [PATCH v2 17/25] net: virtio: drop owner assignment
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240331-module-owner-virtio-v2-17-98f04bfaf46a@linaro.org>
References: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
In-Reply-To: <20240331-module-owner-virtio-v2-0-98f04bfaf46a@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jonathan Corbet <corbet@lwn.net>, 
 David Hildenbrand <david@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Richard Weinberger <richard@nod.at>, 
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
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Viresh Kumar <vireshk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, David Airlie <airlied@redhat.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Alexander Graf <graf@amazon.com>, 
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
 "James E.J. Bottomley" <jejb@linux.ibm.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=762;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PP3MFzXOn0y5/ZwEiMfjnPaChdOWdaVsrRcHCUE4yLI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmCSJffxI4Z5TfMYMSpOyODj20o+iKchhBt8eG2
 RcFp39ITi6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgkiXwAKCRDBN2bmhouD
 18c7EACVSj2LxuY1kDJ/a/5yYvVwRoXJ0BWK8qxjw2Gwc6iH+PJIF6JCQgfBSLRVpYvYMQK64uF
 iZwkwJ65d/TvVkabpkwfL2OmiRPAE+dFo3V4lSpPOCSOlansAs6zh3VKH3PYM0TfidHcD+MCu10
 4vJhU6fa7BhDh2kdu5Ozk8d287IgpHzB8eYA9IAINi7/N5MzYFWZYN0pgAAhWRyO4nlX8evTq/d
 8dhdUo7vMLKdbkMpy8vKM6O9PjvxJL4JBgXkjRjZrAPp4eM0wgy0x2dXV3DqFemJonOxszLocyA
 wtuS4XBUU5fC3R3VP/KyfCOyDCPrP5lGyjQ/sPuIAmO6z5MhQNKYmR8xpKWlY/XHDdxqUsfUgEf
 2t1ISEjXV051K1EKBmHegNm0025Ta/aO0EEYBV/AFvxLOd0YgjNIMKKD7sbJLQfaJuw25xA8+dz
 22GkSbPi5I8U8mC0xeGbjfa1JggSku6qvshxj+gJqo9uq+sP753PlE6uI/zFCXdQaZLw6Rl1B2f
 yOSSZxZxa1RX9I7zqcb/NsqeKJxLyKqhCz67IBEgjGZd1Jmv5pmDjdyTIblw5UQnDd3lT14wGKg
 VCOa58hRH95qkKaYhyXyK5gEH9pww+UPPk59LSTOybxso0+FjG9BIZT2AeNUH+7AgDpPx0kNkYx
 9uIlz+7tgwlhrbQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

virtio core already sets the .owner, so driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/net/virtio_net.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c22d1118a133..61f680699648 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5021,7 +5021,6 @@ static struct virtio_driver virtio_net_driver = {
 	.feature_table_legacy = features_legacy,
 	.feature_table_size_legacy = ARRAY_SIZE(features_legacy),
 	.driver.name =	KBUILD_MODNAME,
-	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.validate =	virtnet_validate,
 	.probe =	virtnet_probe,

-- 
2.34.1


