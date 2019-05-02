Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7EF12526
	for <lists+linux-block@lfdr.de>; Fri,  3 May 2019 01:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfEBXeL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 2 May 2019 19:34:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52680 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfEBXeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 19:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y/B2lqvstoxq18RBn6OwlnumUYkXLU2bxxVWqayH9JM=; b=HOFWsJ73h2A6ZZrpfcSVoRO7u
        GGhsyhtgKgNGAV/bhJyRF5IKdeqQlN9WzwtWuhQbnvsbEe+RqKEu4VIcdJuuf0IB8fW3DTZU+bG9/
        GDN8FfcGI56wJ82hmnlXGFhUrOnocti/kgcZOtrWUsqw/NvPy2mm7/hPyFgaYtYRvnFu3x0Yrr1fj
        VWOqD4fXeDqA/Al4w7N/CLnJvlQpByolnHGhU4+nFKzLPSA4cM+PjtOZwO3GFbKaXHbV1d7zTb0My
        Qq4DW5/Vp3cH/ZmjW+lVrAJPXiNoLhGv9O+WAyP05j5UYAMBxttU1hhcYvpN75qNgAe/0DdzZhQfX
        uu5vB7Mew==;
Received: from [12.246.51.142] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hMLDN-0002ku-Lp; Thu, 02 May 2019 23:34:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: cleanup bio page releasing and fix a page leak
Date:   Thu,  2 May 2019 19:33:24 -0400
Message-Id: <20190502233332.28720-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up the various direct I/O and pass through
routines by switching them over to common bio helpers.  For
the block device simple case this also fixes a page leak
if we were using bvec iters.

The last page just unconditionally applies the no page ref
behavior for bvec iters.  I looked at all the callers, and
there is none that drops the pre-required references before
completing the request.  Probably not suitable for so late
in the merge, but I wanted to get it out.
