Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F881F998F
	for <lists+linux-block@lfdr.de>; Mon, 15 Jun 2020 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgFOOEn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 15 Jun 2020 10:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOOEm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 10:04:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5DC061A0E
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XtGeaBtMX/ztqdH5KFEu53icvtgYGE1tc2pwEjxoUbI=; b=hy5K8bmwude5lS3uW0K38X7viU
        d40htnMkekQ/ECAetUnj7tIM2CmbV1XYSmqgdG8LX2xinr/32d4XN374o7TaDfzVfj1KWlDo9Lo82
        42l6iXtlyXVATHe4jQ2WxMa0IHraMc2SSwVlTSdCP5jahmK56N5AoDCXzy5Z5oHx069SvpYb+nrSQ
        uT5Lk4tz+cHrMik4Q65VsdJJ2dZTSlOHA76Bl1hkVcjvkqFIQklDfvbnJUP3jmq1GmklZJUgX5OlV
        C4bBrUPUTJ5LkFAYo98xFShxAryFyygvRqjBxc6k88V6B+XSbnw0DNAgjBfA8MffKhzpUnbHLo1f2
        JvW5LBKA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkpj4-00068g-Jq; Mon, 15 Jun 2020 14:04:38 +0000
Date:   Mon, 15 Jun 2020 07:04:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-block@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH v2] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Message-ID: <20200615140438.GA21927@infradead.org>
References: <20200611013326.218542-1-harshadshirwadkar@gmail.com>
 <20200615115236.GA28124@infradead.org>
 <904b17e6-3ac6-8474-d6e5-32ada0dc2d40@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <904b17e6-3ac6-8474-d6e5-32ada0dc2d40@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 15, 2020 at 07:01:00AM -0700, Bart Van Assche wrote:
> On 2020-06-15 04:52, Christoph Hellwig wrote:
> > I don't think the configurability makes any sense.  We need to put
> > a hard upper cap on, preferably one that doesn't break widely used
> > userspace.  Just pick a reasonable large value to get started.
> 
> Hi Christoph,
> 
> Something that has not been mentioned in the patch description is that
> this patch addresses an issue that was discovered by syzbot. Do you
> agree that the following changes are useful on top of a hard upper limit
> for the blktrace buffer and that these changes will address more
> potential syzbot issues?
> - Use __GFP_ACCOUNT in the relay_open() call that allocates blktrace
> buffers such that the memory allocation is accounted to a process and
> such that the OOM killer becomes aware of blktrace buffer allocations.

Sounds ok. 

> - Making blkdev_close(), raw_release() and sg_release() shut down
> tracing in case the BLKTRACETEARDOWN ioctl has not been invoked. That
> will cause the blktrace buffers to be freed when e.g. the process that
> owns these buffers is killed.

While this sounds useful I think it might very well break existing
use cases.
