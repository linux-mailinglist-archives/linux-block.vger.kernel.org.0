Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F275D374973
	for <lists+linux-block@lfdr.de>; Wed,  5 May 2021 22:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbhEEU2r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-block@lfdr.de>); Wed, 5 May 2021 16:28:47 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59200 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbhEEU2m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 May 2021 16:28:42 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id CA4824FDDC141;
        Wed,  5 May 2021 13:27:43 -0700 (PDT)
Date:   Wed, 05 May 2021 13:27:39 -0700 (PDT)
Message-Id: <20210505.132739.2022645880622422332.davem@davemloft.net>
To:     u.kleine-koenig@pengutronix.de
Cc:     axboe@kernel.dk, kuba@kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, sparclinux@vger.kernel.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] sparc/vio: make remove callback return void
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20210505201449.195627-1-u.kleine-koenig@pengutronix.de>
References: <20210505201449.195627-1-u.kleine-koenig@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 27.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Wed, 05 May 2021 13:27:44 -0700 (PDT)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>
Date: Wed,  5 May 2021 22:14:49 +0200

> The driver core ignores the return value of struct bus_type::remove()
> because there is only little that can be done. To simplify the quest to
> make this function return void, let struct vio_driver::remove() return
> void, too. All users already unconditionally return 0, this commit makes
> it obvious that returning an error code is a bad idea and should prevent
> that future driver authors consider returning an error code.
> 
> Note there are two nominally different implementations for a vio bus:
> one in arch/sparc/kernel/vio.c and the other in
> arch/powerpc/platforms/pseries/vio.c. This patch only addresses the
> former.
> 
> Signed-off-by: Uwe Kleine-K�nig <u.kleine-koenig@pengutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
