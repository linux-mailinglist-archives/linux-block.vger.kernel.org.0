Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8224219399F
	for <lists+linux-block@lfdr.de>; Thu, 26 Mar 2020 08:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgCZH2B (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Mar 2020 03:28:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgCZH2B (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 03:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AkT8/91l+j+rVYMFjJ1Rzawa6WWiXPYVgzf8wiv5/pY=; b=V0vHn+A2ysHs311rJuV2ZZ01BL
        hNVkehijtTGJqy61Dr76fEA6gLsgx8uAylzZ+WqnQ6U82oIYmUveFpmQkXlzGKGC0T+dVN+neCXJB
        A8+VLWSztdHfwQdea7tNFqb35sQaR2JO+OScJ4Y9fTeIvikjbnoUrumYE//ZLp/yEQjYe8U+ZVOEL
        RxiZkQv6dhXH87bjC36LgjBUd6YKe+qz8IvpWBti4/TFvNJDg3fca9+eb3CGcbtcu6Uw6Gz+YJopB
        XJXyscrgMdbXwbeFEZCOlo2qSfWq9zwtryNWZFK3Et+XX2P0OZd4gIQJs6pjSsiv/zajDBWfyrd8t
        YVfQzceA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHMvo-0006z5-DI; Thu, 26 Mar 2020 07:28:00 +0000
Date:   Thu, 26 Mar 2020 00:28:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: all zones zone management operations
Message-ID: <20200326072800.GA21082@infradead.org>
References: <20200326043012.600187-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326043012.600187-1-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 26, 2020 at 01:30:12PM +0900, Damien Le Moal wrote:
> Similarly to the zone write pointer reset operation (REQ_OP_ZONE_RESET),
> the zone open, close and finish operations can operate on all zones of a
> ZBC or ZAC SMR disk by setting the all bit of the command. Compared to a
> loop issuing a request for every zone of the device, the device based
> processing of an all zone operation is several orders of magnitude
> faster.

What is the point?  None of these actually seem like remotely useful
operations.  Why would I ever want to open or finish all zones?
