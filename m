Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BB03237E5
	for <lists+linux-block@lfdr.de>; Wed, 24 Feb 2021 08:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbhBXH1t (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Feb 2021 02:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhBXH1e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 02:27:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC6EC06174A
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 23:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=CtfrFtqyFUQROz635HNoujo3rbW3r/k8tXRl4GQaQCk=; b=rgHw/ITknxnAZdCZ1NRxc3mBKe
        IY0f2/3QlilQUdGpc52c1ldSYIHKoutaeRHAFLoQTjBkwnoPv1XzTuKuuK8jahuSmLSHDNuVs6DsG
        YF/zpwm289yDQNEzFgPwaIO+JuvgPpiOwQUvWa0DttptMFbO6tRfZGcOJVWACajQKuL3rK0qJO2M5
        GAzM/DUazJxn/i8e+ysH4W2Obkw9nYGrIxgiDPwLZKJ+UAhGI3XBX2YrFC1qVtp9bUk5630NhaHE6
        C3zlY53ubWOn8wezsVSkJT7dhqrct+h+5Sx8D6KZ49bYkfOfNJUOMl/5H8rcT8UaiTXcT4uZ0EcYR
        UZul3Ngg==;
Received: from 213-225-9-156.nat.highway.a1.net ([213.225.9.156] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEoYt-0096YL-OJ; Wed, 24 Feb 2021 07:26:23 +0000
From:   Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        John Stultz <john.stultz@linaro.org>,
        linux-block@vger.kernel.org
Subject: bio_kmalloc related fixes for 5.12
Date:   Wed, 24 Feb 2021 08:24:03 +0100
Message-Id: <20210224072407.46363-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

a few fixes for 5.12 below.
