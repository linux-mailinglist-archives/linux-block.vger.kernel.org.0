Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C504A262705
	for <lists+linux-block@lfdr.de>; Wed,  9 Sep 2020 08:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgIIGEs (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Sep 2020 02:04:48 -0400
Received: from verein.lst.de ([213.95.11.211]:55858 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgIIGEs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Sep 2020 02:04:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D71E26736F; Wed,  9 Sep 2020 08:04:45 +0200 (CEST)
Date:   Wed, 9 Sep 2020 08:04:45 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Veronika Kabatova <vkabatov@redhat.com>,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 1/3] percpu_ref: add percpu_ref_inited() for MD
Message-ID: <20200909060445.GA8804@lst.de>
References: <20200908012351.1092986-1-ming.lei@redhat.com> <20200908012351.1092986-2-ming.lei@redhat.com> <83765d8a-bae3-41d3-5f35-329727022843@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83765d8a-bae3-41d3-5f35-329727022843@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 08, 2020 at 06:41:48PM -0700, Bart Van Assche wrote:
> On 2020-09-07 18:23, Ming Lei wrote:
> > +bool percpu_ref_inited(struct percpu_ref *ref)
> > +{
> > +	return percpu_count_ptr(ref) != NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(percpu_ref_inited);
> 
> Wouldn't percpu_ref_initialized() be a better name?

Or maybe even percpu_ref_is_initialized
