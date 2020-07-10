Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C797E21B284
	for <lists+linux-block@lfdr.de>; Fri, 10 Jul 2020 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgGJJpZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 10 Jul 2020 05:45:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29236 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726288AbgGJJpZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Jul 2020 05:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594374324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V2oQLW3KOeggHHc9UOXtDxcy6HvNVRrlvL+G0QFeyOo=;
        b=TP2ipDHrS/QfKpcJVMe+X4OecmI6sTulfeQxYach0wAlAt/X2MBCxIhADUd9YYJP9vPhRq
        BxX/MnJkIyVnQenD4JavFD5lrc0o889kBWosrzeZQKhjPUziqYiw7R7UvDiX1jdulzpZws
        dZjWtepr/3juhzoNeWAfqE1nebcVFyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-xI1vK4UqNwme6f-nM_E2mw-1; Fri, 10 Jul 2020 05:45:19 -0400
X-MC-Unique: xI1vK4UqNwme6f-nM_E2mw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40D591080;
        Fri, 10 Jul 2020 09:45:17 +0000 (UTC)
Received: from T590 (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 553527EF85;
        Fri, 10 Jul 2020 09:45:10 +0000 (UTC)
Date:   Fri, 10 Jul 2020 17:45:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: Remove unnecessary local variable
Message-ID: <20200710094506.GA3417252@T590>
References: <37baa5f3d47675b782652c85acf303662368e99f.1593846844.git.baolin.wang7@gmail.com>
 <20200710082210.GA29262@VM20190228-100.tbsite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710082210.GA29262@VM20190228-100.tbsite.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 10, 2020 at 04:22:10PM +0800, Baolin Wang wrote:
> Hi,
> 
> On Sat, Jul 04, 2020 at 03:26:14PM +0800, Baolin Wang wrote:
> > Remove unnecessary local variable 'ret' in blk_mq_dispatch_hctx_list().
> >
> 
> A gentle ping?

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

