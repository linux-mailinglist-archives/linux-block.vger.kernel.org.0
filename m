Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BAFD7098
	for <lists+linux-block@lfdr.de>; Tue, 15 Oct 2019 09:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbfJOH5L (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Oct 2019 03:57:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37022 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfJOH5L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 03:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xjjxIrYZaE/ylttEZFV9FHzMxkgoLEiwDVE0qZzLRWI=; b=Ox5HBE8k7PtsJ2QHikwjXyBe7
        3WdJL37sXCaZcqmGm+9H5JgOKI7Au9P+ify9jW9GkTlwoY5wFQFP3CUZjLX+DeKXzpLvZhrmFPqiz
        lH6dMRfrp5HhZhOhS01TTetDiLwBHr7+Gpr6UPcquWqrm9jr2iYj21O9OaTdPozDjiCL94cZWtE/q
        9wQatoZlqt5z2agGDkAAFOyggVSJeXGVeh17pffPn5NNtbblWD3ir3w3aPcTYpMhI4RNTkfKpsqfY
        jk3wXV5sPVU8yPkgRE4TmpFqNdWJeYxLnVKbbBxK0PvbitlHUIiNP9Ke0uFWK7sJXVmkOaCtXplx7
        PKJsEUizg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKHhf-0000jv-3o; Tue, 15 Oct 2019 07:57:11 +0000
Date:   Tue, 15 Oct 2019 00:57:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Revanth Rajashekar <revanth.rajashekar@intel.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH] nvme: resync include/linux/nvme.h with nvmecli
Message-ID: <20191015075711.GB32307@infradead.org>
References: <20191014171607.29162-1-revanth.rajashekar@intel.com>
 <20191015075642.GA32307@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015075642.GA32307@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 15, 2019 at 12:56:42AM -0700, Christoph Hellwig wrote:
> On Mon, Oct 14, 2019 at 11:16:07AM -0600, Revanth Rajashekar wrote:
> > Update enumerations and structures in include/linux/nvme.h
> > to resync with the nvmecli.
> > 
> > All the updates are mentioned in the ratified NVMe 1.4 spec
> > https://nvmexpress.org/wp-content/uploads/NVM-Express-1_4-2019.06.10-Ratified.pdf
> > 
> > Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Oh. but for this to be picked up please resend it to
linux-nvme@lists.infradead.org

