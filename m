Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CEB41AB33
	for <lists+linux-block@lfdr.de>; Tue, 28 Sep 2021 10:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbhI1IxT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-block@lfdr.de>); Tue, 28 Sep 2021 04:53:19 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55089 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbhI1IxS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Sep 2021 04:53:18 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2D63E2000A;
        Tue, 28 Sep 2021 08:51:34 +0000 (UTC)
Date:   Tue, 28 Sep 2021 10:51:33 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-block@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/5] mtd_blkdevs: remove the sector out of range check
 in do_blktrans_request
Message-ID: <20210928105133.606b6eed@xps13>
In-Reply-To: <20210928052211.112801-2-hch@lst.de>
References: <20210928052211.112801-1-hch@lst.de>
        <20210928052211.112801-2-hch@lst.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

hch@lst.de wrote on Tue, 28 Sep 2021 07:22:07 +0200:

> The block layer already performs this check, no need to duplicate it in
> the driver.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
