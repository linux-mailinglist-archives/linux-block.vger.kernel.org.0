Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48503EA117
	for <lists+linux-block@lfdr.de>; Thu, 12 Aug 2021 10:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhHLI5f (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Aug 2021 04:57:35 -0400
Received: from verein.lst.de ([213.95.11.211]:43454 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235302AbhHLI5f (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 04:57:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A9C1167373; Thu, 12 Aug 2021 10:57:08 +0200 (CEST)
Date:   Thu, 12 Aug 2021 10:57:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        "Blank-Burian, Markus, Dr." <blankburian@uni-muenster.de>
Subject: Re: [PATCH] blk-mq: fix kernel panic during iterating over flush
 request
Message-ID: <20210812085708.GB2867@lst.de>
References: <20210811142624.618598-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811142624.618598-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
