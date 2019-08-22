Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFD5D988C5
	for <lists+linux-block@lfdr.de>; Thu, 22 Aug 2019 02:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbfHVAzL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 21 Aug 2019 20:55:11 -0400
Received: from verein.lst.de ([213.95.11.211]:42324 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728724AbfHVAzL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 20:55:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 538FB68BFE; Thu, 22 Aug 2019 02:55:08 +0200 (CEST)
Date:   Thu, 22 Aug 2019 02:55:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk
Subject: Re: [PATCH V3 1/6] null_blk: move duplicate code to callers
Message-ID: <20190822005508.GB10938@lst.de>
References: <20190821061314.3262-1-chaitanya.kulkarni@wdc.com> <20190821061314.3262-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821061314.3262-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 20, 2019 at 11:13:09PM -0700, Chaitanya Kulkarni wrote:
> This is a preparation patch which moves the duplicate code for sectors
> and nr_sectors calculations for bio vs request mode into their
> respective callers (null_queue_bio(), null_qeueue_req()). Now the core
> function only deals with the respective actions and commands instead of
> having to calculte the bio vs req operations and different sector
> related variables. We also move the flush command handling at the top
> which significantly simplifies the rest of the code.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
