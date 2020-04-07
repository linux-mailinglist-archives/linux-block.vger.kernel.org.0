Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7CA11A127F
	for <lists+linux-block@lfdr.de>; Tue,  7 Apr 2020 19:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDGROy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Apr 2020 13:14:54 -0400
Received: from verein.lst.de ([213.95.11.211]:38771 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgDGROy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Apr 2020 13:14:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 148BF68C4E; Tue,  7 Apr 2020 19:14:52 +0200 (CEST)
Date:   Tue, 7 Apr 2020 19:14:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V6 2/8] blk-mq: add new state of BLK_MQ_S_INACTIVE
Message-ID: <20200407171451.GB5614@lst.de>
References: <20200407092901.314228-1-ming.lei@redhat.com> <20200407092901.314228-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407092901.314228-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 07, 2020 at 05:28:55PM +0800, Ming Lei wrote:
> Add a new hw queue state of BLK_MQ_S_INACTIVE, which is set when all
> CPUs of this hctx are offline.
> 
> Prepares for stopping hw queue when all CPUs of this hctx become offline.

It isn't set yet, is it?  So maybe ".. will be set..".  Or just merge
it into the patch that sets it, which might be easier to follow.
