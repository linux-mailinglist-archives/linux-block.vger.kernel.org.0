Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC1EA7B7BC
	for <lists+linux-block@lfdr.de>; Wed, 31 Jul 2019 03:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfGaBq4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Jul 2019 21:46:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725209AbfGaBq4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 21:46:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67A4B308FEC1;
        Wed, 31 Jul 2019 01:46:56 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C3A660605;
        Wed, 31 Jul 2019 01:46:48 +0000 (UTC)
Date:   Wed, 31 Jul 2019 09:46:44 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alexandru Moise <00moses.alexander00@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH 1/2] block: Verify whether blk_queue_enter() is used when
 necessary
Message-ID: <20190731014643.GA4822@ming.t460p>
References: <20190730181757.248832-1-bvanassche@acm.org>
 <20190730181757.248832-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730181757.248832-2-bvanassche@acm.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 31 Jul 2019 01:46:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 30, 2019 at 11:17:56AM -0700, Bart Van Assche wrote:
> It is required to protect blkg_lookup() calls with a blk_queue_enter() /
> blk_queue_exit() pair. Since it is nontrivial to verify whether this is

Could you explain the reason why the blk_queue_enter()/blk_queue_exit()
pair is required for blkg_lookup()? And comment on blkg_lookup() only
mentioned RCU read lock is needed.

The request queue reference counter is supposed to be held for any
caller of submit_bio(), why isn't that ref count enough?

Thanks,
Ming
