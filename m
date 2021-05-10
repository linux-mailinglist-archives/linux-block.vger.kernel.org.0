Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C188377C03
	for <lists+linux-block@lfdr.de>; Mon, 10 May 2021 08:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhEJGBq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 10 May 2021 02:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhEJGBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 May 2021 02:01:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD347C061573;
        Sun,  9 May 2021 23:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=s5VgDRE3fntx+hoST52zTcYHXWHwJgCurEHpr1TYTlQ=; b=jBgYS/NDAOaMoAlc7Ob9bSlOQ/
        iXZ6ae+hLxfyQDJTI0yOegHx4Qgda5Kvz7hlmXDQuV9TB/LOtT8Be9rRrPYE+EY9+VzqmsvdivTIu
        GYhTuEaav8q72Cwq7vZjN6BE+4bXSxCSPdMEY+Za0LRQBoKhfoGtbWk92PBu/PhSZzaQLPPtt8I8+
        QvDRc4yYNKJIxG5uEhxq9DAyzKoN3LiECPSaFiXR7it2+MgdrfAeXNfAaW3MVrCggXHx2JeI0Nv7F
        EyKuQBoGStIdirijICyNRA8cj3pjBCXktkiCutCAZxIEbnFyDClOTNnBXQ/VCxS3l5a1YHzfcdKts
        UeEkyLoA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lfyxc-005kui-ME; Mon, 10 May 2021 06:00:14 +0000
Date:   Mon, 10 May 2021 07:00:08 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org, pawel.wiejacha@rtbhouse.com,
        Guoqing Jiang <jiangguoqing@kylinos.cn>
Subject: Re: [PATCH] md: don't account io stat for split bio
Message-ID: <YJjL6AQ+mMgzmIqM@infradead.org>
References: <20210508034815.123565-1-jgq516@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508034815.123565-1-jgq516@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 08, 2021 at 11:48:15AM +0800, Guoqing Jiang wrote:
> It looks like stack overflow happened for split bio, to fix this,
> let's keep split bio untouched in md_submit_bio.
> 
> As a side effect, we need to export bio_chain_endio.

Err, no.  The right answer is to not change ->bi_end_io of bios that
you do not own instead of using a horrible hack to skip accounting for
bios that have no more or less reason to be accounted than others bios.
