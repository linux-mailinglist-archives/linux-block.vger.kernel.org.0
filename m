Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3663CD179
	for <lists+linux-block@lfdr.de>; Mon, 19 Jul 2021 12:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhGSJVg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Jul 2021 05:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhGSJVg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 05:21:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E9C061574;
        Mon, 19 Jul 2021 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YVs2GIIi3Paq5oNd8Q8z9Lu8YkdoWQ/5Ixo+pWJmJiQ=; b=jol4tTxjmOGqVYhMczY9/NFA5c
        i5fmx7UIJP/zxc1Ydp+fTvSrToHEpY+cPQoRzdQHUTH7UaXR4w8Q5jumijeaO4cbIDyC11zFZfnQ8
        WHq+6AxSOlbzXIhq4m1k3gBg5NQSH/PLy8ThU+ZtQrcYCZ87aWRlFCPXARjHxqGU3BjNrxKFxNGQH
        B8S5/JR34FpYgs19J4Wp5t1JS8EMNxFEj8gfsprHN1TGn4qeiV9+ZUPa6KtWfUaatM7hkm3eO6t9P
        3nJtaovRwxY72UvTPBXlWwianC0bqPPlWpcX0qARziiQiO8vraoZRKVmAMNMPDcYXJbsqU6Vnzdeo
        prPPgptQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m5Q4i-006j9y-35; Mon, 19 Jul 2021 10:00:57 +0000
Date:   Mon, 19 Jul 2021 11:00:36 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/6] block: add flag for add_disk() completion notation
Message-ID: <YPVNRLgBtUOb1d17@infradead.org>
References: <20210715202341.2016612-1-mcgrof@kernel.org>
 <20210715202341.2016612-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715202341.2016612-3-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  {
>  	might_sleep();
>  
> +	if (!blk_disk_registered(disk))
> +		return;
> +

Can't say I like this all that much.  Drivers should keep some
basic sanity for their unregister path, and while blk_disk_registered
can be useful, it's uses should be kept at a minimum.
