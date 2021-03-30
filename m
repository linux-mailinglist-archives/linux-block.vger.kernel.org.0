Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A4634EE88
	for <lists+linux-block@lfdr.de>; Tue, 30 Mar 2021 18:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhC3Qxx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Mar 2021 12:53:53 -0400
Received: from verein.lst.de ([213.95.11.211]:59758 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232246AbhC3Qxc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 12:53:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8C3BC68B02; Tue, 30 Mar 2021 18:53:30 +0200 (CEST)
Date:   Tue, 30 Mar 2021 18:53:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] block: shutdown blktrace in case of fatal signal
 pending
Message-ID: <20210330165330.GA13829@lst.de>
References: <20210323081440.81343-1-ming.lei@redhat.com> <20210323081440.81343-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323081440.81343-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 04:14:39PM +0800, Ming Lei wrote:
> blktrace may allocate lots of memory, if the process is terminated
> by user or OOM, we need to provide one chance to remove the trace
> buffer, otherwise memory leak may be caused.
> 
> Fix the issue by shutdown blktrace in case of task exiting in
> blkdev_close().
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

This just seems weird.  blktrace has no relationship to open
block device instances.
