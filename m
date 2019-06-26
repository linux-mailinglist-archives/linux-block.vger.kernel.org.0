Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0217456B28
	for <lists+linux-block@lfdr.de>; Wed, 26 Jun 2019 15:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFZNtc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 26 Jun 2019 09:49:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZNtc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jun 2019 09:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NS7ULM2AAO3jPDAm+TqlI97DpGlS5D/cobAJEBnxENo=; b=UmIBDQAFtRhnNUGWAlILwGrtg
        wv40Hz5Mh75TH1jOhuAlH1i+kkyJtDSbSOJbR3bjBTen2tjIxV9MO66qlU1Xrh+THflZN7HRnaFb1
        Ug5dYAkush2HE8+WQ62VPo64fdk8Vag07QnCZx3zWzFgUKPqLx4SIG+iPb0Idvk31xLmG7aGNROwa
        gnsl+2EecCIjGxK+fIVJmVMRI6eAaDmTh/7wVKAQJM4tohX1x+1UMsyGss5/Gfg8Ai18OZsyx0oVU
        mcFxODriio4sXw0kzegC+GJ7dLdQN8A3tA3qfqZcFwEMJsn+W2XRcMoonxmn5hA/NjAjsfnvq+DF/
        RYCYPIgOw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg8Il-0003AO-Ia; Wed, 26 Jun 2019 13:49:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: cleanup bio page releasing
Date:   Wed, 26 Jun 2019 15:49:19 +0200
Message-Id: <20190626134928.7988-1-hch@lst.de>
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
routines by switching them over to common bio helpers.

The last patch just unconditionally applies the no page ref
behavior for bvec iters.  I looked at all the callers, and
there is none that drops the pre-required references before
completing the request.
