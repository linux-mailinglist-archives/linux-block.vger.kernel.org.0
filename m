Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBF44273B
	for <lists+linux-block@lfdr.de>; Tue,  2 Nov 2021 07:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhKBGsC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Nov 2021 02:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhKBGsC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 02:48:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CACC061714;
        Mon,  1 Nov 2021 23:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JWE7BET0u8LTWvjGcNRFXwqkxiDef23FxFVDC5VVOss=; b=eFeSahGTH6egNVMFfTxi2Q9+wi
        BMOptkk/L6UKXqlXQoYzqdHR9CgUcFWxA6ltg5UD8kDPGMt2/5WwxBJVI6A2UKnDacrHIEwIWjuFM
        HJUi8u8bncfDuxxfdx8NUp1gbw6SR1zGIYKJ4tUK6e1hgYxKr+r/7+B04zmMXGnJk2t8lfTXCrlKj
        ZIfPumhx05vlxragQo7ssc+e4PA/6lFUJxcI9Tno5ufz2BU8zcfVwbBoERVbOqgP9ogvnx9MYowjp
        R+Mgk5uH0SemcC0qZny17nsoqVM4lsFb//FHVjFHOOM/mOVl4wzD88gqSqbrYOY/5VEeKcCuELHKB
        FG/j5a4A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mhnXy-000gKl-Tf; Tue, 02 Nov 2021 06:45:26 +0000
Date:   Mon, 1 Nov 2021 23:45:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tadeusz Struk <tadeusz.struk@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: general protection fault in del_gendisk
Message-ID: <YYDehlqjWUKizzmB@infradead.org>
References: <7468db5d-55b4-07c9-628a-9a60419d9121@linaro.org>
 <2bf04f26-4e82-a822-90ce-4c28e2c0e407@linaro.org>
 <90d72173-edd8-79d9-b680-b1d47ab78150@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90d72173-edd8-79d9-b680-b1d47ab78150@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> People will take a look at it, but you sent it out on a Saturday right
> before a merge window, doing a 'ping' kind of followup on a Monday is
> way too soon.

Please retests on 5.16-rc1 once it is out.  Sorting out add_disk error
handling is one of the big changes in this merge window.  And no, it is
not easily backportable.
