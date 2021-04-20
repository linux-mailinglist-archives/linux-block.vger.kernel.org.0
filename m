Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4364736557D
	for <lists+linux-block@lfdr.de>; Tue, 20 Apr 2021 11:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhDTJf1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Apr 2021 05:35:27 -0400
Received: from verein.lst.de ([213.95.11.211]:49867 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhDTJf0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 05:35:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2574768C4E; Tue, 20 Apr 2021 11:34:54 +0200 (CEST)
Date:   Tue, 20 Apr 2021 11:34:53 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 3/3] nvme: decouple basic ANA log page re-read
 support from native multipathing
Message-ID: <20210420093453.GB28625@lst.de>
References: <20210416235329.49234-1-snitzer@redhat.com> <20210416235329.49234-4-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416235329.49234-4-snitzer@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 16, 2021 at 07:53:29PM -0400, Mike Snitzer wrote:
> Whether or not ANA is present is a choice of the target implementation;
> the host (and whether it supports multipathing) has _zero_ influence on
> this. If the target declares a path as 'inaccessible' the path _is_
> inaccessible to the host. As such, ANA support should be functional
> even if native multipathing is not.

NAK.  nvme-multipathing is the only supported option for subsystems with
multiple controllers.
