Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D180B10872
	for <lists+linux-block@lfdr.de>; Wed,  1 May 2019 15:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfEANsg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 May 2019 09:48:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfEANsg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 09:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UtHOeq7UKgkwJ5cmPkO6mA+wJVx0zp2ypCl6r53C874=; b=s9c8uTchNsADzr9NCHty54SmZ
        EhbjZ/+kbx3FvTSuTQM9OXhZZx14R98MBdwA3toWG366WTGOC5oL7vJsg/aXg63cwUhiaYsNLvBhj
        y3/+J2YEw/92Z/8qXN+u2ab25KOyxpuQRMdabxu01Po0ak96sAkXKJLJ//rTlVR6qx2b8bJ8qO26X
        AuIwPCdAwQSwW68isgzZhAzgNED74dCWMxWYYLsYZw14vwIKEqO94G3jxpvlxjyY6BRFu/c8aEIjx
        C8hBLhVDkZMS9NlMg0CApZhjiQNXYKoB1a3au90sACJ5zKU5m4sTxPJ8odECfxG18YOClczPQgwq7
        YrVXucZzw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLpb7-0006Mf-DW; Wed, 01 May 2019 13:48:33 +0000
Date:   Wed, 1 May 2019 06:48:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 2/3] block: sed-opal: ioctl for writing to shadow mbr
Message-ID: <20190501134833.GB24132@infradead.org>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1556666459-17948-3-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556666459-17948-3-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	if (!access_ok((void __user *)(uintptr_t)info->data, info->size))
> +		return -EFAULT;

Just let the copy_from_user itself return the error itself.

