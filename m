Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48F044548F
	for <lists+linux-block@lfdr.de>; Thu,  4 Nov 2021 15:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhKDOM4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Nov 2021 10:12:56 -0400
Received: from mail.itouring.de ([85.10.202.141]:41804 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230409AbhKDOMz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Nov 2021 10:12:55 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Nov 2021 10:12:55 EDT
Received: from tux.applied-asynchrony.com (p5ddd7948.dip0.t-ipconnect.de [93.221.121.72])
        by mail.itouring.de (Postfix) with ESMTPSA id D6D2D124FE8;
        Thu,  4 Nov 2021 15:04:06 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 74127F01602;
        Thu,  4 Nov 2021 15:04:06 +0100 (CET)
To:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Subject: block: please restore 2d52c58b9c9b ("block, bfq: honor already-setup
 queue merges")
Organization: Applied Asynchrony, Inc.
Message-ID: <65495934-09fe-55b0-62a9-c649dc9940ba@applied-asynchrony.com>
Date:   Thu, 4 Nov 2021 15:04:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Hi Jens,

a simple no-code request:

Commit d29bd41428cf ("block, bfq: reset last_bfqq_created on group change")
fixed a UAF in bfq, which was previously worked-around by ebc69e897e17
("Revert "block, bfq: honor already-setup queue merges"").

However since then the original commit 2d52c58b9c9b was never restored.

Reinstating 2d52c58b9c9b has so far not resulted in any problems for me,
and I think it would be nice to bring it back in early just to get
feedback as early as possible in this cycle.

Thanks,
Holger
