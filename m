Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618841BA6EE
	for <lists+linux-block@lfdr.de>; Mon, 27 Apr 2020 16:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgD0OxI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 27 Apr 2020 10:53:08 -0400
Received: from verein.lst.de ([213.95.11.211]:48730 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgD0OxI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Apr 2020 10:53:08 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77BBF68C7B; Mon, 27 Apr 2020 16:53:05 +0200 (CEST)
Date:   Mon, 27 Apr 2020 16:53:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Martijn Coenen <maco@android.com>
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org
Subject: Re: [PATCH v3 1/9] loop: Factor out loop size validation
Message-ID: <20200427145305.GA5490@lst.de>
References: <20200427074222.65369-1-maco@android.com> <20200427074222.65369-2-maco@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427074222.65369-2-maco@android.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static int
> +loop_validate_size(loff_t size)
> +{
> +	if ((loff_t)(sector_t)size != size)
> +		return -EFBIG;
> +	else
> +		return 0;

Nit: no real need for an else after a return.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
