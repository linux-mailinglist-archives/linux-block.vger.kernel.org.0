Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36EB2194212
	for <lists+linux-block@lfdr.de>; Thu, 26 Mar 2020 15:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgCZOwy (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Mar 2020 10:52:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgCZOwy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 10:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nqEnebPIOi5SsqyCoU4xaoU1x1rSsF2tTFTUij9Ifa4=; b=bjwScgOJIAMEqY8jcdd2lfpuQP
        LplYlXmWmFAJh5lLSOSNIPIgAz4J44Rc/K0K1VLqsCo5HvGFvN0edUuQOOrge1sGMwMhY3TToSYox
        5WGTcRWPkglPPWTj4wl0JG31YU7Z4teKIRus8rfnl/hIucEKvNeSC3/j738iHJf0rdetC9YNxUZrL
        wQdruZZYWnAj1H6iG1MtMuevtrKAI+rRy1tEj1WxsrzLGbFqC+aCbSfXEgWb58kko+35h3Hvf/weu
        +OXbm4v5pTC7oAZGik1aBFh0D+sUOsoJO2JfbjeoO4HTzZ/FncT91mDDoeFr2z9Xl3xjRTzmB0YvS
        chbNmWsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHTsL-00051u-OY; Thu, 26 Mar 2020 14:52:53 +0000
Date:   Thu, 26 Mar 2020 07:52:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        kernel@collabora.com, Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH RESEND 1/2] loop: Report EOPNOTSUPP properly
Message-ID: <20200326145253.GA18623@infradead.org>
References: <20200317151111.25749-2-andrzej.p@collabora.com>
 <20200317165106.29282-1-andrzej.p@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317165106.29282-1-andrzej.p@collabora.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 17, 2020 at 05:51:06PM +0100, Andrzej Pietrasiewicz wrote:
> From: Evan Green <evgreen@chromium.org>
> 
> Properly plumb out EOPNOTSUPP from loop driver operations, which may
> get returned when for instance a discard operation is attempted but not
> supported by the underlying block device. Before this change, everything
> was reported in the log as an I/O error, which is scary and not
> helpful in debugging.

This really should be using errno_to_blk_status.
