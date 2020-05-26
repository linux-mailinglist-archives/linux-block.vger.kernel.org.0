Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A60A1BBC61
	for <lists+linux-block@lfdr.de>; Tue, 28 Apr 2020 13:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgD1L17 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Apr 2020 07:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgD1L17 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 07:27:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C32C03C1A9
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2020 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ksWvMViadwXba+Bfm09L1Ht260HmtOnMpqTFmzV43os=; b=Vz0SvNmcs+kOicRmTM1IQQHhTT
        67tUeJuSyzoTTXfe1e1WpnNQXoDz/KRnKMB+iILwU56DQbNerMbD6wKwBKhXEsT8lCjr34jU85+Fx
        lHEkjoCJW2DxssatKVQscmRCxsGXHTjPGNHaR7d8OTW+52iSwvWjjsOt7/0v5+bIqha31cqZlt6MM
        JJJfHdJynGqO8lbY6GG2TATqV4r0psVUtHswjPNb23v60XTltOknSVDuqFqif6XnbtbPPKwvLOjfT
        hnJ57dlsNFP8xEAnlmfO438fbFQETdJh8j41Q0wqqa9SAAWKKArs/WM0rJDp8wSgpzjmKbZ03wYg4
        e/sxzo+g==;
Received: from [2001:4bb8:193:f203:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTOP8-0002gO-0v; Tue, 28 Apr 2020 11:27:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     hannes@cmpxchg.org, linux-block@vger.kernel.org
Subject: a few small bio related cleanups
Date:   Tue, 28 Apr 2020 13:27:52 +0200
Message-Id: <20200428112756.1892137-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

below a few patches to clean up the bio submission path.
