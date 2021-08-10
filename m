Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71573D8566
	for <lists+linux-block@lfdr.de>; Wed, 28 Jul 2021 03:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhG1BcT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 27 Jul 2021 21:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbhG1BcS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 21:32:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09534C061760
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:32:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pf12-20020a17090b1d8cb0290175c085e7a5so7610862pjb.0
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5rj+Jk8FZe2NEOutgAZKHy8g5XY1Cgm2OZ1BjO0VAd0=;
        b=oTfMUw2EkafM0zM+vz7MUGjWHsAMLTsK1efDco2LoDl5YGkfsXIthZivNODcSebRY9
         6u3W5VS3Ily4bMwwrikZiTJXxDtP16BTyXHbExHnbwePelhCg5MaWUy4GKzM3SHe8p9V
         3MF5Wri2SJBEpdKM+XpKWKCd3SAm+kBHVwunaeghnGmCmjvRdl4n8LpZiCFx5JvpCKmI
         /unIogdFHU/VuHO2fWC4udd4cr8kFaO//dYM1PcRSsqnGBG7sduKIrP9xOSBYWJuzzii
         E3z7qD4fxDaApSnavwNLbZKPYDhL92d2UZf/iAzq6C9nWM1hE/ER7gzt5RUgLjHv/D6E
         iTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5rj+Jk8FZe2NEOutgAZKHy8g5XY1Cgm2OZ1BjO0VAd0=;
        b=Xhw3ATPDMzcYN+lbqyEZ2Kcr/lznpc8646QPfmPCms9GIgNMD3NeGWUbN4hokRaJAK
         U6mXl23SRfEP2pVDITRvuGhGAe8sFCLc+f41Fv29bVh6CZoauQ0gegYgejD6NwXPgtHP
         sWWVZ2ufG8z3Kpa1r9FfthYYCViWPuJ448KoBa9bzdiNC4kRBBGn2WgfQXpUhWFnfx7F
         jiCfd6p6zPmGelkNnmSoNkX1DcjtgUXUOc9x8QuC5cdgjyUfIXQPl1FZpfn/U/tdK99E
         kaAiVUVDV1ESKYjyuTLZjUVXWQkjUe2yFDtGgWaB70GIaUN7aDHy3Q1sOuXAmFeTlAnh
         nm+Q==
X-Gm-Message-State: AOAM533l99a6pnUwuvfpedgkNdIVKZJnzjsqGxMBvKIVfUk1K7zIJsIS
        B522Sj4C+RQvH55BYeI4Og4eTQ==
X-Google-Smtp-Source: ABdhPJzArq/2MSZEt4PoQH1xCrFAgDVmP1R6cTFs/nEA3E2TCkL7htHdSRGpAC/pEHilHz8mnYqRCA==
X-Received: by 2002:a65:5083:: with SMTP id r3mr8039958pgp.161.1627435937627;
        Tue, 27 Jul 2021 18:32:17 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id w10sm5544576pgl.46.2021.07.27.18.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 18:32:17 -0700 (PDT)
Subject: Re: [PATCH 01/24] bsg: remove support for SCSI_IOCTL_SEND_COMMAND
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc:     Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
References: <20210724072033.1284840-1-hch@lst.de>
 <20210724072033.1284840-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b3e2bea6-3ba9-11d6-f054-e1fa62be466f@kernel.dk>
Date:   Tue, 27 Jul 2021 19:32:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210724072033.1284840-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/24/21 1:20 AM, Christoph Hellwig wrote:
> SCSI_IOCTL_SEND_COMMAND has been deprecated longer than bsg exists
> and has been warning for just as long.  More importantly it harcodes
> SCSI CDBs and thus will do the wrong thing on non-scsi bsg nodes.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

