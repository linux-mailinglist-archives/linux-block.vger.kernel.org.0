Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3B72554D7
	for <lists+linux-block@lfdr.de>; Fri, 28 Aug 2020 09:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgH1HI1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 28 Aug 2020 03:08:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbgH1HIZ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 03:08:25 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF3F208C9;
        Fri, 28 Aug 2020 07:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598598504;
        bh=ZvYOOOLLhxM1hflSpZB75b7Lg8qtxAvJHgbIokXn4jw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MrpZP9sPl3pous88EkRmY3yTSpWSvUUC5YeJANAq8ckaIlm1RQmHNUpeakTgx/zAs
         5bEFHU+SWHVm0l2EZ/LMKJXPnh7FTgP0Pew+/mIYlU84amOdvkW716KOLoF6zlPwr3
         j4uJ6bxLirJEyq2ci3jNFFAQdZISFl3n4Tb1EYPs=
Received: by mail-lj1-f172.google.com with SMTP id w14so166663ljj.4;
        Fri, 28 Aug 2020 00:08:24 -0700 (PDT)
X-Gm-Message-State: AOAM530nlsvbbLAYKnO43fCqJxhdpxcjdxUavgzzhpca7u3dnjmeK05f
        uqdl6uICbFs4NQ4SrQb8DwfKYBoHNbakdyUl/O4=
X-Google-Smtp-Source: ABdhPJwDxwnTegqkGcim7YBtcif4W/XgOp/pZ2Mqt5pw3/OWQc7tRq9NrRCJraTuvVs/Zn6bXxCKz9TpF2uvlyIvdB4=
X-Received: by 2002:a2e:7504:: with SMTP id q4mr222246ljc.41.1598598502529;
 Fri, 28 Aug 2020 00:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200826062446.31860-1-hch@lst.de> <20200826062446.31860-13-hch@lst.de>
In-Reply-To: <20200826062446.31860-13-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Fri, 28 Aug 2020 00:08:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW46Wg5Ju6coY73z7U6tr6hzcpnvMbj7tuxmVNsoH9NVxw@mail.gmail.com>
Message-ID: <CAPhsuW46Wg5Ju6coY73z7U6tr6hzcpnvMbj7tuxmVNsoH9NVxw@mail.gmail.com>
Subject: Re: [PATCH 12/19] md: use __register_blkdev to allocate devices on demand
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-ide@vger.kernel.org, linux-raid <linux-raid@vger.kernel.org>,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 25, 2020 at 11:53 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use the simpler mechanism attached to major_name to allocate a brd device
> when a currently unregistered minor is accessed.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>
