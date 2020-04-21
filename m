Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1BB1B1EA7
	for <lists+linux-block@lfdr.de>; Tue, 21 Apr 2020 08:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDUGMe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 21 Apr 2020 02:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbgDUGMd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 02:12:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DBEC061A10;
        Mon, 20 Apr 2020 23:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yfnafnC/G+NL8NZBzhuT2oQpPb7OuOoFw6goIf8w6jc=; b=BpJFGuGgi3bzpp4oPMe8wsspac
        LztnpfqPUHxQ1JdI86MQp2LOPKDsU05frLrjjuKHxfJtWgPahNMYvoCNkvcoid4cXBdHzR7IBa4W+
        8rqS0Px3MVVgN5GvJcr5I894+/3gtQA6DAeOmDk9wwm5YdljNJVybHYXPALrKCP+YdsD6PtSdf8/o
        KiBzdhQhOCmYl8cZyG1FPz7gNVFBXW8ox79sLsjvdAYL306WiEevIRHZfNTgfZFT+1cQsVEbhhVpL
        zHHn2mdrmWZl6K11GYpzcoXmRC5We2NVK7uyI4n2XJu5v1feRSD1gKcCFDXOsveuoI994Jyh27RX9
        O5JF4f5g==;
Received: from [2001:4bb8:191:e12c:292e:7dec:cf13:becd] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQm8y-0000HF-80; Tue, 21 Apr 2020 06:12:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: stop using ioctl_by_bdev in the s390 DASD driver
Date:   Tue, 21 Apr 2020 08:12:23 +0200
Message-Id: <20200421061226.33731-1-hch@lst.de>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens and DASD maintainers,

can you take a look at this series, which stops the DASD driver from
issuing ioctls from kernel space, in preparation of removing
ioctl_by_bdev.  I don't really like the new s390-only method, but short
of forcing the dasd driver to be built into the kernel I can't think of
anything better.  But maybe the s390 maintainers are fine with forcing
the DASD driver to be built in, in which case we could go down that
route?
