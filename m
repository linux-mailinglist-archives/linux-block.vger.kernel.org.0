Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C645EDEB1
	for <lists+linux-block@lfdr.de>; Wed, 28 Sep 2022 16:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiI1OWs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 28 Sep 2022 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiI1OWo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Sep 2022 10:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA1A99FA
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664374962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8eB83t+uAXU0eeIFIBcJy7R/AwuzdJ0SXvnM1E+9aQE=;
        b=UMlbsaRjw0QOlzFlW4msEY+0xq8NEHd/DA4fOxqqRs5wdEOyfHqtjyD9YQI9A0gksAYMGQ
        mtHEi83IIYPlvJCleuybERVuc30qTjJauQS1mzOVD7pET3CsB4GTIQ1dVlV4qVCXDnM33G
        JPbEBZWsfFano545EtUdIIvE0qM2axc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-445-y3iV-9nKNHebz3rx0sKdFg-1; Wed, 28 Sep 2022 10:22:39 -0400
X-MC-Unique: y3iV-9nKNHebz3rx0sKdFg-1
Received: by mail-qv1-f71.google.com with SMTP id lx3-20020a0562145f0300b004af5fb266ebso6645268qvb.12
        for <linux-block@vger.kernel.org>; Wed, 28 Sep 2022 07:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8eB83t+uAXU0eeIFIBcJy7R/AwuzdJ0SXvnM1E+9aQE=;
        b=yn+/zbQM9AT7siyBq7prtKbqaA70sETOg+cC1qUAL4/jJ9oYYuKOmgaAie0OmREANP
         xd6/qZpHv4eGhWJ8nEi+dLoxkKAq3AHjG+YGqic0uxFaDs9vif3IsbIMHOnWOuQ+lfN5
         LcGYUkkW5cGPiqhordRzZxRmuhL6XLvA0D52ZlwVViWLeU49H4o1hrbZoW+oGYGbShYF
         I0aXHjq5ME1Q3g0/+X6iacLfyUIOxQjvdZYLsSg9hC/N8IQm7OSIKOPHLodxH/VUpn/R
         1ZeK3ZMQHOBcEytWyQlA3PSC8sVR4coQzy+0VqYqzwZrcvoLCKHabcC3m+En4mGR296g
         qc5g==
X-Gm-Message-State: ACrzQf2apKza+ywNxNxB0wOnxIgSwUjEFpfl1Dz+2lF2w0KHTHDvcZAZ
        Rx6qMlPz6rI9Q516V2FFXdsTwRMAlGl4W6pI4IiW66oAg0jTIwRQRuJw9wXGjnvKIazFHIdMWBv
        /R5YJ3ITEInZJC360bA96NQ==
X-Received: by 2002:a05:620a:12b5:b0:6cd:f08a:5d4f with SMTP id x21-20020a05620a12b500b006cdf08a5d4fmr21775545qki.8.1664374959194;
        Wed, 28 Sep 2022 07:22:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6fmKzRNXSuxW01rhdqH0LlsG4b/0woL5Epyq9ljOUekYyldjofq1FKZh/mDRdfgWqVKl7cTA==
X-Received: by 2002:a05:620a:12b5:b0:6cd:f08a:5d4f with SMTP id x21-20020a05620a12b500b006cdf08a5d4fmr21775532qki.8.1664374958971;
        Wed, 28 Sep 2022 07:22:38 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id cp4-20020a05622a420400b00359961365f1sm2859790qtb.68.2022.09.28.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:22:38 -0700 (PDT)
Date:   Wed, 28 Sep 2022 10:22:36 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de,
        damien.lemoal@opensource.wdc.com,
        Damien Le Moal <damien.lemoal@wdc.com>, bvanassche@acm.org,
        pankydev8@gmail.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        jaegeuk@kernel.org, matias.bjorling@wdc.com
Subject: Re: [PATCH v15 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Message-ID: <YzRYrNBB35fLjAO4@redhat.com>
References: <20220923173618.6899-1-p.raghav@samsung.com>
 <CGME20220923173634eucas1p18fccee11155c670354da389b4d2f4c60@eucas1p1.samsung.com>
 <20220923173618.6899-14-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923173618.6899-14-p.raghav@samsung.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 23 2022 at  1:36P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> Only zoned devices with power-of-2(po2) number of sectors per zone(zone
> size) were supported in linux but now non power-of-2(npo2) zone sizes
> support has been added to the block layer.
> 
> Filesystems such as F2FS and btrfs have support for zoned devices with
> po2 zone size assumption. Before adding native support for npo2 zone
> sizes, it was suggested to create a dm target for npo2 zone size device to
> appear as a po2 zone size target so that file systems can initially
> work without any explicit changes.
> 
> The design of this target is very simple: remap the device zone size to
> the zone capacity and change the zone size to be the nearest power of 2
> value.
> 
> For e.g., a device with a zone size/capacity of 3M will have an equivalent
> target layout as follows:
> 
> Device layout :-
> zone capacity = 3M
> zone size = 3M
> 
> |--------------|-------------|
> 0             3M            6M
> 
> Target layout :-
> zone capacity=3M
> zone size = 4M
> 
> |--------------|---|--------------|---|
> 0             3M  4M             7M  8M
> 
> The area between target's zone capacity and zone size will be emulated
> in the target.
> The read IOs that fall in the emulated gap area will return 0 filled
> bio and all the other IOs in that area will result in an error.
> If a read IO span across the emulated area boundary, then the IOs are
> split across them. All other IO operations that span across the emulated
> area boundary will result in an error.
> 
> The target can be easily created as follows:
> dmsetup create <label> --table '0 <size_sects> po2zoned /dev/nvme<id>'
> 
> The target does not support partial mapping of the underlying
> device as there is no use-case for it.
> 
> Note:
> This target is not related to dm-zoned target, which exposes a zoned block
> device as a regular block device without any write constraint.
> 
> This target only exposes a different zone size than the underlying device.
> The underlying device's other constraints will be directly exposed to the
> target.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>

If/when this series is accepted by Jens and others the DM changes can
just be included along with the rest of the series.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

