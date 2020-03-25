Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2BB192D42
	for <lists+linux-block@lfdr.de>; Wed, 25 Mar 2020 16:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgCYPsq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 25 Mar 2020 11:48:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48626 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgCYPsq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 11:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=AdTAtOQjOFKE/NW0z69GFq9nK4YL4GyPHbtdVxISirQ=; b=nb0EXZ1y9pWV9KDU2IwrqDH1Fu
        dLlowE+sRsalbvrvK3XZH5ZFrxK6zwS0b28cFBc6y31pqGSJtmS1L4dap9uWvMp/rmxaTGwLj9pNq
        cqnplIVAxRjtET1tNQ8xKhF6+D1zhyykQ0UYG1rW29V0LeNXpRHWb4asgaPCu4TCMI7J1Cb6S8711
        OiICVt0la/TS6hKoYSChyb3bq1bi+QG1U9971fmYs3HT+o38oF1ToMm50fVXZxx/5/7DIDT1BL+XC
        /DFpbKr8acx5aDlVqg8YOgvL0prr6XnF+XHw72EBcX1FXsNz+l943W4TegrH5cd1B0QchGdQPNzir
        Bqhk7iIQ==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jH8Gr-0005EV-F3; Wed, 25 Mar 2020 15:48:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: decruft genhd.h v2
Date:   Wed, 25 Mar 2020 16:48:34 +0100
Message-Id: <20200325154843.1349040-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series tries to move as much out of genhd.h that doesn't really
belong there.

Changes since v1:
 - rebased to the latest block tree
