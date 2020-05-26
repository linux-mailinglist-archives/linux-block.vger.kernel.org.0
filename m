Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED8D1D13BE
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 15:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgEMNBF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 09:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbgEMNBC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 09:01:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD8EC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 06:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eXK4B2evJjlz74akxDgNiVcYQRD+IEdhbQnleT+7YKo=; b=u5dtHE2bueorptwDS8JD9VtxxD
        XaKGVPXDe6cOEXJ1Gw1OSwi2QHrNtaD8fqBP8dR1wp/sMMaGDFVyNQQA01HdJZETEoGyi9XmB8W5u
        8ltbjlz05PuP083WBQ1mV3aa1IWJtG+pEg986d1H+zvVHnIi8aoBVQ2acnpNzklSDvGVajaYtuqWa
        dy246yJhcO8F1Xluvv24MpDLO+rZO5Fo73johvqhLRYsbk/S2UDs1eHYYAMm+iPcDuA13FGSo07UL
        aeRJmJ0VWl5wo6cPszT4q5qVkuUbVt112UZovaWDhaNc7CQAXnhGzszROgERD3nirpiHMg3YAJPbl
        qnaYEKsg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYr0O-00085R-Lb; Wed, 13 May 2020 13:01:00 +0000
Date:   Wed, 13 May 2020 06:01:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 6/9] blk-mq: move code for handling partial dispatch into
 one helper
Message-ID: <20200513130100.GH23958@infradead.org>
References: <20200513095443.2038859-1-ming.lei@redhat.com>
 <20200513095443.2038859-7-ming.lei@redhat.com>
 <20200513125656.GF23958@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513125656.GF23958@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Btw, with the many arguments an more beeing added later I'm not sure
anymore if this is really worth a separate function or just if goto
label at the end of blk_mq_dispatch_rq_list that can be jumped to,
and which has the same amount of indentation is the better idea.
