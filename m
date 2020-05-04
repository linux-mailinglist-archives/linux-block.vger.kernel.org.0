Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2911C39D6
	for <lists+linux-block@lfdr.de>; Mon,  4 May 2020 14:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgEDMu3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 4 May 2020 08:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgEDMu3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 08:50:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7289FC061A0E;
        Mon,  4 May 2020 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7SAJX4czMKUYeyR2XmhRKutbi13jPjIgNv54etymA6M=; b=Rr7mm8L0HMO7djG4SAdMiljXGT
        tctEKC3QURN3+PmCxFBVMWUj45sYmaM6lsUVM/Yb/Oh5PPQ1c49/knNMv2DYi7v2ezlhpQgFcNn0Z
        Ui3vA1C1ypNc5PM2TtkC7fivGMAStEgrKl+z9ONTu3ejdDI85ny/1/IkNoWWjMhuXNQsKeFhTW0iD
        NwZmdNZrCT1EqY3WaIk6GHtf3V7KIHzxVwhta+PcSjyNBlw65TB/BTL9FicOYvsAYOU8Hyxn5zj/r
        e+YB9sQjmt2ECJC4XEStsm9i8QU0PzcbGy5RH9vc8ZAMK+vfaC/knAEk/VRNp2ns1jIThgw7Y9hUp
        +pMNaoFA==;
Received: from 089144205116.atnat0014.highway.webapn.at ([89.144.205.116] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVaY2-0000uy-Vl; Mon, 04 May 2020 12:50:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: bdi: fix use-after-free for dev_name(bdi->dev) v3 (resend)
Date:   Mon,  4 May 2020 14:47:52 +0200
Message-Id: <20200504124801.2832087-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

can you pick up this series?

the first three patches are my take on the proposal from Yufen Yu
to fix the use after free of the device name of the bdi device.

The rest is vaguely related cleanups.

Changes since v2:
 - switch vboxsf to a shorter bdi name

Changes since v1:
 - use a static dev_name buffer inside struct backing_dev_info
