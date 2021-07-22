Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459BB3D2C7C
	for <lists+linux-block@lfdr.de>; Thu, 22 Jul 2021 21:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhGVSbG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Jul 2021 14:31:06 -0400
Received: from verein.lst.de ([213.95.11.211]:35696 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhGVSbF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 14:31:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 116B267373; Thu, 22 Jul 2021 21:11:39 +0200 (CEST)
Date:   Thu, 22 Jul 2021 21:11:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 14/24] bsg: move bsg_scsi_ops to drivers/scsi/
Message-ID: <20210722191138.GC14921@lst.de>
References: <20210712054816.4147559-1-hch@lst.de> <20210712054816.4147559-15-hch@lst.de> <yq1o8auw7ml.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1o8auw7ml.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 02:03:10PM -0400, Martin K. Petersen wrote:
> Maybe just cosmetic, but now that this code lives in scsi_bsg.c (which I
> do like), I think these functions should be named
> scsi_bsg_check_proto(), etc.

Done.
