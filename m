Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5F93EF8F1
	for <lists+linux-block@lfdr.de>; Wed, 18 Aug 2021 05:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhHRD4w (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 17 Aug 2021 23:56:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45951 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236392AbhHRD4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Aug 2021 23:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629258977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZQHYMXJcgCjoNKEEL5x5yhztahB+htLkxP7MwFCB/4Y=;
        b=clLXcnRjJJepHpCyxmwm2WeoTHqHqxBYVsvNR4uSit/C5StH3BdxD2213LSNi39053dv4l
        t/eZPzqjXC5SOHUuOnefMiEBkIkToDa2Ip/Sw4HCOpwjN/qEClgsGKajL9+p5OiMks7eDb
        hzn3tIbwav0IcGVKfTtJQQJUO+uBhec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-_i89I_Y3OXKRiu44R7to6A-1; Tue, 17 Aug 2021 23:56:14 -0400
X-MC-Unique: _i89I_Y3OXKRiu44R7to6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C8D0801AC0;
        Wed, 18 Aug 2021 03:56:12 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E26E19D9D;
        Wed, 18 Aug 2021 03:56:03 +0000 (UTC)
Date:   Wed, 18 Aug 2021 11:55:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kashyap.desai@broadcom.com,
        hare@suse.de
Subject: Re: [PATCH v2 05/11] blk-mq-sched: Rename blk_mq_sched_alloc_{tags
 -> map_and_request}()
Message-ID: <YRyEzcoou9khUD7S@T590>
References: <1628519378-211232-1-git-send-email-john.garry@huawei.com>
 <1628519378-211232-6-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628519378-211232-6-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 09, 2021 at 10:29:32PM +0800, John Garry wrote:
> Function blk_mq_sched_alloc_tags() does same as
> __blk_mq_alloc_map_and_request(), so give a similar name to be consistent.
> 
> Similarly rename label err_free_tags -> err_free_map_and_request.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

