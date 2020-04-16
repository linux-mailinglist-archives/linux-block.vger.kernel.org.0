Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156D41AB977
	for <lists+linux-block@lfdr.de>; Thu, 16 Apr 2020 09:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438549AbgDPHPj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Apr 2020 03:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438466AbgDPHPg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 03:15:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB20C061A0C;
        Thu, 16 Apr 2020 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=pAC8y4t3FdRbk1n60w0TsVD+opVLgm9/jLxOASkoO8A=; b=WsEFbDTN3VLDQTF3Xhyo1/bz9N
        58K2eWylh/BmzXGTLojSBkYSHvnrZ8LDo5s1VD8XRwLkf7lbn5FxUJB7ufdeDZEHIc5f4UzRf74oK
        0OgPizb5DUPWUCZ7UTz69GnzUY/VeoNYKCQf+5gjjmPD0g50bIRsKlOJgsZ+LA9fqEVLx5mEgG61j
        BYJnCikk+BgA6/gauOcg+FN6OhaS9ORIVIQEvvxOGOET1eF2qoxuER4kAwOVE23kS7bC46dgyzNuG
        /oW268wElk3wj+xnSsuCW+wUb3H5Hv/VGjAT5zHeaP/2QSNTpx0iw8CTK032JrLkw1oercJEEkox6
        fCj4sg7Q==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOyk5-0003Ga-Ow; Thu, 16 Apr 2020 07:15:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: bdi: fix use-after-free for dev_name(bdi->dev)
Date:   Thu, 16 Apr 2020 09:15:11 +0200
Message-Id: <20200416071519.807660-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

the first three patches are my take on the proposal from Yufen Yu
to fix the use after free of the device name of the bdi device.

The rest is vaguely related cleanups.
