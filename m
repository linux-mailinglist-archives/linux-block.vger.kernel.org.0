Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220AED7093
	for <lists+linux-block@lfdr.de>; Tue, 15 Oct 2019 09:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfJOH4n (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Oct 2019 03:56:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfJOH4n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 03:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ymW8PLy6AlYr0rfTky0vwvgncQbZOo1mnh2EotD8LFg=; b=EGq+u+kuffUZT4VyAEpYrHKwK
        7Cih3XXcBVIP9XY10QKM+SiZhj6FtrySk7jF0MauCSH1eD3vdAMwN+AzzXadEcb3mthqM5nekAKEB
        U0uWV0cq7EXV7kgDUvofuCzKpJ5CFybyFMhIvONda5fIC53OXx6Vg0kKef+4k0DpDYbxIkTN/ewgP
        Z0vyFvvQlaFGC0RBOBEYqn3BQM6JAUZiRH4rHhKEw1/fqVqlhkqY40KGEBO6mXP2glL/hb54P6w6v
        X6+scekiMrw4LJjHYHOSOBFj20JXdwgpGG5nUzy4MTSuLCMx+2fyZb1dBC6XGPoH/Y2lVVRFj1fjW
        BZuu6Wt+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKHhC-0000UJ-HJ; Tue, 15 Oct 2019 07:56:42 +0000
Date:   Tue, 15 Oct 2019 00:56:42 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme: resync include/linux/nvme.h with nvmecli
Message-ID: <20191015075642.GA32307@infradead.org>
References: <20191014171607.29162-1-revanth.rajashekar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014171607.29162-1-revanth.rajashekar@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 14, 2019 at 11:16:07AM -0600, Revanth Rajashekar wrote:
> Update enumerations and structures in include/linux/nvme.h
> to resync with the nvmecli.
> 
> All the updates are mentioned in the ratified NVMe 1.4 spec
> https://nvmexpress.org/wp-content/uploads/NVM-Express-1_4-2019.06.10-Ratified.pdf
> 
> Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
