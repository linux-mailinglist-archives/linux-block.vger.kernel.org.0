Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A73B58A2
	for <lists+linux-block@lfdr.de>; Mon, 28 Jun 2021 07:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhF1FiM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 28 Jun 2021 01:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhF1FiM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jun 2021 01:38:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27083C061574;
        Sun, 27 Jun 2021 22:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=SzGYIx1uuR4K/qFpmj0UQsEQdo
        gXuoVlo4hV1Zpj5i0VXEb/fAPKtuEhlttx3MPNoDxV5FM2CGsNc2qp4IbaEYrZ04dJkJtcg7V6NZY
        X+MBMhH1dFG3n+r2yM445POE6YTi4ZDlBIhvj6/4wONRprPG25/F/QTE/MJ9mEG6m30FN+SJpWseF
        Qa67F+q5y0hSa+Fi8CSM2zTh7GBTTtOTb100g3QDBw4TD3D7QICLPglSf7PEOFM1o49MrQ2mI3TER
        fo3R34w4EVLWL57iNG6WDKtDwJdRsKG8oHrfk+GIvf4ux36kEeqQszp3yDY9FRUURfAjzT2Nt+grS
        sp9dsksQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxjuc-002cMV-RN; Mon, 28 Jun 2021 05:34:38 +0000
Date:   Mon, 28 Jun 2021 06:34:26 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] loop: fix setting arbitrarily large block size
Message-ID: <YNlfYjqpZCZH7yO2@infradead.org>
References: <20210623050933.140572-1-chouhan.shreyansh630@gmail.com>
 <20210626082406.348821-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626082406.348821-1-chouhan.shreyansh630@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
