Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319691D60DE
	for <lists+linux-block@lfdr.de>; Sat, 16 May 2020 14:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEPMmR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 16 May 2020 08:42:17 -0400
Received: from verein.lst.de ([213.95.11.211]:60438 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPMmR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 08:42:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFD2468B05; Sat, 16 May 2020 14:42:15 +0200 (CEST)
Date:   Sat, 16 May 2020 14:42:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH 2/5] bio.h: Declare the arguments of bio iteration
 functions const
Message-ID: <20200516124215.GB13544@lst.de>
References: <20200516001914.17138-1-bvanassche@acm.org> <20200516001914.17138-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200516001914.17138-3-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 15, 2020 at 05:19:11PM -0700, Bart Van Assche wrote:
> This change makes it possible to pass 'const struct bio *' arguments to
> these functions.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
