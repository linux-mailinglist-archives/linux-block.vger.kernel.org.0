Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEF0518B13A
	for <lists+linux-block@lfdr.de>; Thu, 19 Mar 2020 11:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCSKZk (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 19 Mar 2020 06:25:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgCSKZk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Mar 2020 06:25:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BIh9xpmYL6wBc1GMSHkXlW6IWHwV1fcXo2svbBsNWG8=; b=hgCqBFjt1RzDhJfs/PfmFkuTJq
        vrK4ZnXVbMISbps5hxJnRkddvOI4Pwh8ovjAIBs9DPq3+dQFQHdfSmlRbtSQZ2TjFmMkTqngYqUfG
        QkWshDrMAfwxIY42FFnyMrH5eZ4c3C/8fFhEuiao5oK6osENqSHCxC+Rp7uPu4zbCvY6zahoj5hhV
        S3I6oUVbJj6rJmSUG0+jdJqn3uT0VjS3qP3Kj+Ygw1Vd+HaxXTVi/sYiVntXO7R25JqXJgEiXFcGo
        Nhk5cNXGsu3BTmqTOtB/kkpz3dGa6wYzz3btR15/7b+BPY4dw9FceEkvd2iNgNADVZS/HiL15LUgK
        LTmb+kag==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEsMq-0006S7-2X; Thu, 19 Mar 2020 10:25:36 +0000
Date:   Thu, 19 Mar 2020 03:25:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     light.hsieh@mediatek.com
Cc:     ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuohong.wang@mediatek.com,
        stanley.chu@mediatek.com
Subject: Re: [PATCH v1 3/3] block: set partition read/write policy according
 to write-protection status
Message-ID: <20200319102536.GA16757@infradead.org>
References: <1583290274-5525-1-git-send-email-light.hsieh@mediatek.com>
 <1583290274-5525-4-git-send-email-light.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583290274-5525-4-git-send-email-light.hsieh@mediatek.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 04, 2020 at 10:51:14AM +0800, light.hsieh@mediatek.com wrote:
> From: Light Hsieh <light.hsieh@mediatek.com>
> 
> For storage device with write-protection support, e.g. eMMC, register
> check_disk_range_wp() in struct block_device_operations for checking
> write-protection status. When creating block device for a partition, set
> read/write policy according to result of check_disk_range_wp() operation
> (if registered).
> 
> Without this patch, ro attribute is not set for created block device of
> write-protected partition. User perform asynchronous buffered write to
> such partition won't get immediate error and therefore he won't be awared
> that write is not actually performed.
> With this patch, ro attribute is set for created block device of
> write-protected partition. User perform asynchronous buffered write to
> such partition will get immediate error and therefore he will be awared.

NAK.  This is complete BS.  Partitions are a complete software concepts
and idiotic features like a range read only should not interact with it
at all (and I urge all Linux users to never make use of such broken
features, so the less support we have for them, the better).
