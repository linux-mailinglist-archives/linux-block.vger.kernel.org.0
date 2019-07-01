Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27EAC371B2
	for <lists+linux-block@lfdr.de>; Thu,  6 Jun 2019 12:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfFFK3J (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 6 Jun 2019 06:29:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFFK3I (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jun 2019 06:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2siKY3UBgqDpv2BNknZNkEosV+IvK1Ph0bM3iXvRDSs=; b=NQJGeTfsRcMJROhilhgoXRraP
        hk3j9K5l30nnlqUKHrCyUzvXIoh1Rz5aryRJUVyT8nopMyQKUho0J8/4ivOsu07hGQ2KxqZ22GpPi
        3meva9wCFqsrXnEuwSYevTdpDIKGbXZXf8C/oG1aSAMCfcTLPYqLFXc8JKsOayknSMR2Vi3CCWh7R
        YLcGhgousUOCR6OjX5m5TaaYPm7lSkoeJrLEw/bjs9dO+2EbDCTLy6GO2JdiXdEBqD7qJGUiyCLKU
        LxO9mnVUGB1HoCM0t7Xyn7R0s76I6JSMjXnwdZ7215hd7VUk8Qr3VpYZoZCk7tRcYESnfKNvJhSGw
        x8Ar8yODQ==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYpdr-0008Pr-4f; Thu, 06 Jun 2019 10:29:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@fb.com
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
Subject: remove bi_phys_segments and related cleanups
Date:   Thu,  6 Jun 2019 12:28:58 +0200
Message-Id: <20190606102904.4024-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series removes the bi_phys_segments member in struct bio
and cleans up various areas around it.
