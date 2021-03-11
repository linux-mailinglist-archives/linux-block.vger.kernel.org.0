Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244C9336DB4
	for <lists+linux-block@lfdr.de>; Thu, 11 Mar 2021 09:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhCKIUz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 11 Mar 2021 03:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhCKIUp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 03:20:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97619C061574
        for <linux-block@vger.kernel.org>; Thu, 11 Mar 2021 00:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=PLJWqp3pbH0QOtOdoASzQztiwe
        yVhEzV6v9HMr9yjdOz6NJAheNpQN9VYBVe3P25xvLvl/IQ7rc/vU0J8wqo4Q1BA0UJVMf/nY8KLNZ
        xH3Su1OyilljfmMqX92WG5UOSTak6Dn8ZTTeRz9h8mGmWKuukWOpX42az3uvGy3K+tC59oEabqHD0
        b+dQPwUiz9ybdILLd4qY7kYhjbhGAaNUpXxeGtBQseD8k0tVYChX2Y4tl3iDRxID6b824qIBCqLwx
        Vl98zAXZrA0U8cZK1T+HYG1YG3/yctLTuBcxaSCMwoMXwKh7BDNh1ethVYKDK/jjUmOSy7ogqe+t/
        tySDR2JQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKGYO-006nu6-Cm; Thu, 11 Mar 2021 08:20:21 +0000
Date:   Thu, 11 Mar 2021 08:20:20 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Jan Kara <jack@suse.cz>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3] block: Discard page cache of zone reset target range
Message-ID: <20210311082020.GA1621202@infradead.org>
References: <20210311072546.678999-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311072546.678999-1-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
