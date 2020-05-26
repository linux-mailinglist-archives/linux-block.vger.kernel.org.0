Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2581BA70C
	for <lists+linux-block@lfdr.de>; Mon, 27 Apr 2020 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgD0O4k (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Apr 2020 10:56:40 -0400
Received: from verein.lst.de ([213.95.11.211]:48773 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgD0O4j (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 10:56:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5EF7C68C7B; Mon, 27 Apr 2020 16:56:37 +0200 (CEST)
Date:   Mon, 27 Apr 2020 16:56:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v3 5/9] loop: Remove figure_loop_size()
Message-ID: <20200427145637.GE5490@lst.de>
References: <20200427074222.65369-1-maco@android.com> <20200427074222.65369-6-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427074222.65369-6-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 27, 2020 at 09:42:18AM +0200, Martijn Coenen wrote:
> This function was now only used by loop_set_capacity(), and updating the
> offset and sizelimit is no longer necessary in that case. Just open code
> the remaining code in the caller instead.

Removing the now unused size update logic better fits into the previous
patch I think.  Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
