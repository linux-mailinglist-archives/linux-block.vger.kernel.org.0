Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18392B8068
	for <lists+linux-block@lfdr.de>; Thu, 19 Sep 2019 19:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbfISRst (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Sep 2019 13:48:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46310 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389433AbfISRss (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Sep 2019 13:48:48 -0400
Received: by mail-io1-f65.google.com with SMTP id d17so9675394ios.13
        for <linux-block@vger.kernel.org>; Thu, 19 Sep 2019 10:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iC74FDHxst+tccsETTle3rR7zrtvRzSQgS7jIMs0SKk=;
        b=K8VVX19of7Fa2rcJGX5psG2u0F8xohovO/uB9f7qab3ZbxMpQjp9ogZYxXLsqVwxIB
         ms8OBL23MhzE73wvlkkcPYwkUlJL23U60wI5zokEp7lm05hI8bLb2SCa9MprtYsivXQU
         /4iAO8ae1zTwhOP2zmfXSNnwIAnfIOVpWqh6fPbCBjmqA9NAvVTRGTQFeJNQD4aDqhqx
         Vwp6ZP8JV+zXbRDprNXGP3bJd/Hw8DE/xXZAV5PWqfXbkGbqa51iZvhHadJF95OyAh83
         IuCh4WUH+yrE1dR3qYviM7yQ/rMiyQz5l8mmT1J4+/GrFp4Usde7MEvQffREy5oioTKs
         DuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iC74FDHxst+tccsETTle3rR7zrtvRzSQgS7jIMs0SKk=;
        b=sROCXLfs7/iEbm2sbMcKEN6Te696/uJ1T2Cr+BMF8GTiINrtnQdUDh/tvMUw89Gjtx
         ouTA0NGQK9s7CRLTMYerMvWGRbpkKBg0xnO+oZVzRhZyEsCHMouaMOuEQCORWoLnjdfA
         wStboVH2CWNa80+anzOqdnp13v5o9EZUn8vgpGXqtVcSrEIumQ01ILfFFDLGxmuI5+O1
         jA7HUCuFdkwFouifpzZjRFi1vkaFVsLUeKl2dTbJ+l/Vm87+dMxUGRrGsFKdwslkUX1+
         eZziFGg8o27dXkmrTvyVOt9M0xJupqOOLpGeqeYGV85HJp3MMlKXuHb6cfbnTqvb9ZBF
         JZCQ==
X-Gm-Message-State: APjAAAWXlr4Ey6dsxLAtfD72z++vIlnT9rR+GsfYkSuGQ3qDaqE+2qPP
        3Aesdnx7ofLxCoPneV1T3HAD3w==
X-Google-Smtp-Source: APXvYqxkQMcVy/dqy9FUS/DErap8Adkqyvgw4K9DQx7F4UW0e2KGzwQyJFNQqYvQ1UleK5CHZEj8WQ==
X-Received: by 2002:a5e:851a:: with SMTP id i26mr13106869ioj.304.1568915327323;
        Thu, 19 Sep 2019 10:48:47 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id f8sm7883134ioo.27.2019.09.19.10.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:48:46 -0700 (PDT)
Subject: Re: [RFC PATCH 0/2] blk-mq I/O scheduling fixes
To:     Hannes Reinecke <hare@suse.de>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Hans Holmberg <hans.holmberg@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20190919094547.67194-1-hare@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1bde2781-9958-9bf1-2d89-8c4f9f0d8cba@kernel.dk>
Date:   Thu, 19 Sep 2019 11:48:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919094547.67194-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/19/19 3:45 AM, Hannes Reinecke wrote:
> Hi all,
> 
> Damien pointed out that there are some areas in the blk-mq I/O
> scheduling algorithm which have a distinct legacy feel to it,
> and prohibit multiqueue I/O schedulers from working properly.
> These two patches should clear up this situation, but as it's
> not quite clear what the original intention of the code was
> I'll be posting them as an RFC.
> 
> So as usual, comments and reviews are welcome.
> 
> Hannes Reinecke (2):
>    blk-mq: fixup request re-insert in blk_mq_try_issue_list_directly()
>    blk-mq: always call into the scheduler in blk_mq_make_request()
> 
>   block/blk-mq.c | 9 ++-------
>   1 file changed, 2 insertions(+), 7 deletions(-)

Not quite sure what to do with this... Did you test them at all?
One is obviously broken and would crash the kernel, the other
is/was a performance optimization done not that long ago.

Just going to ignore this series for now.

-- 
Jens Axboe

