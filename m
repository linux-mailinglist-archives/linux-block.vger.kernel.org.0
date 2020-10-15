Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96CF28EE1F
	for <lists+linux-block@lfdr.de>; Thu, 15 Oct 2020 10:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387428AbgJOIC7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 15 Oct 2020 04:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgJOIC6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 04:02:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6477EC061755;
        Thu, 15 Oct 2020 01:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a2qZql200AZN5N8nLwRfRT3TJyI5WyTogEl+yUVcMaU=; b=mMRHnNZTH9o/HtpUjP8YHNIQyp
        AsR7PsYskBsLyou/+zQT+n+HEg36cIqGJo4jK+hwKhZ6+up4QpErlS2U5uPhGAMXxmA3H11U0UNYb
        1zJkNa5i6EcfKih1iPRHJfuNEg9ub8J7V9cICfb3i3ze+7ssw6/V0nKuUGS7SOkzZef6WPMlrDx0p
        EDKti4gagCtiMFFd/3tPfO5iHN33GZmMVpj3tNBlQsID/rHbQeP7zzyp01dFUB3WMnNCXwxYlJDvg
        1PEKzLUSzj2WDjb+BWXqgZcS2of6pFNVLrq8IjyCFbSd7zYsuYq42W2SvUMAlTxq5kC6pxaKJDwDs
        1j6BdwiQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSyDu-0008AD-QZ; Thu, 15 Oct 2020 08:02:54 +0000
Date:   Thu, 15 Oct 2020 09:02:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nabeel M Mohamed <nmeeramohide@micron.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, smoyer@micron.com, gbecker@micron.com,
        plabat@micron.com, jgroves@micron.com
Subject: Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
Message-ID: <20201015080254.GA31136@infradead.org>
References: <20201012162736.65241-1-nmeeramohide@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012162736.65241-1-nmeeramohide@micron.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I don't think this belongs into the kernel.  It is a classic case for
infrastructure that should be built in userspace.  If anything is
missing to implement it in userspace with equivalent performance we
need to improve out interfaces, although io_uring should cover pretty
much everything you need.
