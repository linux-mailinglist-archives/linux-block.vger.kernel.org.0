Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13EF7195AEC
	for <lists+linux-block@lfdr.de>; Fri, 27 Mar 2020 17:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgC0QR6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 27 Mar 2020 12:17:58 -0400
Received: from verein.lst.de ([213.95.11.211]:51989 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbgC0QR5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 12:17:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 016F468C4E; Fri, 27 Mar 2020 17:17:54 +0100 (CET)
Date:   Fri, 27 Mar 2020 17:17:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: simplify queue allocation
Message-ID: <20200327161754.GA19480@lst.de>
References: <20200327083012.1618778-1-hch@lst.de> <b1123d19-0c4a-5d3d-d0d4-0a412830c2b0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1123d19-0c4a-5d3d-d0d4-0a412830c2b0@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 27, 2020 at 09:53:16AM -0600, Jens Axboe wrote:
> On 3/27/20 2:30 AM, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > this series ensures all allocated queues have a valid ->make_request_fn
> > and also nicely consolidates the code for allocating queues.
> 
> This seems fine to me, but might be a good idea to shuffle 4/5 as the
> last one, and do that one inside the merge window to avoid any potential
> silly merge conflicts.

they should be trivial to reorder if you want to skip patch 4 for now.
But looking at current linux-next there isn't any conflict yet,
and I don't expect one as most block drivers go through the block
tree anyway.
