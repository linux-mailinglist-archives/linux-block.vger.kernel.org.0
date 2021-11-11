Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BF144D395
	for <lists+linux-block@lfdr.de>; Thu, 11 Nov 2021 09:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhKKI75 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Nov 2021 03:59:57 -0500
Received: from verein.lst.de ([213.95.11.211]:57490 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230256AbhKKI74 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 03:59:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 19F4667373; Thu, 11 Nov 2021 09:57:06 +0100 (CET)
Date:   Thu, 11 Nov 2021 09:57:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] blk-mq: rename blk_attempt_bio_merge
Message-ID: <20211111085705.GB476@lst.de>
References: <20211111085134.345235-1-ming.lei@redhat.com> <20211111085134.345235-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111085134.345235-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 11, 2021 at 04:51:34PM +0800, Ming Lei wrote:
> It is very annoying to have two block layer functions which share same
> name, so rename blk_attempt_bio_merge in blk-mq.c as
> blk_mq_attempt_bio_merge.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
