Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1857A3D2C77
	for <lists+linux-block@lfdr.de>; Thu, 22 Jul 2021 21:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhGVS3c (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Jul 2021 14:29:32 -0400
Received: from verein.lst.de ([213.95.11.211]:35668 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhGVS3b (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 14:29:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12EDF67373; Thu, 22 Jul 2021 21:10:05 +0200 (CEST)
Date:   Thu, 22 Jul 2021 21:10:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 12/24] block: add a queue_max_sectors_bytes helper
Message-ID: <20210722191004.GB14921@lst.de>
References: <20210712054816.4147559-1-hch@lst.de> <20210712054816.4147559-13-hch@lst.de> <yq1tukmw7o2.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1tukmw7o2.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 02:00:57PM -0400, Martin K. Petersen wrote:
> Maybe simply queue_max_bytes()?

Fine with me.
