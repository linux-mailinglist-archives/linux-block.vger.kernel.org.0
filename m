Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E722917CA
	for <lists+linux-block@lfdr.de>; Sun, 18 Oct 2020 16:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgJROF0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 18 Oct 2020 10:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbgJROFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Oct 2020 10:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603029898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kBVMPnQfqrYuRmZ0mFLSkNqYWCaxPfshC6ZYuKW12NQ=;
        b=CE3TTm0ZWS3xUbYzjwLA7+TYTk7Dg+VxIL4Zp73oDsqTuzAXXNjBX0Doq5M5Cu6ffXkYev
        bZ3C9BpL47kMqRFuXYSmeuVfmCYD0R8cyybmNyMbwair6n3qDaCsRQ2KiiaxG8Fe9Zs8sm
        6xUrramWNvo4ZIP3aUKUh3vEKSsfIgI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-HkggFhigOoy8_eC2kb-9bA-1; Sun, 18 Oct 2020 10:04:56 -0400
X-MC-Unique: HkggFhigOoy8_eC2kb-9bA-1
Received: by mail-qk1-f198.google.com with SMTP id d5so5473048qkg.16
        for <linux-block@vger.kernel.org>; Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kBVMPnQfqrYuRmZ0mFLSkNqYWCaxPfshC6ZYuKW12NQ=;
        b=Agq6bWGZrJifxapLvAyYPvmSMm+6+gvUeUPtqRvpOXdJCdjn502CWebc9ALwRjaoe6
         4OCMvf5BaOk0l8QJJRPeEqFlEWtyRb9ebF0lxeE+9GUuwAs0sxLyk96VO15g8AsbtK83
         /VbkK0Vy5Nu+dptl9k63bxUmLfgEWcZrs+uQm2juPnL3mqWaP2iOcrufep99EngRamym
         no96NRG+gASkm/R9DPyaTHMOtpWu33OgPDsuQnYVkVGRnHMS7dszZ4f/Dm4oQ7uqBUBB
         Hyo+kQNGLUsBMnuHfi5roDmxMZRxBP/BBtnpCbfjsPs/DZNt4HaIaBSjlDtdOWnLKTXj
         b9ww==
X-Gm-Message-State: AOAM532DsXNsnnfBFH3IUjqPAHO7Lo74gRbCTvtUXGHmmMq/Ivi/D+lb
        f6LrIRIrSnTf85evVR+KQoCkI5WbpsyFgT7enubWC9ngfB/XI4/3uT3UTmgOEfmUzXXyw7it9Kk
        or3NbKJBr0MOsfmGCSHmPBbk=
X-Received: by 2002:a05:620a:1287:: with SMTP id w7mr12724325qki.436.1603029896366;
        Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6z5rS79nBj0nCbIqVRZ9qmkAzjArqewdITB0rtwnhi1UUe/kvxLZTENMJDRITA4iBlrUAlw==
X-Received: by 2002:a05:620a:1287:: with SMTP id w7mr12724258qki.436.1603029896034;
        Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u16sm3288927qth.42.2020.10.18.07.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 07:04:55 -0700 (PDT)
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        industrypack-devel@lists.sourceforge.net,
        linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-nfc@lists.01.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com,
        storagedev@microchip.com, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net,
        linux-watchdog@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        bpf@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        alsa-devel@alsa-project.org, clang-built-linux@googlegroups.com
References: <20201017160928.12698-1-trix@redhat.com>
 <20201018054332.GB593954@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <eecb7c3e-88b2-ec2f-0235-280da51ae69c@redhat.com>
Date:   Sun, 18 Oct 2020 07:04:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201018054332.GB593954@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 10/17/20 10:43 PM, Greg KH wrote:
> On Sat, Oct 17, 2020 at 09:09:28AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> This is a upcoming change to clean up a new warning treewide.
>> I am wondering if the change could be one mega patch (see below) or
>> normal patch per file about 100 patches or somewhere half way by collecting
>> early acks.
> Please break it up into one-patch-per-subsystem, like normal, and get it
> merged that way.

OK.

Thanks,

Tom

>
> Sending us a patch, without even a diffstat to review, isn't going to
> get you very far...
>
> thanks,
>
> greg k-h
>

