Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7BD2475B
	for <lists+linux-block@lfdr.de>; Tue, 21 May 2019 07:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfEUFLj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 May 2019 01:11:39 -0400
Received: from verein.lst.de ([213.95.11.211]:57303 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfEUFLj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 01:11:39 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 2704668B05; Tue, 21 May 2019 07:11:18 +0200 (CEST)
Date:   Tue, 21 May 2019 07:11:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: fix nr_phys_segments vs iterators accounting v2
Message-ID: <20190521051117.GB29120@lst.de>
References: <20190516084058.20678-1-hch@lst.de> <20190520111714.GA5369@lst.de> <8ccb3744-53e3-71b0-cdec-6f703b2bd5c8@fb.com> <20190521011700.GC14268@ming.t460p> <a5a08ee7-5bbf-3285-5f02-4f6544770340@kernel.dk> <20190521012935.GE14268@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521012935.GE14268@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 21, 2019 at 09:29:36AM +0800, Ming Lei wrote:
> I am fine with this route, and just try to make the commit log not
> misleading.

I'll resend with the updated tags.  And I'll also look into the whole
recalc segments vs discard issue later, as we might have more dragons
hidden there.
