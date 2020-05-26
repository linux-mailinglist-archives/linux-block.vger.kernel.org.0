Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A171D7128
	for <lists+linux-block@lfdr.de>; Mon, 18 May 2020 08:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgERGjl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 May 2020 02:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERGjl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 May 2020 02:39:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2364AC061A0C
        for <linux-block@vger.kernel.org>; Sun, 17 May 2020 23:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=1A3SJ8SS1E9V1bpRYcDrZJvi1phPLboKo62mMQpuzWw=; b=ZSsHC1JG75dDijNYXebmT95Jz/
        9OZYiqUCXnXwnZR2q2Os7zGkL1mGggbRaKjtQsvLxGmJhLK0PxDVAA3Gz5UmXEM95pix+B8iLJrPY
        2W/Hl/J+cqTwA0nIii2julACOMpZ4M6UQ70GDBk5YBeEZD7H/QNj3UEkBh9D1OLj/Whx0ZbMAJaaj
        bdKUPPJZHDmbvfdWBUh+G2pZKlK3Wag/WtconTTi1U+x4ww6TPBzzziE+YpnNiC1cQk9gYlxMYlDu
        /UNeLHL0/QjAp6+Fr1mc5u006kFDCSQLoYUk5crkJtu5lZfk0fCd2cOwDjqJnfMsXQAQL90j4+lck
        HPV0L2hw==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaZR5-0001wn-V8; Mon, 18 May 2020 06:39:40 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: blk-mq: improvement CPU hotplug (simplified version) v2
Date:   Mon, 18 May 2020 08:39:28 +0200
Message-Id: <20200518063937.757218-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
o:      Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series ensures I/O is quiesced before a cpu and thus the managed
interrupt handler is shut down.

This patchset tries to address the issue by the following approach:

 - before the last cpu in hctx->cpumask is going to offline, mark this
   hctx as inactive

 - disable preempt during allocating tag for request, and after tag is
   allocated, check if this hctx is inactive. If yes, give up the
   allocation and try remote allocation from online CPUs

 - before hctx becomes inactive, drain all allocated requests on this
   hctx

The guts of the changes are from Ming Lei, I just did a bunch of prep
cleanups so that they can fit in more nicely.  The series also depends
on my "avoid a few q_usage_counter roundtrips v3" series.

Thanks John Garry for running lots of tests on arm64 with this previous
version patches and co-working on investigating all kinds of issues.

A git tree is available here:

    git://git.infradead.org/users/hch/block.git blk-mq-hotplug

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/blk-mq-hotplug
