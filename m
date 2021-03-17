Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0748633E98C
	for <lists+linux-block@lfdr.de>; Wed, 17 Mar 2021 07:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhCQGNa (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 17 Mar 2021 02:13:30 -0400
Received: from verein.lst.de ([213.95.11.211]:35529 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCQGNB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 02:13:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 22B5968BEB; Wed, 17 Mar 2021 07:12:58 +0100 (CET)
Date:   Wed, 17 Mar 2021 07:12:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v2] sbitmap: Silence a debug kernel warning triggered
 by sbitmap_put()
Message-ID: <20210317061257.GA14128@lst.de>
References: <20210317032648.9080-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317032648.9080-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
