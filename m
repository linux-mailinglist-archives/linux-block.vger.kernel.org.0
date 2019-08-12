Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800678A27B
	for <lists+linux-block@lfdr.de>; Mon, 12 Aug 2019 17:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfHLPkB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Aug 2019 11:40:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58094 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfHLPkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Aug 2019 11:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2/OK4SoOzMoQeHKS4mfiI7olt/h8TiJQCB7ilmEKYQQ=; b=J8nJrp3fIsPNFG7Go91vmldZy
        gc+CcLr19Qnas3lwoepymuZkclpg6TVERecJatADbBPbxXZYY1/a+HvMytu2r56o/7qHSrlTYflfS
        C2sozpfZezg6pX3EleV/eo3iGSCwtW32bLgOFK2gy94yK2NdFMtRT/qHONWl9rR2uS49xXJSILUaC
        wkghlqC61WtlSKSdOFhWYIVmwaeskgkBhIbCJB6iK13xM/ZneieNhglmVNIUSecZuVd7vyZqlzTbO
        DHZ1yeq9GX8uUQOCHz+tH7lu7jczGzPopUf8aYvVVUhs+odtadubiMAiCI0/ZZYHLO+//H4qPZ9ml
        jvUt65idA==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxCQS-0002OV-UZ; Mon, 12 Aug 2019 15:40:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: bio_add_pc_page cleanups
Date:   Mon, 12 Aug 2019 17:39:55 +0200
Message-Id: <20190812153958.29560-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series cleans up the bio_add_pc_page code and reuses more code
from the regular bio path.
