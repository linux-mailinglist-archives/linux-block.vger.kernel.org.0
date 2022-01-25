Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA7049AC40
	for <lists+linux-block@lfdr.de>; Tue, 25 Jan 2022 07:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbiAYGTC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Jan 2022 01:19:02 -0500
Received: from verein.lst.de ([213.95.11.211]:34067 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230527AbiAYGLD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Jan 2022 01:11:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B3DC568BEB; Tue, 25 Jan 2022 07:10:57 +0100 (CET)
Date:   Tue, 25 Jan 2022 07:10:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Vivek Goyal <vgoyal@redhat.com>, Pei Zhang <pezhang@redhat.com>
Subject: Re: [PATCH V2] block: loop:use kstatfs.f_bsize of backing file to
 set discard granularity
Message-ID: <20220125061057.GA26444@lst.de>
References: <20220125044005.211943-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125044005.211943-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 25, 2022 at 12:40:05PM +0800, Ming Lei wrote:
>  	} else {
> +		struct kstatfs sbuf;
> +
>  		max_discard_sectors = UINT_MAX >> 9;
> -		granularity = inode->i_sb->s_blocksize;
> +		if (!vfs_statfs(&file->f_path, &sbuf))
> +			granularity = sbuf.f_bsize;
> +		else
> +			granularity = PAGE_SIZE;

If vfs_statfs fails we're pretty much toast and there isn't really any
point in continuing here.

