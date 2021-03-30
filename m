Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DA134EE94
	for <lists+linux-block@lfdr.de>; Tue, 30 Mar 2021 18:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhC3Q5j (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Mar 2021 12:57:39 -0400
Received: from verein.lst.de ([213.95.11.211]:59774 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232048AbhC3Q50 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 12:57:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F061768B02; Tue, 30 Mar 2021 18:57:23 +0200 (CEST)
Date:   Tue, 30 Mar 2021 18:57:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] blktrace: limit allowed total trace buffer size
Message-ID: <20210330165723.GB13829@lst.de>
References: <20210323081440.81343-1-ming.lei@redhat.com> <20210323081440.81343-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323081440.81343-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 04:14:40PM +0800, Ming Lei wrote:
> On some ARCHs, such as aarch64, page size may be 64K, meantime there may

Which we call arm64..

> be lots of CPU cores. relay_open() needs to allocate pages on each CPU
> blktrace, so easily too many pages are taken by blktrace. For example,
> on one ARM64 server: 224 CPU cores, 16G RAM, blktrace finally got
> allocated 7GB in case of 'blktrace -b 8192' which is used by device-mapper
> test suite[1]. This way could cause OOM easily.
> 
> Fix the issue by limiting max allowed pages to be 1/8 of totalram_pages().

Doesn't this break the blktrace ABI by using different buffer size
and numbers than the user asked for?  I think we can enforce an
upper limit and error out, but silently adjusting seems wrong.

Wouldn't it make more sense to fix userspace to not request so many
and so big buffers instead?
