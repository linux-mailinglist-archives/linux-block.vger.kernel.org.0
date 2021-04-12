Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F7435C18F
	for <lists+linux-block@lfdr.de>; Mon, 12 Apr 2021 11:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbhDLJbb (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Apr 2021 05:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbhDLJac (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:30:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E206C061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 02:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2aAzB1P9A5WhEVEsk8iDfe7OruzcxZZzu6mu8vnD7aE=; b=Mj9tHLS9YKoZhZW4BPvCb7LrBz
        BFL2CuOTgtAnO5hnmoVCEFYc10FgqA2UEh+d+FD1L07RdmDrbRXuanA+sNPFFxzyY6ftRT+B/6TDa
        lZHRKwoCsxJWtuuzWhdbgnyb0/WMfjCQApv3+mMoJfIDpTVTfcYzyIGrnRK7Ssg6d0lBHhRpcCulE
        93JyGXApc1pvAD1Bvo15xIxOzXmCF3bh8bH31goFHmKEqQFuBLMYQbJJXe84lEwQRo7UL6Woz0iYv
        63kZL9mGa7ayn8HrxaGBNonrqdOlqDtpm176lxu+XgF2PEc0Cc4K4ECrnWMOnI0B6EqZ1fyy1Ubz9
        5uWzH3Bg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lVstL-00461J-2d; Mon, 12 Apr 2021 09:30:02 +0000
Date:   Mon, 12 Apr 2021 10:29:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 06/12] block/mq: extract one helper function polling
 hw queue
Message-ID: <20210412092959.GB972763@infradead.org>
References: <20210401021927.343727-1-ming.lei@redhat.com>
 <20210401021927.343727-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401021927.343727-7-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

s/one/a/

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
