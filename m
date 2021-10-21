Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9668C43648D
	for <lists+linux-block@lfdr.de>; Thu, 21 Oct 2021 16:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUOo3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Oct 2021 10:44:29 -0400
Received: from verein.lst.de ([213.95.11.211]:46849 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhJUOo2 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 10:44:28 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A3E5E68BEB; Thu, 21 Oct 2021 16:42:10 +0200 (CEST)
Date:   Thu, 21 Oct 2021 16:42:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     martin.petersen@oracle.com
Cc:     Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: please revert the UFS HPB support
Message-ID: <20211021144210.GA28195@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,

I just noticed the UFS HPB support landed in 5.15, and just as
before it is completely broken by allocating another request on
the same device and then reinserting it in the queue.  It is bad
enough that we have to live with blk_insert_cloned_request for
dm-mpath, but this is too big of an API abuse to make it into
a release.  We need to drop this code ASAP, and I can prepare
a patch for that.
