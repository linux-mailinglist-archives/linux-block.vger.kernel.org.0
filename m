Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A011242B6BB
	for <lists+linux-block@lfdr.de>; Wed, 13 Oct 2021 08:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbhJMGSR (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Oct 2021 02:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbhJMGSP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 02:18:15 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A708C061753
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 23:16:13 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id k26so1528173pfi.5
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 23:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FeQrChfiZcW4o0OhHTmPDOdTdbcOGCmUWNGR2fssds0=;
        b=YUuG6H1i9AjWoYvXd657AlnL8Btrj3iAYL/kBUykjBQlXgbXqBCSYgFqW+ybNjzAeB
         flHfU7/d2gVIiRxHZf0let0/mE+C7OG46tBNBXIlx9AYwOAntMTNFSW889cvlMxABatE
         ibs+ClrRJ9QM6AUZ6rkBA4X98UUtvKEjHgCX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FeQrChfiZcW4o0OhHTmPDOdTdbcOGCmUWNGR2fssds0=;
        b=W8FPDGrynwrqAsFi8d92/yWbR/Bfk0zFc2YOczZj6wEvicZxXRl69X175mIg4oo6PJ
         Mxjwx1i+T7mqfD4gftNAVVO5DiBLJb2RIyiJBn73UjigMyncSquJcLbANnZvopTvGZAK
         6meDU5qtcM46RdAzdse2uWFftp2M23CId1HY7LCorOh7Q7TehoD/30BqJp7p+T9Gc119
         jn8gCD5JFBKZzhWogivQA5pZDMBLAOB2znseANGGM+CxI6hdEcNN+TfiATmjutZriqgu
         sBYSJsYGgyirCeYZiWuDx1j6cq6+gBOgs8SO8Z8NisuVJvHm5vcSFRdgeoVz63iKS1/u
         zZyw==
X-Gm-Message-State: AOAM531kRdoF52Lh1/J2H+Ls1jBwoZESAdthxbQ3pzQihNZtDnZEehXa
        Y7NlWvXwdT2FSuWQJjde7pUnGA==
X-Google-Smtp-Source: ABdhPJwmuFRgBzGEKwhfH80cvrnOY6Q3ng7kI1vOHwrwBDvns1KKcyGoScUlnacdxAU8v7fqrhUUVw==
X-Received: by 2002:a63:d654:: with SMTP id d20mr26275164pgj.122.1634105772620;
        Tue, 12 Oct 2021 23:16:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a28sm13085937pfg.33.2021.10.12.23.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 23:16:12 -0700 (PDT)
Date:   Tue, 12 Oct 2021 23:16:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, drbd-dev@lists.linbit.com,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 12/29] cramfs: use bdev_nr_sectors instead of open coding
 it
Message-ID: <202110122315.7CFF5F6@keescook>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-13-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 07:10:25AM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/cramfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 2be65269a987c..3e44cc3ed0543 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -209,7 +209,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
>  		return read_buffers[i] + blk_offset;
>  	}
>  
> -	devsize = mapping->host->i_size >> PAGE_SHIFT;
> +	devsize = bdev_nr_sectors(sb->s_bdev) >> (PAGE_SHIFT - SECTOR_SHIFT);

I find this less readable than "bytes >> PAGE_SHIFT". I'd suggest this
use a new bdev_nr_bytes() helper.

-- 
Kees Cook
