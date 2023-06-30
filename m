Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF4874452F
	for <lists+linux-block@lfdr.de>; Sat,  1 Jul 2023 01:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjF3XX0 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 30 Jun 2023 19:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjF3XXY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 19:23:24 -0400
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931903C00;
        Fri, 30 Jun 2023 16:22:51 -0700 (PDT)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5577900c06bso1788958a12.2;
        Fri, 30 Jun 2023 16:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688167317; x=1690759317;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDyuzcBk6PQbCTpKgz9Tbx7bmTFz75mFlhEzafNtxb4=;
        b=BL7Y7lPfBj7s9rDK5Gq1VBkydLl9dROK1/SbEPnL7ZmHvfDxVq1IZdVmwvwSzn43lk
         2xbGeBOUxxR4BudA+KQLy0+kJv8nGww82ANitAmTEhxJvr3o82oNI883LVFdlBOM9lza
         OQHcGthitzxwCCtV7OlHPEIqAsJ0+zlpJjGlJlscPBW0TeTANdD4vWpAhSnII2CFDhxk
         dqT/CTn0XAYeKlhbJVC71lTjZwwXG6ESYq3UFfw299+ormSGalLWLzSmc9sJeW1K9Ap/
         HolJHmzHhSnMVc9YhDHtYGNc0K5As5GvsSZehA9Q23RoF9n/tAkO2Uk7BIDElhUrJXku
         ITBg==
X-Gm-Message-State: AC+VfDxHC/BuXVhxowCYjSYBiOhEYGu39hshUhG1uNKWGrFjVQPK7PL6
        q8oGGqvLfr5PSA0VE8l9RvE=
X-Google-Smtp-Source: ACHHUZ5xAibv08f6GtgtdZBzffTZAsAoRMZX2G85RMGPvdqLDrk61XLvj2DwXhl/JJeHFw/WNPG70Q==
X-Received: by 2002:a05:6a20:9493:b0:11f:6d3c:5418 with SMTP id hs19-20020a056a20949300b0011f6d3c5418mr3761518pzb.22.1688167317408;
        Fri, 30 Jun 2023 16:21:57 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id k25-20020aa792d9000000b006636c4f57a6sm10465072pfa.27.2023.06.30.16.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 16:21:56 -0700 (PDT)
Message-ID: <90cbd07f-eeac-5da0-4786-6e212ecd22cc@acm.org>
Date:   Fri, 30 Jun 2023 16:21:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/5] Improve checks in blk_revalidate_disk_zones()
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20230630083935.433334-1-dlemoal@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230630083935.433334-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/30/23 01:39, Damien Le Moal wrote:
> blk_revalidate_disk_zones() implements checks of the zones of a zoned
> block device, verifying that the zone size is a power of 2 number of
> sectors, that all zones (except possibly the last one) have the same
> size and that zones cover the entire addressing space of the device.

For the entire series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
