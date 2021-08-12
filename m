Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C28A3EA64F
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 16:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbhHLOOw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 10:14:52 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:47002 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhHLOOw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 10:14:52 -0400
Received: from spock.localnet (unknown [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 207B2B8CF08;
        Thu, 12 Aug 2021 16:14:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1628777665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zZl6XlT1y6Vd7b8+nZZ1Gb1yoaa9GSekZcm7zSfwAg=;
        b=dUxHh9TWsdFhJNB8f1oXzq9WAldcJScect52jKcM800buInFPlD5BzVuiaix7ZWA2RHB8J
        3hmK5I9dQZmFpaItDQ1Mq5U/JfNUZQu1/+PgZfqZn7VYqCeJVW2ce2d8/zL1ZCKRoRTYhg
        CYKAX/U+O8qtOyLwr8BGDgXCoybO4rU=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
Date:   Thu, 12 Aug 2021 16:14:23 +0200
Message-ID: <1700769.Imp7hYaAdB@natalenko.name>
In-Reply-To: <9683ccee-776f-70d6-39a5-2f9b7552b189@kernel.dk>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org> <9683ccee-776f-70d6-39a5-2f9b7552b189@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi.

On st=C5=99eda 11. srpna 2021 21:48:19 CEST Jens Axboe wrote:
> On 8/11/21 11:41 AM, Tejun Heo wrote:
> > From e150c6478e453fe27b5cf83ed5d03b7582b6d35e Mon Sep 17 00:00:00 2001
> > From: Tejun Heo <tj@kernel.org>
> > Date: Wed, 11 Aug 2021 07:29:20 -1000
> >=20
> > This reverts commit 08a9ad8bf607 ("block/mq-deadline: Add cgroup suppor=
t")
> > and a follow-up commit c06bc5a3fb42 ("block/mq-deadline: Remove a
> > WARN_ON_ONCE() call"). The added cgroup support has the following issue=
s:
> >=20
> > * It breaks cgroup interface file format rule by adding custom elements=
 to
> > a>=20
> >   nested key-value file.
> >=20
> > * It registers mq-deadline as a cgroup-aware policy even though all it's
> >=20
> >   doing is collecting per-cgroup stats. Even if we need these stats, th=
is
> >   isn't the right way to add them.
> >=20
> > * It hasn't been reviewed from cgroup side.
>=20
> I missed that the cgroup side hadn't seen or signed off on this one. I
> have applied this revert for 5.14.

Should my commit [1] be reverted too?

Thanks.

[1] https://git.kernel.dk/cgit/linux-block/commit/?h=3Dblock-5.14&id=3Dec64=
5dc96699ea6c37b6de86c84d7288ea9a4ddf

=2D-=20
Oleksandr Natalenko (post-factum)


