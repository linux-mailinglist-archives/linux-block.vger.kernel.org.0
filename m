Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA3F2B4BFC
	for <lists+linux-block@lfdr.de>; Mon, 16 Nov 2020 18:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgKPRBB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Nov 2020 12:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbgKPRBA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Nov 2020 12:01:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C893BC0613CF
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2020 09:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=gY+cxalkqNfiNm5UJt63S48rAO
        svckikK9OVW4IwFS8OfYZ1Q73RlSvUovDjPvHmb53/f1Ald986XKuikuOlSeFUl8wnl40fVue7dGb
        VM6ODYpoTgzAE9XtnKjtwvQSlwOedvoUgJ+dw4jDbowhAH1MdJbaFN5X2+ukbYEnuDwBNeafDlJUq
        m8qOEYgrEKuee44NkJvsA3ACKNUaPdeF1/ZwGfmzNYZ8oTHjgFcA7G4AuxyZLx39PJ1ylx6RZ/33J
        sZcN+vsr4SgcdfDngA0w8wN1TfFFi42wKlRbh80daci+tqFheImVspXU2kR0yEru9ppDUrzoMwfk7
        khdU5u0g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kehsB-0006aG-Ha; Mon, 16 Nov 2020 17:00:59 +0000
Date:   Mon, 16 Nov 2020 17:00:59 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 8/9] null_blk: Allow controlling max_hw_sectors limit
Message-ID: <20201116170059.GC24227@infradead.org>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
 <20201111130049.967902-9-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111130049.967902-9-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
