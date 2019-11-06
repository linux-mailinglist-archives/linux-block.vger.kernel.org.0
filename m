Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A046F19A6
	for <lists+linux-block@lfdr.de>; Wed,  6 Nov 2019 16:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbfKFPOn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 6 Nov 2019 10:14:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfKFPOn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Nov 2019 10:14:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=On05a94w0KiC4K5lOIZ12JY44ZTH3FlHnt0c/Jx8KVQ=; b=sTfSBmWU0QydbrLyx0P848kD2
        6w7qt8rGsfnqB6+Tc2M3NJtQyGul9+QIAbrxZA2MDeQnGSmRejWeqBIfCcaXg0HhkF4exDqSoKdLp
        LBvtOyiua0nlZe+Dw6ttC0MOpdikoVMoS+TtkUNNHSjoh4SUo20wpSjKs0M1CNZqDrJKXLN3k7r17
        inqk1ti2ybQwIHhEeCmNznr7YEeBSxIDuEXHfWKpIl8z6hPS2prdCRpkxFVNoUiZ8whSYq5c5LIv9
        dgVVT2w478kzZ4ifGlviKB5T7+5Qqyc7EBNBr9Y8yVJlUMdlG4uZTt88VZxlk1tvHINQeh5TjCRB4
        fa45GGV8g==;
Received: from [88.128.80.117] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iSN17-0005Dg-Sh; Wed, 06 Nov 2019 15:14:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: disk revalidation cleanups and fixlets
Date:   Wed,  6 Nov 2019 16:14:34 +0100
Message-Id: <20191106151439.30056-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens and Jan,

this series takes the disk size change detection and revalidations
from Jan a step further and fully integrate the code path for
partitioned vs non-partitioned devices.  It also fixes up a few
bits where we have unintentionally differing behavior.
