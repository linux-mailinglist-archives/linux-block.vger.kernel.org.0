Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4193EA92F
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhHLRLO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 13:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbhHLRLN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 13:11:13 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826CBC061756
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 10:10:48 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id r16-20020a0568304190b02904f26cead745so8567156otu.10
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=iFS9qOblqQmttFL690SIJWfn2LXx3IsxFKD/wvqpkkY=;
        b=PTfZTeLU78/zGK/WM3f4bsx4rMtBnFnYfYpRJbX72vZE+Gkg75Gze/9MiZxmVcc21T
         YivAN5Mkj6AW9M+34NjHtlTQhnmceFoGww778eQgPDfYDwO0V3Dnp3041aIOSlEYfrk8
         I1GebLeh0XgUsQIjAHBT9j3vI3nh+QdWrROkw4LSL3CkBdnt/qengmlt5nL6Yg922+oM
         CQtMJfDL0nhDPG7tiMKg9+7F0SJv1Wcp8tp9Z7ctq2a5u3Xio3JKdlIZ0ToGntbZulX6
         wB7XY9NqYzg/rD2Hrba9QKl39RxDOmojNOgqFXMzDPJ0WqkuQpjow2YsPwgyc1WAQJh4
         Pjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iFS9qOblqQmttFL690SIJWfn2LXx3IsxFKD/wvqpkkY=;
        b=f2/qudKbhb1E6+OPwqXjdI73yF+s/ZyxRmtFA9KPLkGsEdn0MIvOaFrDN0Pf57zelQ
         XMTNfTreplr4rcwVxUZyk7lGUzLtNTCIJHMAK8Y4tO6BEWSzym3Jfllbd9EPnpSfIGCL
         0v4DukBUKQtKKgtDPntSPD3R92DREvbDCLZGSGKrrbgaEZofhOR6SkoLt0/sV9Vq0xhw
         xLhBbeYGNxhGdVZ9O7L77TlIV88+o+KE7AZQN4jkYh1K9JdsmciMSG7FLFpNfDzLxHJb
         2RlgObF3X3aG5IOXjStSFPYno3u2hRX572muQ/Q5Lke0NZXzOFLQzEC99KBI5aQEZNW6
         PwYw==
X-Gm-Message-State: AOAM531N7cmsMnwsm/2MepH4XjFCnk6FYyMuF3YHSVopYPl9xulczl/O
        8jx2lvUm+J7j5yzZ2BXTNzwmbQ==
X-Google-Smtp-Source: ABdhPJyn1zrVG9sragtzjo/jHG0l9dMVSToslwW+34qJfH5xzLYAsXvt8QSI6wukzEvWuFAtuMe0SQ==
X-Received: by 2002:a05:6830:264b:: with SMTP id f11mr4376631otu.8.1628788247900;
        Thu, 12 Aug 2021 10:10:47 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id bf41sm749526oib.41.2021.08.12.10.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 10:10:47 -0700 (PDT)
Subject: Re: [PATCH v5 0/5] Initial support for multi-actuator HDDs
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20210812075015.1090959-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a968069d-07df-396e-8ac6-04dfe3ee3040@kernel.dk>
Date:   Thu, 12 Aug 2021 11:10:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210812075015.1090959-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/12/21 1:50 AM, Damien Le Moal wrote:
> Single LUN multi-actuator hard-disks are cappable to seek and execute
> multiple commands in parallel. This capability is exposed to the host
> using the Concurrent Positioning Ranges VPD page (SCSI) and Log (ATA).
> Each positioning range describes the contiguous set of LBAs that an
> actuator serves.
> 
> This series adds support the scsi disk driver to retreive this
> information and advertize it to user space through sysfs. libata is also
> modified to handle ATA drives.
> 
> The first patch adds the block layer plumbing to expose concurrent
> sector ranges of the device through sysfs as a sub-directory of the
> device sysfs queue directory. Patch 2 and 3 add support to sd and
> libata. Finally patch 4 documents the sysfs queue attributed changes.
> Patch 5 fixes a typo in the document file (strictly speaking, not
> related to this series).
> 
> This series does not attempt in any way to optimize accesses to
> multi-actuator devices (e.g. block IO scheduler or filesystems). This
> initial support only exposes the actuators information to user space
> through sysfs.

This looks good to me now - are we taking this through the block tree?
If so, would be nice to get a SCSI signoff on patch 2.

-- 
Jens Axboe

