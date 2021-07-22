Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA253D2CA1
	for <lists+linux-block@lfdr.de>; Thu, 22 Jul 2021 21:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhGVSg7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 22 Jul 2021 14:36:59 -0400
Received: from verein.lst.de ([213.95.11.211]:35727 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhGVSgy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jul 2021 14:36:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12D5867373; Thu, 22 Jul 2021 21:17:28 +0200 (CEST)
Date:   Thu, 22 Jul 2021 21:17:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Doug Gilbert <dgilbert@interlog.com>,
        Kai =?iso-8859-1?Q?M=E4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 19/24] scsi: rename CONFIG_BLK_SCSI_REQUEST to
 CONFIG_SCSI_COMMON
Message-ID: <20210722191727.GA15240@lst.de>
References: <20210712054816.4147559-1-hch@lst.de> <20210712054816.4147559-20-hch@lst.de> <yq1zguew84u.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1zguew84u.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 22, 2021 at 01:51:28PM -0400, Martin K. Petersen wrote:
> 
> Christoph,
> 
> > CONFIG_BLK_SCSI_REQUEST is rather misnamed now as it just enabled
> > building a small amount of code shared by the scsi initiator, target
> > and consumers of the scsi_request passthrough API.  Rename it and also
> > allow building it as a module.
> 
> Build now fails. Needs:

Interesting - this did not show up in any of my builds and not in weeks
of buildbot coverage.  But I'll add the include just to be on the safe
side.
