Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475851B2A9D
	for <lists+linux-block@lfdr.de>; Tue, 21 Apr 2020 17:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgDUPD6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Apr 2020 11:03:58 -0400
Received: from verein.lst.de ([213.95.11.211]:47161 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgDUPD6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 11:03:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C972768C4E; Tue, 21 Apr 2020 17:03:54 +0200 (CEST)
Date:   Tue, 21 Apr 2020 17:03:54 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: stop using ioctl_by_bdev in the s390 DASD driver
Message-ID: <20200421150354.GA10191@lst.de>
References: <20200421061226.33731-1-hch@lst.de> <b4f38eb4-ab32-6713-fb8a-0c8e81efc645@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4f38eb4-ab32-6713-fb8a-0c8e81efc645@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 21, 2020 at 04:17:53PM +0200, Stefan Haberland wrote:
> I can imagine some ways to get rid of this ioctl_by_bdev. Maybe having a
> udev
> rule to add a partition from userspace or having the driver add the implicit
> partition at the end. Or maybe something else.
> 
> If it is OK I will have a look at this and discuss this issue with my
> colleagues and come up with a different approach.

Sure, we can wait a few days.  Note that I don't want to break existing
userspace, which kinda speaks against a udev solution.
