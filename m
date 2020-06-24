Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7A4207B84
	for <lists+linux-block@lfdr.de>; Wed, 24 Jun 2020 20:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405947AbgFXS2n (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Jun 2020 14:28:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44001 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405914AbgFXS2m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 14:28:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id w2so998629pgg.10
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 11:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SAQYeh+8UWj+mTP1/uBOaQWSCarRWB94vNxrgsP23hQ=;
        b=fUNfURrn9XRzU8tzkvNAbFhMhSWOWYg0hxDGLfi+kuL9b0vWEP5GfxozJw1sh6FqTX
         G73oT6jPFVxwDwXuvhqnLik9T+Nw0m9J2WN9MjtcoWndwFvJCMcBZ3mwA8wLGYIuyQty
         ls7uksJG1DR+RtPRS05Zc03L9aeXofgG8ytSU4goD0IsW+usHQjb1avswLYnAjnxV+n0
         dYUKwBoAbH73KZXR4NT6LIb4WvfOHXZeO8CXIjjHsrjigP2XewMip58UQY8+d9InMK3W
         8QdlO2ZezvLoMV1VY31ctM6RG6mwpB1hNn+teK82amyBuoNAGGEIvYK5RglKqpOwb+BD
         5JQQ==
X-Gm-Message-State: AOAM530qg31UoGIj/JH4VmcpCvYZTWyiO6Kp86R3iFvDJOkFseDiM0Ko
        /UZAy7UKhFZ/j834Z1LX8xI=
X-Google-Smtp-Source: ABdhPJyRwXLD2BVKbOvZqH5DBuIEvcp7Q+LIcA8yakrftiWhFhhAkxk1Y3Kk6KGMP0WPN5S4yHrVAA==
X-Received: by 2002:a65:620f:: with SMTP id d15mr13851822pgv.270.1593023322241;
        Wed, 24 Jun 2020 11:28:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947? ([2601:647:4802:9070:4c08:474f:e61d:6947])
        by smtp.gmail.com with ESMTPSA id j16sm11442629pgb.33.2020.06.24.11.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 11:28:36 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
To:     Keith Busch <kbusch@kernel.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
Date:   Wed, 24 Jun 2020 11:28:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> And what if it is a DNR error? For example, the controller simply
>>> doesn't support this CNS value. While the controller should support it,
>>> we definitely don't need it for NVM command set namespaces.
>>
>> Maybe I mis-undersatnd the comment, but if you see a DNR error, it means
>> that the controller replied an error and its final, so then you can have
>> extra checks.
> 
> If the controller does not support the CNS value, it may return Invalid
> Field with DNR set. That error currently gets propogated back to
> nvme_init_ns_head(), which then abandons the namespace. Just as the code
> coments say, we had been historically been clearing such errors because
> we have other ways to identify the namespace, but now we're not clearing
> that error.

I don't understand what you are saying Keith.

My comment was for this block:
--
	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
			 nsid);
		status = -EINVAL;
	}
--

I was saying that !status doesn't necessarily mean success, but it can
also mean that its an retry-able error status (due to transport or
controller). If we see a retry-able error we should still clear the
status so we don't abandon the namespace.

This for example would achieve that:
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba512c45b40f..46d8a8379aff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1126,12 +1126,21 @@ static int nvme_identify_ns_descs(struct 
nvme_ctrl *ctrl, unsigned nsid,
         if (status) {
                 dev_warn(ctrl->device,
                         "Identify Descriptors failed (%d)\n", status);
-                /*
-                 * Don't treat an error as fatal, as we potentially already
-                 * have a NGUID or EUI-64.
-                 */
-               if (status > 0 && !(status & NVME_SC_DNR))
-                       status = 0;
+
+               if (status > 0 && !(status & NVME_SC_DNR)) {
+                       if (nvme_multi_css(ctrl) && !csi_seen) {
+                               dev_warn(ctrl->device,
+                                       "Command set not reported for 
nsid:%d\n",
+                                       nsid);
+                               status = -EINVAL;
+                       } else {
+                               /*
+                                * Don't treat an error as fatal, as we
+                                * potentially already have a NGUID or 
EUI-64.
+                                */
+                               status = 0;
+                       }
+               }
                 goto free_data;
         }
--
