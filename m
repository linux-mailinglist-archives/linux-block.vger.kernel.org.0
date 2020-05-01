Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46931C19AA
	for <lists+linux-block@lfdr.de>; Fri,  1 May 2020 17:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgEAPgB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 1 May 2020 11:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbgEAPgA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 May 2020 11:36:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95FEC061A0C;
        Fri,  1 May 2020 08:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HsrfycC9F4gKazlY38RjqD/p4LVNAXXHW9C6abpgCD4=; b=gUq93X7ub8035oC97Ilk3m/Oje
        QO28Jw9UtfshJEL1j7z4GkCeUtAeGUe3nwbyYz7rdav/6UzfN4WriB/Chnc4DtD4D+oB52TvqrdP5
        5bIm8qgpd5B1H5ITfQl61+enY8j4KQ1xvx+ergx5pObGzDMU5b+ctje6L1tlDCCdXxd8f/VvasYAR
        VHDzsN0kXZ6dA3Codnydpt0fyWNQWzi0A4YWRM9dJ/Hj4/eTucDnmHfIR+9Te05t3cNLIsMXj/hne
        CGF3jp1gz2X8UQW74diVJJsxM9wTOTCPvSlLpQ0HpAraVWUHiaXRcGd3IxEMYfHRm+SRyRPkRslfu
        O5t1EV5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUXho-0006lH-Gd; Fri, 01 May 2020 15:36:00 +0000
Date:   Fri, 1 May 2020 08:36:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-block@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] floppy: add FD_AUTODETECT_SIZE define for struct
 floppy_drive_params
Message-ID: <20200501153600.GC12469@infradead.org>
References: <20200501134416.72248-1-efremov@linux.com>
 <20200501134416.72248-3-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501134416.72248-3-efremov@linux.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 01, 2020 at 04:44:14PM +0300, Denis Efremov wrote:
> Use FD_AUTODETECT_SIZE for autodetect buffer size in struct
> floppy_drive_params instead of a magic number.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
