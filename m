Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63BC45E4B6
	for <lists+linux-block@lfdr.de>; Wed,  3 Jul 2019 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfGCNAo (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 3 Jul 2019 09:00:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56928 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCNAo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 09:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2/OK4SoOzMoQeHKS4mfiI7olt/h8TiJQCB7ilmEKYQQ=; b=g2d9EDqsxsOcfJl5PApHLWjMD
        94OnXuk50ijO/zqVim/9ApYCPl7FxzyMHdRHddQ+S3GSfRlWWVViyh9PrcHAMw+Kp9U7SC84mwoUc
        FQcf/s0PUe3sI6uVbCrkj2sBazFPyC/lPCM5iRMBO70MUleFLstBzFBOgc8XwSt5eu2bhygSx0JGc
        Oeom225SMU2Sx/ka/XCgPjV+ffyPZ2/GgkG7uTuZ/KxD+Ksy71IU9bRXVowfBbM6U8AISgwY4t/vr
        rklqpi/iI11rcsfJm7JZA83NUQOVYwojag9gRs62cJRcz/UmVkBRYnJzZgznlC3h3sGDP7WpmiGNo
        sosk6AomA==;
Received: from [12.46.110.2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hiesK-0006UT-Pj; Wed, 03 Jul 2019 13:00:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: bio_add_pc_page cleanups
Date:   Wed,  3 Jul 2019 06:00:33 -0700
Message-Id: <20190703130036.4105-1-hch@lst.de>
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
