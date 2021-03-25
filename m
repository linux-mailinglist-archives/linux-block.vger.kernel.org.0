Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0519348689
	for <lists+linux-block@lfdr.de>; Thu, 25 Mar 2021 02:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235609AbhCYBqm (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Mar 2021 21:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46993 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235749AbhCYBqb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 21:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616636790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m+/Q96DtGZE6hWrtWdO8RjDxUqSr6STDrIbcIrWsIZ4=;
        b=DWx43lNNx/m3k+vk7pUpGBb9/boDDHAxSKMnZOen+lcIN9ODNrsbn9SK470VJpNnvtevEh
        xOFhHqoTClEkoV+YgX8IxzCBFzyHOyJ5Y9aip/ThjPGFtKoCBBPxewsFQUyGPZqEXjhBCN
        RQY5jE1KZJ2tLFfzfZqJPTtk3K7ZGqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-FA4rvCSUMeGhF7OIL5Vf4Q-1; Wed, 24 Mar 2021 21:46:26 -0400
X-MC-Unique: FA4rvCSUMeGhF7OIL5Vf4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 199841084C9B;
        Thu, 25 Mar 2021 01:46:25 +0000 (UTC)
Received: from T590 (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5912B5D9D0;
        Thu, 25 Mar 2021 01:46:18 +0000 (UTC)
Date:   Thu, 25 Mar 2021 09:46:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Gulam Mohamed <gulam.mohamed@oracle.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: Race condition in Kernel
Message-ID: <YFvrZUzmdLpj7E4F@T590>
References: <CO1PR10MB4563A6404AD789EEF93F995798639@CO1PR10MB4563.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR10MB4563A6404AD789EEF93F995798639@CO1PR10MB4563.namprd10.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 24, 2021 at 12:37:03PM +0000, Gulam Mohamed wrote:
> Hi All,
> 
> We are facing a stale link (of the device) issue during the iscsi-logout process if we use parted command just before the iscsi logout. Here are the details:
> 	 	 
> As part of iscsi logout, the partitions and the disk will be removed. The parted command, used to list the partitions, will open the disk in RW mode which results in systemd-udevd re-reading the partitions. This will trigger the rescan partitions which will also delete and re-add the partitions. So, both iscsi logout processing and the parted (through systemd-udevd) will be involved in add/delete of partitions. In our case, the following sequence of operations happened (the iscsi device is /dev/sdb with partition sdb1):
> 	
> 	1. sdb1 was removed by PARTED
> 	2. kworker, as part of iscsi logout, couldn't remove sdb1 as it was already removed by PARTED
> 	3. sdb1 was added by parted

After kworker is started for logout, I guess all IOs are supposed to be failed
at that time, so just wondering why 'sdb1' is still added by parted(systemd-udev)? 
ioctl(BLKRRPART) needs to read partition table for adding back partitions, if IOs
are failed by iscsi logout, I guess the issue can be avoided too?

-- 
Ming

