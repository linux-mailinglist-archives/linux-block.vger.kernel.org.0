Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C5936EBDE
	for <lists+linux-block@lfdr.de>; Thu, 29 Apr 2021 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240296AbhD2ODv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 29 Apr 2021 10:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240233AbhD2ODt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 10:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619704982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11yntnxyR0PzuU+XJCiT0yhoGblbyngm3zbXqal57SE=;
        b=Jm6dqXI6YKv1j4inT6BqDj14fJn8uya5yLhnLuameuOhdDGfWVMK+bmlg97yHrVpSNLeyz
        BZWE1HU2E3nxTxOsEjTtj+HbQRPT4/UuXMo5/gYf8iE+7ER1KHcHpvklVB4fE6Qt7wBzQB
        KFjP0RDXOqjZTGyHaE+lG3aZefdG4LQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-x_iqOMbvOE-R4qVsWHcruA-1; Thu, 29 Apr 2021 10:03:00 -0400
X-MC-Unique: x_iqOMbvOE-R4qVsWHcruA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58D83107AD91;
        Thu, 29 Apr 2021 14:02:58 +0000 (UTC)
Received: from redhat (ovpn-118-247.phx2.redhat.com [10.3.118.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2516C679FF;
        Thu, 29 Apr 2021 14:02:56 +0000 (UTC)
Date:   Thu, 29 Apr 2021 10:02:55 -0400
From:   David Jeffery <djeffery@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Khazhy Kumykov <khazhy@google.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V4 3/4] blk-mq: clear stale request in tags->rq[] before
 freeing one request pool
Message-ID: <20210429140057.GA43343@redhat>
References: <20210429023458.3044317-1-ming.lei@redhat.com>
 <20210429023458.3044317-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429023458.3044317-4-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 29, 2021 at 10:34:57AM +0800, Ming Lei wrote:
> 
> refcount_inc_not_zero() in bt_tags_iter() still may read one freed
> request.
> 
> Fix the issue by the following approach:
> 
> 1) hold a per-tags spinlock when reading ->rqs[tag] and calling
> refcount_inc_not_zero in bt_tags_iter()
> 
> 2) clearing stale request referred via ->rqs[tag] before freeing
> request pool, the per-tags spinlock is held for clearing stale
> ->rq[tag]
> 
> So after we cleared stale requests, bt_tags_iter() won't observe
> freed request any more, also the clearing will wait for pending
> request reference.
> 
> The idea of clearing ->rqs[] is borrowed from John Garry's previous
> patch and one recent David's patch.
 
With the flush request handled in a separate patch, this looks good to me.

Reviewed-by: David Jeffery <djeffery@redhat.com>

