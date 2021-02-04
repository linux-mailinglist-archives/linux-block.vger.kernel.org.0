Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8155130FA79
	for <lists+linux-block@lfdr.de>; Thu,  4 Feb 2021 19:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238761AbhBDR60 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Feb 2021 12:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:38500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238774AbhBDR6C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 12:58:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96FB764E24;
        Thu,  4 Feb 2021 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612461441;
        bh=lYS1vJl4RC6iy4FmbkN/ZpWp9JXC5gFA3lH1E7aeReU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CphCsDhRRlvN9uBmsKGwndXATPsiE6JdDgKPtsb2Ms75587Io1WuytZ3h4wRtPg4x
         6pAAGSML9sXWEwtUisTXcHHKl/HnjBx51vziqzib2/gUujjBVFMTwaaPfCCRetTz7P
         S+kE9SiV170gcPJupJwQU5VWZkrrluJK4zH09Zac8nfBe01vlCs2OaXUZ05wUDTWEJ
         HkhYjzycjJousmyALUrV3b8XHqEOw4UsnvWw3EtTStzJv2SsfW8euGAaGcI9gFAdjo
         hRdkpHk3D2m/Cjb8TmIrxK8czY8BuHM4m55uRS3hL+fKVUrcmOhh0B3dSur/Bm+Tlt
         UMVpBYW8a0q6Q==
Received: by mail-lf1-f45.google.com with SMTP id v24so5859598lfr.7;
        Thu, 04 Feb 2021 09:57:21 -0800 (PST)
X-Gm-Message-State: AOAM5312Co1tRFOdCoAwWt8i8OESNKWGdKBx3Za28dykA3oEx2/y3tw7
        tOZ8pgjGUE22KA4tY+ksOuyhZ7+iwfXn+Wwdavc=
X-Google-Smtp-Source: ABdhPJw0ZAO8XEiTsOVi1WgoqhUpu/mWh2wUUo4BO+lm9mDrH2kpAV3zqlc/ukcpxoCuf9fVMigX04IWJWBTHWgLZik=
X-Received: by 2002:ac2:5ded:: with SMTP id z13mr319001lfq.160.1612461439848;
 Thu, 04 Feb 2021 09:57:19 -0800 (PST)
MIME-Version: 1.0
References: <20210202171929.1504939-1-hch@lst.de> <20210202171929.1504939-11-hch@lst.de>
In-Reply-To: <20210202171929.1504939-11-hch@lst.de>
From:   Song Liu <song@kernel.org>
Date:   Thu, 4 Feb 2021 09:57:08 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4_h7KzAjHpgoWQWM7RMQqvQd8XurNV8JjW9w79uPYJGQ@mail.gmail.com>
Message-ID: <CAPhsuW4_h7KzAjHpgoWQWM7RMQqvQd8XurNV8JjW9w79uPYJGQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] md/raid10: remove dead code in reshape_request
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 2, 2021 at 9:19 AM Christoph Hellwig <hch@lst.de> wrote:
>
> A bio allocated by bio_alloc_bioset comes pre-zeroed, no need to
> clear random fields.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>
