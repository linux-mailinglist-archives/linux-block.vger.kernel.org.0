Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDAE25AC38
	for <lists+linux-block@lfdr.de>; Wed,  2 Sep 2020 15:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBNpN (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 2 Sep 2020 09:45:13 -0400
Received: from verein.lst.de ([213.95.11.211]:60150 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbgIBNoo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Sep 2020 09:44:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC30268B02; Wed,  2 Sep 2020 15:44:35 +0200 (CEST)
Date:   Wed, 2 Sep 2020 15:44:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 1/2] percpu_ref: reduce memory footprint of
 percpu_ref in fast path
Message-ID: <20200902134435.GA32502@lst.de>
References: <20200902122643.634143-1-ming.lei@redhat.com> <20200902122643.634143-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902122643.634143-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 02, 2020 at 08:26:42PM +0800, Ming Lei wrote:
> 'struct percpu_ref' is often embedded into one user structure, and the
> instance is usually referenced in fast path, however actually only
> 'percpu_count_ptr' is needed in fast path.
> 
> So move other fields into one new structure of 'percpu_ref_data', and
> allocate it dynamically via kzalloc(), then memory footprint of
> 'percpu_ref' in fast path is reduced a lot and becomes suitable to put
> into hot cacheline of user structure.

This looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
