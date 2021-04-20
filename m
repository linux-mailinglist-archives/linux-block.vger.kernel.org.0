Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55248365D8F
	for <lists+linux-block@lfdr.de>; Tue, 20 Apr 2021 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhDTQly (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Apr 2021 12:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232879AbhDTQlx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 12:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618936882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MvM6oaWg7r5AvRTXlx0P39Yy1ui/9+szAD2FRD6gYK4=;
        b=fJZls2YzfTgNUj7zpDgj5Cj2L0bskQQPM9cL4/e1b5fcgtz/FtixC6hRr6Qg1sKr6c06d/
        Au79hkyW8PVJpcEcPWdnbzZTASlT3xgtSeu7R6M9dP/olkoI00Tii8O1d3eojoULRlWl1z
        aknDlyC0c4uhygoksjsfbtPCC8qYTVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-MnZj6cj8MVmVEaxWH4DIKQ-1; Tue, 20 Apr 2021 12:41:18 -0400
X-MC-Unique: MnZj6cj8MVmVEaxWH4DIKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEF3E80BCA6;
        Tue, 20 Apr 2021 16:41:16 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-244.ams2.redhat.com [10.36.113.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D43195D9C0;
        Tue, 20 Apr 2021 16:41:08 +0000 (UTC)
Date:   Tue, 20 Apr 2021 18:41:06 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, stefanha@redhat.com,
        pbonzini@redhat.com, Enrico Granata <egranata@google.com>
Subject: Re: [PATCH v2] virtio_blk: Add support for lifetime feature
Message-ID: <20210420184106.3f9c5464.cohuck@redhat.com>
In-Reply-To: <20210420060807-mutt-send-email-mst@kernel.org>
References: <20210416194709.155497-1-egranata@google.com>
        <20210420070129.GA3534874@infradead.org>
        <20210420060807-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 20 Apr 2021 06:08:29 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Apr 20, 2021 at 08:01:29AM +0100, Christoph Hellwig wrote:
> > Just to despit my 2 cents again:  I think the way this is specified
> > in the virtio spec is actively harmful and we should not suport it in
> > Linux.
> > 
> > If others override me we at least need to require a detailed
> > documentation of these fields as the virto spec does not provide it.
> > 
> > Please also do not add pointless over 80 character lines, and follow
> > the one value per sysfs file rule.  
> 
> Enrico would you like to raise the issues with the virtio TC
> for resolution?
> 

FWIW, I've opened https://github.com/oasis-tcs/virtio-spec/issues/106
to track this.

