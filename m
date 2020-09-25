Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29F6278D98
	for <lists+linux-block@lfdr.de>; Fri, 25 Sep 2020 18:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgIYQG3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 25 Sep 2020 12:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgIYQG3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 12:06:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABDEC0613CE;
        Fri, 25 Sep 2020 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9fMaPbhzAtLsK4GqLf9UO/jqtWV45pALgS6VDR5Ex6g=; b=Dce1miEU6M5xuTkIphPHY2C711
        054xElroFEhbrHjROV4X2jynnOLXPd0zHs086v8oNlq3wQXKy5Egstt5ur4pIjb2nDyNKaCBuMWtw
        THpLx0YSF2ala+gUPUUifRv7YCYharUg8P4HOJKD1e0MQoT6i60yUFfFxI/26DS0TOWoKTvs2YJIU
        Xi2HTY3yaS4dES1qiZFFuGeVaIhcGyh4ceRJ43jWkA7DJ+SC/N+8dj1eglSyOYIAQiEjA+yb4XufM
        g2KOMwNW+mxe1OXq+cBeIUYpfyZZhjal7PqKCZpnX0mPgs9YMhXTU6AH8ybjhhQCXj9v9cjDBppwE
        lVwVb2Tw==;
Received: from [213.208.157.35] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLqEs-0003Nz-Tw; Fri, 25 Sep 2020 16:06:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: remove bdget() as a public API
Date:   Fri, 25 Sep 2020 18:06:16 +0200
Message-Id: <20200925160618.1481450-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series first cleans up the somewhat odd size handling in
drbd, and then kill off bdget() as a public API.
