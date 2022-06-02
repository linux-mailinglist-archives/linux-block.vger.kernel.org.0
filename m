Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2FB53B4AB
	for <lists+linux-block@lfdr.de>; Thu,  2 Jun 2022 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiFBH7H (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 Jun 2022 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiFBH7G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2022 03:59:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB08D6D
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 00:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W1uMnlISx2BH2FDmsFQI7OUvNZMpq5HDzkPCAmnV1xo=; b=hgOESu1S1NiHjQP172JS7Rjyst
        qQjdD2v6avPQOwGNhAnyG9zR9DKjg/OfMVrw/uu3eHNUKx/xDkWDp0pW3bFPobPAGCdrNtg+qsfcb
        +2JnVJdGE/3hUXTSN7Pti/fRTcLupCsAndhGZSgJkh8e2UDIuBgfF9Mu3rGwH8Y2dYQIXiSMZVtiV
        CiB2BtVu+pjhKoz9AeZQfuJWkoplGhQSSghsUdsYFCGCY2orJ9RYIbpnYnwgX2n5l6QGiYtcu2hvR
        R7kZwoLqQAsrBXv1ieZRQ7Rbj6MTNMtYL77R0BywHK872dapCh1/1yfF83to1zy/Vye/kA7f7TPQM
        8I5seURA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwfjT-0027BC-Mf; Thu, 02 Jun 2022 07:59:03 +0000
Date:   Thu, 2 Jun 2022 00:59:03 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <Yphtx84vMpkX+bsb@infradead.org>
References: <YphKZBtmtKFRNIPL@infradead.org>
 <2ae24afc-6474-60f3-ece0-fb5a1d19f8c5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae24afc-6474-60f3-ece0-fb5a1d19f8c5@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 02, 2022 at 01:49:09AM -0600, Jens Axboe wrote:
> On 6/1/22 11:28 PM, Christoph Hellwig wrote:
> > The following changes since commit a1a2d8f0162b27e85e7ce0ae6a35c96a490e0559:
> > 
> >   bcache: avoid unnecessary soft lockup in kworker update_writeback_rate() (2022-05-28 06:48:26 -0600)
> > 
> > are available in the Git repository at:
> > 
> >   ssh://git.infradead.org/var/lib/git/nvme.git tags/nvme-5.19-2022-06-02
> 
> Eh, I can't pull from that... I used the usual git url with this tag.

Sorry, that was my push url.  The external facing one is:

git://git.infradead.org/nvme.git tags/nvme-5.19-2022-06-02
