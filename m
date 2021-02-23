Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5C322CD6
	for <lists+linux-block@lfdr.de>; Tue, 23 Feb 2021 15:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhBWOup (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 23 Feb 2021 09:50:45 -0500
Received: from verein.lst.de ([213.95.11.211]:34136 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233152AbhBWOun (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 09:50:43 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E79C668D0A; Tue, 23 Feb 2021 15:50:00 +0100 (CET)
Date:   Tue, 23 Feb 2021 15:50:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: fix logging on capacity change
Message-ID: <20210223145000.GA17432@lst.de>
References: <20210223085015.832088-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223085015.832088-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 23, 2021 at 04:50:15PM +0800, Ming Lei wrote:
> Local variable of 'capacity' stores the previous disk capacity, and
> 'size' variable records the latest disk capacity, so swap them for
> fixing logging on capacity change.

Ok, looks like we're racing for fixes a lot lately.  I have the same
fix commited locally since this morning..

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
