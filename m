Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5C356A35
	for <lists+linux-block@lfdr.de>; Wed, 26 Jun 2019 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfFZNSF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Jun 2019 09:18:05 -0400
Received: from verein.lst.de ([213.95.11.211]:43120 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbfFZNSF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:18:05 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C60EF68B05; Wed, 26 Jun 2019 15:17:33 +0200 (CEST)
Date:   Wed, 26 Jun 2019 15:17:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 1/3] block: Allow mapping of vmalloc-ed buffers
Message-ID: <20190626131733.GA5363@lst.de>
References: <20190626065438.19307-1-damien.lemoal@wdc.com> <20190626065438.19307-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626065438.19307-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is still missing the proper vmalloc flushing and invalidation.

We can't leave that to the callers as is very subtle and trivial
to get wrong, as shown by your couple of previous attempts.
