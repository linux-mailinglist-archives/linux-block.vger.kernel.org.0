Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CDC988D4
	for <lists+linux-block@lfdr.de>; Thu, 22 Aug 2019 03:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbfHVBA6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 21 Aug 2019 21:00:58 -0400
Received: from verein.lst.de ([213.95.11.211]:42390 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfHVBA6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 21:00:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D0DE468BFE; Thu, 22 Aug 2019 03:00:55 +0200 (CEST)
Date:   Thu, 22 Aug 2019 03:00:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: bio_add_pc_page cleanups
Message-ID: <20190822010055.GA11104@lst.de>
References: <20190812153958.29560-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812153958.29560-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 12, 2019 at 05:39:55PM +0200, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series cleans up the bio_add_pc_page code and reuses more code
> from the regular bio path.

ping?
