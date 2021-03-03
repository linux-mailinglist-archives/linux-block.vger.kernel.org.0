Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE05132AE94
	for <lists+linux-block@lfdr.de>; Wed,  3 Mar 2021 03:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhCBXrV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Mar 2021 18:47:21 -0500
Received: from smtp02.tmcz.cz ([93.153.104.113]:47410 "EHLO smtp02.tmcz.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1581891AbhCBT2n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Mar 2021 14:28:43 -0500
Received: from leontynka.twibright.com (109-183-129-149.customers.tmcz.cz [109.183.129.149])
        by smtp02.tmcz.cz (Postfix) with ESMTPS id 3A0DC405D6;
        Tue,  2 Mar 2021 20:05:53 +0100 (CET)
Received: from debian-a64.vm ([192.168.208.2])
        by leontynka.twibright.com with smtp (Exim 4.92)
        (envelope-from <mpatocka@redhat.com>)
        id 1lHAL9-0003k5-GT; Tue, 02 Mar 2021 20:05:52 +0100
Received: by debian-a64.vm (sSMTP sendmail emulation); Tue, 02 Mar 2021 20:05:50 +0100
Message-Id: <20210302190513.688854040@debian-a64.vm>
User-Agent: quilt/0.65
Date:   Tue, 02 Mar 2021 20:05:13 +0100
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     JeffleXu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <msnitzer@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>, axboe@kernel.dk,
        caspar@linux.alibaba.com, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com,
        dm-devel@redhat.com, hch@lst.de
Subject: [PATCH 0/4] Reworked device mapper polling patchset
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

This is reworked patchset for device mapper I/O polling.

The polling happens inside device mapper and the polling cookie is not
returned to the upper-layer code (because returning it would be unsafe).

Mikulas
