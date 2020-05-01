Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434731C1BA1
	for <lists+linux-block@lfdr.de>; Fri,  1 May 2020 19:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgEAR0k (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 1 May 2020 13:26:40 -0400
Received: from verein.lst.de ([213.95.11.211]:47955 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728972AbgEAR0h (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 May 2020 13:26:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A45C68C65; Fri,  1 May 2020 19:26:35 +0200 (CEST)
Date:   Fri, 1 May 2020 19:26:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Martijn Coenen <maco@android.com>, axboe@kernel.dk, hch@lst.de,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/10] loop: Factor out loop size validation
Message-ID: <20200501172634.GA22792@lst.de>
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-2-maco@android.com> <20200429141229.GE700644@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429141229.GE700644@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 10:12:29PM +0800, Ming Lei wrote:
> > +static int
> > +loop_validate_size(loff_t size)
> > +{
> > +	if ((loff_t)(sector_t)size != size)
> > +		return -EFBIG;
> > +
> > +	return 0;
> > +}
> > +
> 
> Now sector_t has been switched to u64 unconditionally, do we still need such
> validation?

Oops, completely forgot about that.  Yes, we can just kill the
checks.
