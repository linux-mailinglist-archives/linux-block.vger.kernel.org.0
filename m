Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D3642F940
	for <lists+linux-block@lfdr.de>; Fri, 15 Oct 2021 18:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbhJOQ7N (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 15 Oct 2021 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJOQ7M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 12:59:12 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDDBC061768
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 09:57:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id k26so8863414pfi.5
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 09:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K+6isvwekOgtvopkqE4I0h7AgNguipVYqeEY21w12Mo=;
        b=XiV2alQ2bCUhPKCRDy35L10uw/QVL0RMTX2wcoCawcZP+N544npMKl6qJHVNuREVMJ
         /3k+gOTpyuD9GvBFRwBhJkrM/MdxCBPLCnVY/0SS1G/dQv3yvOXHSbjERi1b1HJ8bt6c
         zWuPktMOT2lWvGeRm1bA9Ib7yGAG3xwtDOTDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K+6isvwekOgtvopkqE4I0h7AgNguipVYqeEY21w12Mo=;
        b=bcY+x9441Q97gQJ6/YNYTAvi1gvN1baek4CnkGTiv3pwNH7jF1mjFoyJ4TorQ5CNTX
         mnmkDUPqnnBrn6CHm64W5esoJPo1M/zOa5zj3t/X5tdwdb/t/fggYdA+a9Xb462HtWhJ
         2UE4K9ohqJZVbOJnvmHl2BMI4VCJvEEQ4Oew9B9naJ5C117IOu7oPN0ovtIdLRWmMn01
         mcZl5A3efWwICqE/FnycSDENkeYu4dP1d+j4SaDSg56vnQamjhEMUV6mjmZT8dy7bNzc
         Payq2FzhOX2BtiW2nGOlDjEcKfZHnp6+Jq6HYsQ1Edb75dpQfUYjkaF2E5sKS87QzeTI
         wpUg==
X-Gm-Message-State: AOAM530gbl38rvIVasN9EoquZvsFBLRgQnJJ+xmSk/h8TV9bhaizrSPH
        ltTNbGG1REkMjRVPf76DcrYjVw==
X-Google-Smtp-Source: ABdhPJy+YUT6npY/fZ/G9URvGOZpt9eamOIJH1D5JMCGxtLxyzdwQfs5MmBQFVKQI/Zn2W8hW6yLYA==
X-Received: by 2002:a05:6a00:1309:b0:44d:4d1e:c930 with SMTP id j9-20020a056a00130900b0044d4d1ec930mr12851663pfu.65.1634317024412;
        Fri, 15 Oct 2021 09:57:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b16sm5793589pfm.58.2021.10.15.09.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 09:57:04 -0700 (PDT)
Date:   Fri, 15 Oct 2021 09:57:03 -0700
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
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 23/30] squashfs: use bdev_nr_bytes instead of open coding
 it
Message-ID: <202110150957.38CBB0C08@keescook>
References: <20211015132643.1621913-1-hch@lst.de>
 <20211015132643.1621913-24-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015132643.1621913-24-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 15, 2021 at 03:26:36PM +0200, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
