Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C43F1C4E
	for <lists+linux-block@lfdr.de>; Thu, 19 Aug 2021 17:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbhHSPLf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Aug 2021 11:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238587AbhHSPLf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Aug 2021 11:11:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64EA060720;
        Thu, 19 Aug 2021 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629385859;
        bh=fFcBzjRflM4hbrLqEs20aoBGIxT7NSWEqPWR6k/lJEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qrI0MsZ6IufDjbnFUYYplXD5Ff0hSdbMNqYlP/tgxJ39SwixwRchl7mX6KK69e8dU
         /3NJ8IDae2uiBCrkKqLiZ7bIAcZlYS0KBtO3ecSCy6xHwNEj8FnsR5ZqQYYFtZY3JB
         L3enac+IRV9axidrDNKbgg2sQnMpezefUo/G66UM=
Date:   Thu, 19 Aug 2021 17:10:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hillf Danton <hdanton@sina.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH v4] block: genhd: don't call probe function with
 major_names_lock held
Message-ID: <YR50f6cQp0mdyeOf@kroah.com>
References: <f790f8fb-5758-ea4e-a527-0ee4af82dd44@i-love.sakura.ne.jp>
 <4e153910-bf60-2cca-fa02-b46d22b6e2c5@i-love.sakura.ne.jp>
 <YRi9EQJqfK6ldrZG@kroah.com>
 <a3f43d54-8d10-3272-1fbb-1193d9f1b6dd@i-love.sakura.ne.jp>
 <YRjcHJE0qEIIJ9gA@kroah.com>
 <d7d31bf1-33d3-b817-0ce3-943e6835de33@i-love.sakura.ne.jp>
 <20210818134752.GA7453@lst.de>
 <1f4218ca-9bfa-7d80-1c69-f5902715d8d9@i-love.sakura.ne.jp>
 <20210819091941.GB12883@lst.de>
 <1668a287-091b-4a4b-01c9-e0fa8740ce9d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668a287-091b-4a4b-01c9-e0fa8740ce9d@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 19, 2021 at 11:23:36PM +0900, Tetsuo Handa wrote:
> You need to also read Documentation/process/stable-kernel-rules.rst .
> 
>  - It must be obviously correct and tested.
>  - It cannot be bigger than 100 lines, with context.
>  - It must fix only one thing.
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing).
> 
> Your series is far away from conforming to the stable kernel rules.

Again DO NOT WORRY ABOUT STABLE KERNELS when trying to fix a problem
correctly.  Fix it right, and then, if needed, we can worry about the
stable trees.

The first goal of the stable kernels is to NOT cause extra work for the
upstream kernel developers for those that do not want to care about
them.

thanks,

greg k-h
