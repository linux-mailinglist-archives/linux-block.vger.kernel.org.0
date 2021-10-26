Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB7743AD57
	for <lists+linux-block@lfdr.de>; Tue, 26 Oct 2021 09:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhJZHkV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Oct 2021 03:40:21 -0400
Received: from verein.lst.de ([213.95.11.211]:60777 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229687AbhJZHkV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 03:40:21 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 47AAF6732D; Tue, 26 Oct 2021 09:37:56 +0200 (CEST)
Date:   Tue, 26 Oct 2021 09:37:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/8] loop: relax loop dio use condition
Message-ID: <20211026073756.GE31967@lst.de>
References: <20211025094437.2837701-1-ming.lei@redhat.com> <20211025094437.2837701-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025094437.2837701-7-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 25, 2021 at 05:44:35PM +0800, Ming Lei wrote:
> So far loop dio requires the following conditions:
> 
> 1) lo->lo_offset is aligned with backing queue's logical block size
> 
> 2) loop queue's logical block size is <= backing queue's logical block
>    size

And both these checks absolutely do make sense.  We should not drop
them and gets us into the messy state of mixed direct and buffered
I/O.
