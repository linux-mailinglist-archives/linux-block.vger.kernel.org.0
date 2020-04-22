Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C5B1B391A
	for <lists+linux-block@lfdr.de>; Wed, 22 Apr 2020 09:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgDVHjF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 22 Apr 2020 03:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbgDVHjF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 03:39:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315F3C03C1A6;
        Wed, 22 Apr 2020 00:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=trQjdomDCRV6qbx8X9q1OiMo2aPdhpEIEG3jZKBOoBY=; b=kOT+qjx/YFh+D0W1Zu25o8e2aX
        U39FdtwMEYNhBL5rC0jMMnWEJR1OIKYeQJrrhafa0Tij+5T12DbJHH5SrWdDZ58nWxQ1+pkrlD8nr
        rTWnD2dvlrXgKXsc6XdirWsJ3MBWxAozRWVFt43otaTYAxhHNujjZlH7VkpwBse1BNwASERP8Y8wX
        GKyV9/9PigkW8fBeW8LmBg1BAO3LWmDy6j5pvpYUQ6GLRe5WFgs1TuHBwdrTOCF4dC6oehCxaMpPF
        SyJfnW5y9Gur+gEmejbiTq1BaoLbqQEepN28CGhFW1n57gp2aXgiIivWlxsX6PNBdBVVs5ZezHgvp
        vht3xbpg==;
Received: from [2001:4bb8:191:e12c:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9y9-00008K-IQ; Wed, 22 Apr 2020 07:38:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: bdi: fix use-after-free for dev_name(bdi->dev) v3
Date:   Wed, 22 Apr 2020 09:38:42 +0200
Message-Id: <20200422073851.303714-1-hch@lst.de>
X-Mailer: git-send-email 2.26.1
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

Changes since v2:
 - switch vboxsf to a shorter bdi name

Changes since v1:
 - use a static dev_name buffer inside struct backing_dev_info
