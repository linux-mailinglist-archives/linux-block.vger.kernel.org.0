Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F99542BE95
	for <lists+linux-block@lfdr.de>; Wed, 13 Oct 2021 13:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJMLF5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Oct 2021 07:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229818AbhJMLF4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 07:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634123032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pm2HFBolkPmIutQKtnGVo/TAfScR5edRGy4d25/SdeA=;
        b=KD+D5y+PkswhupKI4VOQaOnKEuL0aMqNbVXb4jdTD/yk8hDkQZlx+7FHmnoJ+lbV37WTzE
        xEQc2FfXE1X0Q4auQ9u3G4Ba2FfjdP8q0Z5E22PxfYNzjaF8ppbeZkvzCaDBUfyJhJGVZH
        yfr9txkvaxa/rd4zUSbTP5m+ZyV9MCw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-BHNSTbosOQG2xYBDAZSJHA-1; Wed, 13 Oct 2021 07:03:51 -0400
X-MC-Unique: BHNSTbosOQG2xYBDAZSJHA-1
Received: by mail-wr1-f69.google.com with SMTP id 75-20020adf82d1000000b00160cbb0f800so1643114wrc.22
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 04:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=pm2HFBolkPmIutQKtnGVo/TAfScR5edRGy4d25/SdeA=;
        b=7iHvjBCXPOtPHaezIm/UJ0w5iu/zVjh5YE1I7lVKb2qkNSu+5fSbWQcqdk7WvgTYsl
         ae1KDiK1dGtcMzq6HtaMFeB9AqcabF39uqgkUOP/trvC30vZmyCXWWkjRlvMT1OErIhB
         1dXlXecixwjA9BJgq0HqmNDwKvspj0o0LnuNKLufkYIBs3t6M7rndS0Huj6I81Rg0IDg
         qW5BdqWJEXogK+dqE08ouEXjaVxiNXuELFIR3ertl36yjUkXcPKyx2YAJkKxhcmsGuwT
         dbbAHx4meJx3lPrVjsnbE6Mt73Rg5GLK7lWt4p8lXKt39axK4OQdS4tWXWqj7VT7UJ7E
         GzAw==
X-Gm-Message-State: AOAM532F39ivo2vNVyasJoZqoRJTZuvPTDYUgYmMPLWXdbmkihcrHfwz
        3r182As77E8AaIqndvgcuJfBwYbagwo0s2XiIIXuH46LDjOLDUDsBl8m+2V2JPxVB0hVYVUM0lS
        jUQSd0CQlV1zG5RPDzOLaxvs=
X-Received: by 2002:adf:a194:: with SMTP id u20mr39899242wru.275.1634123030423;
        Wed, 13 Oct 2021 04:03:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypxsxhU5d6LZPZIfUUDegUVRR2UQLEo64TMqEnAh5Ix5FGAFA1VDGCfrTQu99KLNCm64Sq/Q==
X-Received: by 2002:adf:a194:: with SMTP id u20mr39899137wru.275.1634123030054;
        Wed, 13 Oct 2021 04:03:50 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6774.dip0.t-ipconnect.de. [91.12.103.116])
        by smtp.gmail.com with ESMTPSA id m4sm5183560wrz.45.2021.10.13.04.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 04:03:49 -0700 (PDT)
Subject: Re: [PATCH RFC] virtio: wrap config->reset calls
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gonglei <arei.gonglei@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Viresh Kumar <vireshk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jie Deng <jie.deng@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Anton Yakovlev <anton.yakovlev@opensynergy.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-um@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, kvm@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <20211013105226.20225-1-mst@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <2060bd96-5884-a1b5-9f29-7fe670dc088d@redhat.com>
Date:   Wed, 13 Oct 2021 13:03:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211013105226.20225-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13.10.21 12:55, Michael S. Tsirkin wrote:
> This will enable cleanups down the road.
> The idea is to disable cbs, then add "flush_queued_cbs" callback
> as a parameter, this way drivers can flush any work
> queued after callbacks have been disabled.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   arch/um/drivers/virt-pci.c                 | 2 +-
>   drivers/block/virtio_blk.c                 | 4 ++--
>   drivers/bluetooth/virtio_bt.c              | 2 +-
>   drivers/char/hw_random/virtio-rng.c        | 2 +-
>   drivers/char/virtio_console.c              | 4 ++--
>   drivers/crypto/virtio/virtio_crypto_core.c | 8 ++++----
>   drivers/firmware/arm_scmi/virtio.c         | 2 +-
>   drivers/gpio/gpio-virtio.c                 | 2 +-
>   drivers/gpu/drm/virtio/virtgpu_kms.c       | 2 +-
>   drivers/i2c/busses/i2c-virtio.c            | 2 +-
>   drivers/iommu/virtio-iommu.c               | 2 +-
>   drivers/net/caif/caif_virtio.c             | 2 +-
>   drivers/net/virtio_net.c                   | 4 ++--
>   drivers/net/wireless/mac80211_hwsim.c      | 2 +-
>   drivers/nvdimm/virtio_pmem.c               | 2 +-
>   drivers/rpmsg/virtio_rpmsg_bus.c           | 2 +-
>   drivers/scsi/virtio_scsi.c                 | 2 +-
>   drivers/virtio/virtio.c                    | 5 +++++
>   drivers/virtio/virtio_balloon.c            | 2 +-
>   drivers/virtio/virtio_input.c              | 2 +-
>   drivers/virtio/virtio_mem.c                | 2 +-
>   fs/fuse/virtio_fs.c                        | 4 ++--
>   include/linux/virtio.h                     | 1 +
>   net/9p/trans_virtio.c                      | 2 +-
>   net/vmw_vsock/virtio_transport.c           | 4 ++--
>   sound/virtio/virtio_card.c                 | 4 ++--
>   26 files changed, 39 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
> index c08066633023..22c4d87c9c15 100644
> --- a/arch/um/drivers/virt-pci.c
> +++ b/arch/um/drivers/virt-pci.c
> @@ -616,7 +616,7 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
>   	int i;
>   
>           /* Stop all virtqueues */
> -        vdev->config->reset(vdev);
> +        virtio_reset_device(vdev);
>           vdev->config->del_vqs(vdev);

Nit: virtio_device_reset()?

Because I see:

int virtio_device_freeze(struct virtio_device *dev);
int virtio_device_restore(struct virtio_device *dev);
void virtio_device_ready(struct virtio_device *dev)

But well, there is:
void virtio_break_device(struct virtio_device *dev);

-- 
Thanks,

David / dhildenb

