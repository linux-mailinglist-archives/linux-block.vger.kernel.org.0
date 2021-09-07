Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423A6402398
	for <lists+linux-block@lfdr.de>; Tue,  7 Sep 2021 08:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhIGGvG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 7 Sep 2021 02:51:06 -0400
Received: from verein.lst.de ([213.95.11.211]:34788 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231429AbhIGGvG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Sep 2021 02:51:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 856C367373; Tue,  7 Sep 2021 08:49:58 +0200 (CEST)
Date:   Tue, 7 Sep 2021 08:49:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [PATCH] brd: reduce the brd_devices_mutex scope
Message-ID: <20210907064958.GA29211@lst.de>
References: <65b57a74-34db-d466-df67-c7a7bb529ae3@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b57a74-34db-d466-df67-c7a7bb529ae3@i-love.sakura.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 06, 2021 at 09:47:54PM +0900, Tetsuo Handa wrote:
> +	mutex_lock(&brd_devices_mutex);
> +	list_for_each_entry(brd, &brd_devices, brd_list) {
> +		if (brd->brd_number != i)
> +			continue;
> +		mutex_unlock(&brd_devices_mutex);
> +		return -EEXIST;

Nit:  I'd do this as:

		if (brd->brd_number == i) {
			mutex_unlock(&brd_devices_mutex);
			return -EEXIST;
		}

to flow a little nicer.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
