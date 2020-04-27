Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052B11BA703
	for <lists+linux-block@lfdr.de>; Mon, 27 Apr 2020 16:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgD0Ozx (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Apr 2020 10:55:53 -0400
Received: from verein.lst.de ([213.95.11.211]:48764 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgD0Ozw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 10:55:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E836468C7B; Mon, 27 Apr 2020 16:55:48 +0200 (CEST)
Date:   Mon, 27 Apr 2020 16:55:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v3 4/9] loop: Refactor loop_set_status() size
 calculation
Message-ID: <20200427145548.GD5490@lst.de>
References: <20200427074222.65369-1-maco@android.com> <20200427074222.65369-5-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427074222.65369-5-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 27, 2020 at 09:42:17AM +0200, Martijn Coenen wrote:
> figure_loop_size() calculates the loop size based on the passed in
> parameters, but at the same time it updates the offset and sizelimit
> parameters in the loop device configuration. That is a somewhat
> unexpected side effect of a function with this name, and it is only only
> needed by one of the two callers of this function - loop_set_status().
> 
> Move the lo_offset and lo_sizelimit assignment back into loop_set_status(),
> and use the newly factored out functions to validate and apply the newly
> calculated size. This allows us to get rid of figure_loop_size in a
> follow-up commit.
> 

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
