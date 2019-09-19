Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52684B7693
	for <lists+linux-block@lfdr.de>; Thu, 19 Sep 2019 11:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388872AbfISJpw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Sep 2019 05:45:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:59254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387767AbfISJpv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Sep 2019 05:45:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D53F5B66A;
        Thu, 19 Sep 2019 09:45:49 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [RFC PATCH 0/2]  blk-mq I/O scheduling fixes
Date:   Thu, 19 Sep 2019 11:45:45 +0200
Message-Id: <20190919094547.67194-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

Damien pointed out that there are some areas in the blk-mq I/O
scheduling algorithm which have a distinct legacy feel to it,
and prohibit multiqueue I/O schedulers from working properly.
These two patches should clear up this situation, but as it's
not quite clear what the original intention of the code was
I'll be posting them as an RFC.

So as usual, comments and reviews are welcome.

Hannes Reinecke (2):
  blk-mq: fixup request re-insert in blk_mq_try_issue_list_directly()
  blk-mq: always call into the scheduler in blk_mq_make_request()

 block/blk-mq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

-- 
2.16.4

