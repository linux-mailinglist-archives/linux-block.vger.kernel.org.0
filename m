Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E8A40D32D
	for <lists+linux-block@lfdr.de>; Thu, 16 Sep 2021 08:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhIPG0i (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Sep 2021 02:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231255AbhIPG0i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 02:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631773517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDYMLRQB5NY9ENd9cvkxCO0IUruGgbCum6Qchd6u8hw=;
        b=Id5g486MsCnvVU7sJSTazfMzzNfvxZHlLdiVgtdODCKHf0BA+6Pz4oE21eCnDUrErXRIjB
        Z6/FekFNbs8DH+6IuVilVUTBmGdTijmDQalDGWwpzY3UPQvaVuJ24msTo0XiCwmTOFiqQF
        INZCwY2bUzsPUqDkiEsP18HOiY5l6ag=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-vFXSoJH5OjusRyIun3G-PQ-1; Thu, 16 Sep 2021 02:25:16 -0400
X-MC-Unique: vFXSoJH5OjusRyIun3G-PQ-1
Received: by mail-wm1-f72.google.com with SMTP id u14-20020a7bcb0e0000b0290248831d46e4so980155wmj.6
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 23:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YDYMLRQB5NY9ENd9cvkxCO0IUruGgbCum6Qchd6u8hw=;
        b=r1fevWloLtzJcNXvrqZkBWyr23EmNjkU9FmDJrTIEiyusGKRgJ2YMCnJtyb1vuKIEW
         /tBdUR5NfLt4iIblizDWNgYaHd/rVQmaqTlNQXRbpfMvGimbdGRUP+UQDA4SmHCTVbbo
         AycCzfRguSRHJxaR66T2sq+LIMl0qQ1wTuCQz12kNOcjgFmCYv2OczIn8P9nKOCB434A
         yKsouIrhJvgWweuI79TrSv/dT1vyufjafbxEvsPMA5f9xk5B4JdlQXNHlJ1VsBYSFFF0
         iik6GO3dTer9suvrYaDrwLMX83yyR9XcYh16IeWi0ydDSSwzJbXNMmkax8cy6xwHorSK
         MCEg==
X-Gm-Message-State: AOAM532v5HhomiZZ18QBfW22z/5isBfrf/ASVsFpK9nJvVRTPjMnrqPr
        074Ea2wn5tVIUHOB4BwIP9FlC2yjECDfqC4sh0GpuUQzqq3r/2tTlGE2k1yca3PoVPkgd26OrEI
        C0ouzj4vc7TjeGhkyh6zbnrF9MdukHFFWXVE8aFc=
X-Received: by 2002:a05:6000:11d1:: with SMTP id i17mr4125589wrx.424.1631773515392;
        Wed, 15 Sep 2021 23:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqTzrhsF/h6jSo+GRqZ3bg71kapWMBfrCU4g/DI13eBzKbIvKPTkQ38efTQNFa3EWEajYZ6DIZ1odcXcag90U=
X-Received: by 2002:a05:6000:11d1:: with SMTP id i17mr4125564wrx.424.1631773515148;
 Wed, 15 Sep 2021 23:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210806142914.70556-1-pkalever@redhat.com>
In-Reply-To: <20210806142914.70556-1-pkalever@redhat.com>
From:   Prasanna Kalever <pkalever@redhat.com>
Date:   Thu, 16 Sep 2021 11:55:04 +0530
Message-ID: <CANwsLLGYoexzyMkK5_0jpTA+P=_FS_UyudZSeTS=EZPjakYDpQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] nbd: reset the queue/io_timeout to default on disconnect
To:     linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Ilya Dryomov <idryomov@redhat.com>,
        Xiubo Li <xiubli@redhat.com>,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Just wanted to bring this up again and remind you about the pending review.

Many Thanks,
--
Prasanna

On Fri, Aug 6, 2021 at 7:59 PM <pkalever@redhat.com> wrote:
>
> From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
>
> Hi,
>
> This series has changes to reset the queue/io_timeout for nbd devices and
> a cleanup patch.
>
> Thank you!
>
> Prasanna Kumar Kalever (2):
>   block: cleanup: define default command timeout and use it
>   nbd: reset the queue/io_timeout to default on disconnect
>
>  block/blk-mq.c         | 2 +-
>  drivers/block/nbd.c    | 9 +++++++--
>  include/linux/blkdev.h | 2 ++
>  3 files changed, 10 insertions(+), 3 deletions(-)
>
> --
> 2.31.1
>

