Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C71D25D61D
	for <lists+linux-block@lfdr.de>; Fri,  4 Sep 2020 12:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgIDKZ5 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 4 Sep 2020 06:25:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:39028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbgIDKXh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Sep 2020 06:23:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8544B7E3;
        Fri,  4 Sep 2020 10:23:36 +0000 (UTC)
Subject: Re: [PATCH 10/19] brd: use __register_blkdev to allocate devices on
 demand
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
References: <20200903080119.441674-1-hch@lst.de>
 <20200903080119.441674-11-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <7a14a59e-9ff2-73e3-6fb6-b19e1d472699@suse.de>
Date:   Fri, 4 Sep 2020 12:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200903080119.441674-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/20 10:01 AM, Christoph Hellwig wrote:
> Use the simpler mechanism attached to major_name to allocate a brd device
> when a currently unregistered minor is accessed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/block/brd.c | 39 +++++++++++----------------------------
>   1 file changed, 11 insertions(+), 28 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
