Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F62A428C36
	for <lists+linux-block@lfdr.de>; Mon, 11 Oct 2021 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhJKLlT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 11 Oct 2021 07:41:19 -0400
Received: from verein.lst.de ([213.95.11.211]:37003 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233878AbhJKLlT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Oct 2021 07:41:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15F1D68B05; Mon, 11 Oct 2021 13:39:12 +0200 (CEST)
Date:   Mon, 11 Oct 2021 13:39:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 1/5] nvme: add APIs for stopping/starting admin queue
Message-ID: <20211011113911.GA16138@lst.de>
References: <20210930125621.1161726-1-ming.lei@redhat.com> <20210930125621.1161726-2-ming.lei@redhat.com> <95d25bd6-f632-67cc-657e-5158c6412256@nvidia.com> <YVu3EjPqT8VME/oY@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVu3EjPqT8VME/oY@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 05, 2021 at 10:23:14AM +0800, Ming Lei wrote:
> On Fri, Oct 01, 2021 at 05:56:04AM +0000, Chaitanya Kulkarni wrote:
> > On 9/30/2021 5:56 AM, Ming Lei wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > Add two APIs for stopping and starting admin queue.
> > > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > 
> > 
> > this patch looks good to me, but from the feedback I've received in past 
> > we need to add the new functions in the patch where they are actually 
> > used than adding it in a separate patch.

The above is for use inside the same driver/subsystem.  Cross-subsystem
we usually do what Ming did here.
