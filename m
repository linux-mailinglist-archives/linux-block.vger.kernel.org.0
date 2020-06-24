Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7492076DD
	for <lists+linux-block@lfdr.de>; Wed, 24 Jun 2020 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403814AbgFXPJq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Jun 2020 11:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404067AbgFXPJp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 11:09:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA3DC061795
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 08:09:45 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id bh7so1156215plb.11
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 08:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hm3ympvKduUNh5129dxmMgwX0W3YAimhGqajkDVt8Jw=;
        b=hV4dK5XM2LY4lKz5JyFuMP7rwg4k+z0fv4ioWmeLSYRoWipXBV5oPcLKy7YendLDCZ
         oDFosVNt6DL0z1pDwv0sNbBwAsilFivXTaLG67vShvTaoEGSgipBx0Sl+J0wYd1A+71C
         BGKYEAmSNKmVYbv4bOThY6xNVDMFBRWBC8+KzWGHQ85PX7y987rUcmLQH/BeFd3Ieh+b
         nZfarXGDG4Kb6ApvBoP/t++mTsciC8K7rhuQH5z7og8lfM7+bjVWcYdzX9pqXEdpunZI
         qmk+WQgIPnSo4VS+yhzG1ohGUvAD8k2yEI9IgtDlWbvDslBrrpMUm6TANHAszsmBLpX2
         taTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hm3ympvKduUNh5129dxmMgwX0W3YAimhGqajkDVt8Jw=;
        b=kK8GyDYwACCWc212Dp2MR2JQaG8Uwsc7020sBa+qX30qlNllsve0KaIuWSUQt0YSOg
         TbxgfietephpLL4apm2LOoWpq0u+0sh8far/P8VggsFu8GXWmBwROhi21leu6oa26Hm8
         ZWFaiGdL/+oCTWV+rN2fMzzxUowPT8PM+b4VISQ/erCuNv8e+6FnE3DEfnmWlsDBKOvy
         5GGBPVi8tBsc+ngLJ5Ewtx88kqM5ic5UokVDlAkQB+7pm/G3RYC1t7gc++bRrbznq08y
         zZ27eePuyghYudC9vmqvAenYwhKgshRjaMu+MQdxNqqy9c4MtGISJrJ7fbXIH56oA/iG
         Iuuw==
X-Gm-Message-State: AOAM532YSuzPOMj0Ujd7PCjNS0obpSYz9DIDGWhdUP3VYDLfh6/Bk/RQ
        LgkmMuJb5d3o/YI0eMHzV6DV9Q==
X-Google-Smtp-Source: ABdhPJxHnvpBKJvuZJNpgdxE6VuzhPTYXWKz1m98mZL6We6g1vXw31kuyX7e9kclNRUs4CdeE/1Hbw==
X-Received: by 2002:a17:90a:3aed:: with SMTP id b100mr26487773pjc.80.1593011384970;
        Wed, 24 Jun 2020 08:09:44 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v62sm9071851pfb.119.2020.06.24.08.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 08:09:44 -0700 (PDT)
Subject: Re: move block bits out of fs.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200620071644.463185-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c2fba635-b2ce-a2b5-772b-4bfcb9b43453@kernel.dk>
Date:   Wed, 24 Jun 2020 09:09:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620071644.463185-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/20/20 1:16 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes various remaining block bits out of fs.h and cleans
> up a few loose ends around that.
> 
> Diffstat:
>  drivers/tty/sysrq.c         |    2 
>  fs/adfs/super.c             |    1 
>  fs/affs/file.c              |    1 
>  fs/befs/linuxvfs.c          |    1 
>  fs/block_dev.c              |    5 -
>  fs/efs/super.c              |    1 
>  fs/hfs/inode.c              |    1 
>  fs/internal.h               |   17 +++-
>  fs/jfs/jfs_mount.c          |    1 
>  fs/jfs/resize.c             |    1 
>  fs/ntfs/dir.c               |    1 
>  fs/proc/devices.c           |    1 
>  fs/quota/dquot.c            |    1 
>  fs/reiserfs/procfs.c        |    1 
>  include/linux/bio.h         |    3 
>  include/linux/blk_types.h   |   39 +++++++++-
>  include/linux/blkdev.h      |  140 ++++++++++++++++++++++--------------
>  include/linux/buffer_head.h |    1 
>  include/linux/dasd_mod.h    |    2 
>  include/linux/fs.h          |  169 --------------------------------------------
>  include/linux/genhd.h       |   39 ++++++++--
>  include/linux/jbd2.h        |    1 
>  security/loadpin/loadpin.c  |    1 
>  23 files changed, 192 insertions(+), 238 deletions(-)

Applied for 5.9 - I kept this in a separate topic branch, fwiw. There's the
potential for some annoying issues with this, so would rather have it in
a branch we can modify easily, if we need to.

-- 
Jens Axboe

