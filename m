Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A276A42C69E
	for <lists+linux-block@lfdr.de>; Wed, 13 Oct 2021 18:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbhJMQpU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Oct 2021 12:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233925AbhJMQpT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634143395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DvE9A+LL2XADoLsMv/QT6HGglilUC7cXAXtJNsfa8lA=;
        b=IIypTiFYhWCZbUSA7VEpUQlZe+SKXR1aCyCxIeoqcvY99VskuswRyMMy2b0K556uJIiCjv
        Ox6qgb6HttmrXI9seTaJDYkZUlW9UeyOf+kL7QD/bz8MJ74DIoTbmWfaHbeNmatD8nYYnh
        K+JHChfxdua7U/XCkmmnTUNapGNrs3s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-bUuDISRMO_ePRUDjRmRUvA-1; Wed, 13 Oct 2021 12:43:14 -0400
X-MC-Unique: bUuDISRMO_ePRUDjRmRUvA-1
Received: by mail-qt1-f197.google.com with SMTP id 103-20020aed2170000000b002a79b815862so1954042qtc.11
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DvE9A+LL2XADoLsMv/QT6HGglilUC7cXAXtJNsfa8lA=;
        b=3+9CaU65cNSt+61iVSL27xo2vbbP37lP5r/0WmcLeAwZ6AcnGcvSVSjPuVFX57Yjds
         9ZBlMXhTn0WKC57lJXEjmW6qMk/94d2/LAriG9MAq9O/s0eYLz2ax83rTu7CEZBh/9tz
         bTpoK62Locih4mSZ2dRW/x+FiJObQ2HzrdrpyGZoAEF5Rz5dhyicj+Oh5RGTj1cPjaqd
         kyQYtsflbKKI0HpeYUUoLtRSDeDYfe2YeUuXLEngtYwRG5zWZ+Z39iJdL8pcpTcMFYTb
         iWy5OmOP+bk90HO1ND5RgrISQp3YDOxn/A2vp4haNuZ6r0dQxfL+B3sjJ3lGgvUDEC3Q
         hwIA==
X-Gm-Message-State: AOAM530XsI8VUZQ2wjA1/myhLbmB2zhzlwJwVjAaVMzUwa72rSYEV9JW
        0SnrM75z76tusnkquPJWRbwkSsIArU50q/OUpruCjC4/YkkhkEmwA14B+UMVmRluhCLd6MmEsn1
        JwhPQHUvlJk5Q3P7nUxofTg==
X-Received: by 2002:ac8:7d02:: with SMTP id g2mr450232qtb.66.1634143393846;
        Wed, 13 Oct 2021 09:43:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4uQGBl82DdkygPL4oygkwPDtljuRYBV8+ESqW4tKnOahM7pZ+SYljUTQ3BKpa4FdVi33PjA==
X-Received: by 2002:ac8:7d02:: with SMTP id g2mr450159qtb.66.1634143393507;
        Wed, 13 Oct 2021 09:43:13 -0700 (PDT)
Received: from localhost ([45.130.83.141])
        by smtp.gmail.com with ESMTPSA id q14sm77870qtl.73.2021.10.13.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:43:13 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:43:12 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH 03/29] dm: use bdev_nr_sectors instead of open coding it
Message-ID: <YWcMoCZxfpUzKZQ+@redhat.com>
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013051042.1065752-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13 2021 at  1:10P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Mike Snitzer <snitzer@redhat.com>

