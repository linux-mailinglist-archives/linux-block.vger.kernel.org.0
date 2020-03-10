Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38618056A
	for <lists+linux-block@lfdr.de>; Tue, 10 Mar 2020 18:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCJRsK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 10 Mar 2020 13:48:10 -0400
Received: from verein.lst.de ([213.95.11.211]:54323 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgCJRsJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 13:48:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C5C4168BE1; Tue, 10 Mar 2020 18:48:07 +0100 (CET)
Date:   Tue, 10 Mar 2020 18:48:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] loop: Only change blocksize when needed.
Message-ID: <20200310174807.GB8359@lst.de>
References: <20200310131230.106427-1-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310131230.106427-1-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 10, 2020 at 02:12:30PM +0100, Martijn Coenen wrote:
> Return early in loop_set_block_size() if the requested block size is
> identical to the one we already have; this avoids expensive calls to
> freeze the block queue.
> 
> Signed-off-by: Martijn Coenen <maco@android.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
