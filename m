Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EAD40DA5D
	for <lists+linux-block@lfdr.de>; Thu, 16 Sep 2021 14:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbhIPMyT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Sep 2021 08:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38396 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239623AbhIPMyT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Sep 2021 08:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631796778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H8J3fppm6pGsClKVQLZLoovJbj+NoBnYknLOjFM8iOM=;
        b=HzjPtlu/X8RFs6ECE0oU9rwu1GvJslGYgYCYsGaLJ8nIfIW+KteNcbfNelSrncrAzBJ5tX
        dPAHCd2Ztmd8WqUxVvFT+5mzE1NGfOuTULrSPd0Q1EMlsrQFa5QFR5JJWFNkIsO/dF3cgL
        GaMJ0J2nM5JYr3jpe7BLVcC+dyUcQuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-vxaAx6DkOvyY7YFkM6E1zQ-1; Thu, 16 Sep 2021 08:52:57 -0400
X-MC-Unique: vxaAx6DkOvyY7YFkM6E1zQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0913D10B744E;
        Thu, 16 Sep 2021 12:52:56 +0000 (UTC)
Received: from T590 (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DC9D5D9C6;
        Thu, 16 Sep 2021 12:52:51 +0000 (UTC)
Date:   Thu, 16 Sep 2021 20:53:04 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@infradead.org,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [patch v8 6/7] nbd: partition nbd_read_stat() into
 nbd_read_reply() and nbd_handle_reply()
Message-ID: <YUM+MOErUpN3bgOT@T590>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
 <20210916093350.1410403-7-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916093350.1410403-7-yukuai3@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 16, 2021 at 05:33:49PM +0800, Yu Kuai wrote:
> Prepare to fix uaf in nbd_read_stat(), no functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

