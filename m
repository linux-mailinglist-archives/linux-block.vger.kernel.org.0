Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D583E0CCB
	for <lists+linux-block@lfdr.de>; Thu,  5 Aug 2021 05:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbhHEDfO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 Aug 2021 23:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235289AbhHEDfO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Aug 2021 23:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628134499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/YsxfPiWA5ObApU3UYwU0/LbMEU8wRvLgCeNX7HHL+M=;
        b=hukmmvewQ5h3/IrBdWmjS5euxMLtQ3/0aTJJ7H2E558WsR6GEeo5u15tN/efIYkdr3VYCB
        UiCiPshpDIdpgbwx8Qus1ei+2kvTK9hFM8ABMmjqjBWVbNl5neUx2z8nNYmQJnAzCvWdYG
        bkYwBlnQqTTpYLCGvk/VoBa8vR0awFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-bpo1ZxBdMTqOO3aei4ADQA-1; Wed, 04 Aug 2021 23:34:58 -0400
X-MC-Unique: bpo1ZxBdMTqOO3aei4ADQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26516800489;
        Thu,  5 Aug 2021 03:34:57 +0000 (UTC)
Received: from T590 (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6D4360BF4;
        Thu,  5 Aug 2021 03:34:50 +0000 (UTC)
Date:   Thu, 5 Aug 2021 11:35:00 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH] block: return ELEVATOR_DISCARD_MERGE if possible
Message-ID: <YQtcZHgE1cTl+KVz@T590>
References: <20210729034226.1591070-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729034226.1591070-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 29, 2021 at 11:42:26AM +0800, Ming Lei wrote:
> When merging one bio to request, if they are discard IO and the queue
> supports multi-range discard, we need to return ELEVATOR_DISCARD_MERGE
> because both block core and related drivers(nvme, virtio-blk) doesn't
> handle mixed discard io merge(traditional IO merge together with
> discard merge) well.
> 
> Fix the issue by returning ELEVATOR_DISCARD_MERGE in this situation,
> so both blk-mq and drivers just need to handle multi-range discard.
> 
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hello Jens and Guys,

Ping...


Thanks,
Ming

