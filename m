Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1A9243009
	for <lists+linux-block@lfdr.de>; Wed, 12 Aug 2020 22:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgHLU2j (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 12 Aug 2020 16:28:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52481 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726512AbgHLU2i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 16:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597264117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJXYJZa0+jqjrR60z7t4R8Jwh4xDRotz1b/w46Emeyo=;
        b=H8nCnKk2J7JNesKrVW3iMTLN4ZXF1IArnYVrBDD00u8AAGBszCZ0Wgt/GzLT5uGkgxGmVF
        AJWRkLATGILQCUi6GJoz7uDYwqYtwz95UEPJA5EOoucc0Ds6hhaIC9ICWVoaNFsNIOQjEd
        vRlzHaM5oEspqVKeqAfn582yMd1GKvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-N0dpFdX3Mkyf7NnFyJr_XA-1; Wed, 12 Aug 2020 16:28:33 -0400
X-MC-Unique: N0dpFdX3Mkyf7NnFyJr_XA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 427A181CAFA;
        Wed, 12 Aug 2020 20:28:32 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD15519D71;
        Wed, 12 Aug 2020 20:28:30 +0000 (UTC)
Date:   Wed, 12 Aug 2020 16:28:30 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chao Leng <lengchao@huawei.com>, axboe@fb.com, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org
Subject: Re: [PATCH 2/3] nvme-core: delete the dependency on blk status
Message-ID: <20200812202829.GA586@redhat.com>
References: <20200812081844.22224-1-lengchao@huawei.com>
 <20200812151035.GB29544@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812151035.GB29544@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12 2020 at 11:10am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Aug 12, 2020 at 04:18:44PM +0800, Chao Leng wrote:
> > nvme should not depend on blk status, just need check nvme status.
> > Just need do translating nvme status to blk status for returning error.
> 
> While this doesn't look wrong it also doesn't save us a single
> instruction and actually adds more lines of code.  Do you have a good
> reason for this change?

It certainly saves nvme_error_status(nvme_req(req)->status if
nvme_req_needs_retry().

