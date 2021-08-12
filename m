Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF323EA112
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhHLI4B (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 04:56:01 -0400
Received: from verein.lst.de ([213.95.11.211]:43447 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231470AbhHLI4A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 04:56:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6ED8D67373; Thu, 12 Aug 2021 10:55:33 +0200 (CEST)
Date:   Thu, 12 Aug 2021 10:55:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2] blk-mq: don't grab rq's refcount in
 blk_mq_check_expired()
Message-ID: <20210812085533.GA2867@lst.de>
References: <20210811155202.629575-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811155202.629575-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
