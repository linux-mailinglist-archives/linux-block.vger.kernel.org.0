Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51840774320
	for <lists+linux-block@lfdr.de>; Tue,  8 Aug 2023 19:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjHHR5Z (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 8 Aug 2023 13:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjHHR4s (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 13:56:48 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6332AF07;
        Tue,  8 Aug 2023 09:25:41 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-686ed1d2594so5638451b3a.2;
        Tue, 08 Aug 2023 09:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511909; x=1692116709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qgNS4DkRUi6QR/B4v/+tHHbyA7hT2tYZURhMtsh+Es=;
        b=TrMVP/QQE1rI58CHjpCyVan94bbZgB8RuLpGdPeMpg6OO8bQI/I+PzETBvDPHP54D4
         sC9PBNfvQjQnxvPf+WyXSZUPb7FNqpxxt/xUYO5hJehXuWfGwemB84zLe1SztmulnkQq
         t1zzN/IoC2K5HakfgcbDdfBJwpaoiFCwOLQJKsuSBnO6KRvPOltAWZK11wqZqjSGURFd
         RuULnY7aLTgpNqg2a+SjXd4csHs+OvCVNK/VYLY3pKGA9P/u7jIN2/e8876zDUJv3mgR
         EhFkPFJDLKXuUvdgUVbUCl8K7VnmlMwmHSa/af6Fc5MCw+N6CQ60wDioJEOz+Isa59Yz
         XnoQ==
X-Gm-Message-State: AOJu0YwvUL/7rDFBBNuoobjr4AEBc4e95/CdSjZzwtd/mRlavH7uwC26
        V5j8Frr6PkUahSz/S35+XoGzOrCe3Tc=
X-Google-Smtp-Source: AGHT+IGi8chTo6biWKPL5WddtVnyrqZ6Q73m3OdAvun3EgO2v2Q5zkHcBpv/7uGiTQHy76JyUyu61g==
X-Received: by 2002:a05:6a00:851:b0:67f:3dcd:bc00 with SMTP id q17-20020a056a00085100b0067f3dcdbc00mr17452354pfk.2.1691504457041;
        Tue, 08 Aug 2023 07:20:57 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id j4-20020a635504000000b00563bee47a79sm6618903pgb.80.2023.08.08.07.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 07:20:56 -0700 (PDT)
Message-ID: <95a6dbb4-b589-7f30-75b4-bc60f789512d@acm.org>
Date:   Tue, 8 Aug 2023 07:20:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 3/7] scsi: core: Retry unaligned zoned writes
Content-Language: en-US
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20230804154821.3232094-1-bvanassche@acm.org>
 <20230804154821.3232094-4-bvanassche@acm.org>
 <yq1y1imjod1.fsf@ca-mkp.ca.oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1y1imjod1.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/7/23 19:24, Martin K. Petersen wrote:
>> If zoned writes (REQ_OP_WRITE) for a sequential write required zone
>> have a starting LBA that differs from the write pointer, e.g. because
>> zoned writes have been reordered, then the storage device will respond
>> with an UNALIGNED WRITE COMMAND error. Send commands that failed with
>> an unaligned write error to the SCSI error handler if zone write
>> locking is disabled. Let the SCSI error handler sort SCSI commands per
>> LBA before resubmitting these.
>>
>> If zone write locking is disabled, increase the number of retries for
>> write commands sent to a sequential zone to the maximum number of
>> outstanding commands because in the worst case the number of times
>> reordered zoned writes have to be retried is (number of outstanding
>> writes per sequential zone) - 1.
> 
> I am afraid that I find falling back to rely on the error handler pretty
> kludgy. It seems like there would be a more straightforward way ensure
> that request ordering is preserved for devices that are known not to
> reorder internally.
> 
> I probably missed the finer details of what was discussed while I was
> away. But why can't we address the specific corner cases that cause the
> unexpected reordering at the block layer? Sorting requests in the SCSI
> error handler after a reported failure just seems like papering over the
> fact that there's a problem elsewhere.

Hi Martin,

An important question is whether it is possible to preserve the write order
all the time. The software layers and hardware components that are involved
in this context are:
* The filesystem.
* The block layer.
* The I/O scheduler if an I/O scheduler is present.
* The SCSI core.
* The SCSI LLD.
* The storage controller (UFSHCI in this case).
* The link between storage controller and storage device.
* The storage device (UFS in this case).

The SCSI protocol allows SCSI devices, including UFS devices, to respond
with a unit attention or the SCSI BUSY status at any time. If multiple write
commands are pending and some of the pending SCSI commands are not executed
because of a unit attention or because of another reason, this causes
command reordering.

The link between UFS controller and UFS device has a low but non-zero BER.
If a SCSI command is lost by this link and has to be resent, this can cause
reordering.

Although I agree that the code in this patch that sorts and resubmits requests
should be triggered infrequently, I don't think that such code can be avoided
entirely. You may have noticed that a significant effort has been undertaken
to eliminate certain causes of command reordering. See also:
* [PATCH v4 0/5] ufs: Do not requeue while ungating the clock
(https://lore.kernel.org/linux-scsi/20230529202640.11883-1-bvanassche@acm.org/).
* [PATCH v6 00/11] mq-deadline: Improve support for zoned block devices
(https://lore.kernel.org/linux-block/20230517174230.897144-1-bvanassche@acm.org/)
* less special casing for flush requests v2
(https://lore.kernel.org/linux-block/20230519044050.107790-1-hch@lst.de/)

As you may be aware performance matters for UFS devices and performance of UFS
devices increases gradually over time. It is important that the code added by
this patch is triggered infrequently to achieve good performance so I have an
interest myself in making sure that this code is triggered infrequently in
current and also in future kernels.

Since I think that it is not possible to avoid sorting and resubmitting
requests entirely, I propose to proceed with the approach of this patch
series.

Thanks,

Bart.
