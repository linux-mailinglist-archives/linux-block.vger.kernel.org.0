Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4CC164A58
	for <lists+linux-block@lfdr.de>; Wed, 19 Feb 2020 17:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBSQ3O (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Feb 2020 11:29:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60632 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgBSQ3N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hn7DQDonTg5ZLUi5HWwm6QqNVXWAGzFqxUeSMPbsib0=; b=N62EAJ+kjp750uA4yJHdeNR/I8
        zJc8cNgFKUEu5i/A22F56Dhij9Ye0u/MLcfRWV6WBUytqGg2T1Y4baOx6qDM3ImpCgTiQA2aIiZ4v
        WuVEin/4bvbJhCIYN57/nuECR+Z1kSfs6QJH2k+AmX5QylOkPNQexmM/776bSkFdBI/Fxfs0zKeG6
        0RbXbQa5EyUHOJJSJu5E14n9FaZgbDRaSyGP5A2ebzDJZpLYuFvaMzOErxYbpmaKCjehWlJx87eTt
        EZzZkzjnYlyXe0g76/ApYUAicsuNjbQLSCAk4G4JBNkBCoUucRPcgO8nes3B+K0Q4Fl+aHDRh2GGa
        uHkgfbiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SDo-00034D-UJ; Wed, 19 Feb 2020 16:29:12 +0000
Date:   Wed, 19 Feb 2020 08:29:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     damien.lemoal@wdc.com, axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH V2 0/3] null_blk: add tracnepoints for zoned mode
Message-ID: <20200219162912.GC10644@infradead.org>
References: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218172840.4097-1-chaitanya.kulkarni@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

s/tracnepoints/tracepoints/ ?
