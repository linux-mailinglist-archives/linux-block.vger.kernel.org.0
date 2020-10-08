Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB055287575
	for <lists+linux-block@lfdr.de>; Thu,  8 Oct 2020 15:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgJHNwg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 8 Oct 2020 09:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729112AbgJHNwg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 09:52:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322ADC061755
        for <linux-block@vger.kernel.org>; Thu,  8 Oct 2020 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=jHJQK0HoiueS2P10uDZf8+U4qt
        p6K4x1qEulyHUAyJzs9rkwp7ZXy5azXvU6hosnWAvLjsfvpZwouQxVfsQWPWjFke3eK37jAbUr/e9
        SCaLtwxQvWyCDk275wjg52EOvyOM/WykjTcMSbKrGMlJdMzG0H5nXGzYK5utID1RPLxQb/OW/OlkR
        WT0271b8TeXgJP/D4qZLrD2oemfEq/98IDOsaay+Uex5U/oPJ+Fkg5BD+FwQgJMplKrAhhex7n09x
        ZDn2w5lXKbfg6HRgL5o2/Fa97zHytC4nTOj0g/zJkL+wzLE7dDFaY+BPNcFUCsWkDRU9srYmQOJFe
        qL9m3QDQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQWLQ-0002EH-SA; Thu, 08 Oct 2020 13:52:32 +0000
Date:   Thu, 8 Oct 2020 14:52:32 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] block: ratelimit handle_bad_sector() message
Message-ID: <20201008135232.GA8550@infradead.org>
References: <20201008064049.GA29599@infradead.org>
 <20201008133723.5311-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008133723.5311-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
