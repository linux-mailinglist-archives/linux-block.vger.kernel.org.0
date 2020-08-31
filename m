Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6882580E8
	for <lists+linux-block@lfdr.de>; Mon, 31 Aug 2020 20:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgHaSUx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 31 Aug 2020 14:20:53 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:34002 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbgHaSUw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 14:20:52 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 34F5A1B44DF;
        Tue,  1 Sep 2020 03:20:51 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07VIKndZ367490
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 1 Sep 2020 03:20:51 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-20) with ESMTPS id 07VIKnbs3471994
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 1 Sep 2020 03:20:49 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id 07VIKnLJ3471993;
        Tue, 1 Sep 2020 03:20:49 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] block: ensure bdi->io_pages is always initialized
References: <346e5bf5-b08e-84e8-7b0e-c6cb0c814f96@kernel.dk>
        <878sdu66sa.fsf@mail.parknet.co.jp>
        <8eb3881a-8ebd-fecb-d88b-3e1d77bc952f@kernel.dk>
Date:   Tue, 01 Sep 2020 03:20:49 +0900
In-Reply-To: <8eb3881a-8ebd-fecb-d88b-3e1d77bc952f@kernel.dk> (Jens Axboe's
        message of "Mon, 31 Aug 2020 12:10:11 -0600")
Message-ID: <874koi65j2.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 8/31/20 11:53 AM, OGAWA Hirofumi wrote:
>> Jens Axboe <axboe@kernel.dk> writes:
>> 
>>> If a driver leaves the limit settings as the defaults, then we don't
>>> initialize bdi->io_pages. This means that file systems may need to
>>> work around bdi->io_pages == 0, which is somewhat messy.
>>>
>>> Initialize the default value just like we do for ->ra_pages.
>>>
>>> Cc: stable@vger.kernel.org
>>> Reported-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> 
>> When queued to submit, please let us know to drop fatfs workaround
>> "fat-avoid-oops-when-bdi-io_pages==0.patch" in akpm series.
>
> Will do - planning on submitting it for 5.9, so probably end this
> week.

OK. Andrew, please drop fat-avoid-oops-when-bdi-io_pages==0.patch.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
