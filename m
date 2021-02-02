Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65530C777
	for <lists+linux-block@lfdr.de>; Tue,  2 Feb 2021 18:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237439AbhBBRWh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Feb 2021 12:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236234AbhBBRUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 12:20:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDB4C061788;
        Tue,  2 Feb 2021 09:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MMeqCbGKRV+69DS0ZGONIL+1GkDU1P/9RqyGOXrbCo8=; b=JJ6TtTkV8n6HB3NdwhozSG/DJc
        WGiqtzCGKi9qViQd5ZWx8yAbiZLJtOM5JTPNFAQedU254byKoJHgRD9yQM56GNUYQPEhggaW64X2x
        VTisr7ymIT7H8nRiniKe9WS6TzHZCUFMemAfw0Kt9gFG7+OeMft4fdQNh5SW16RlaoOwTv9O70e6C
        idooAbdopillS466EXP+bnjLrAa7mvcFxDi5gdoNP88UoFfidfMb5DdkvvQ36lbOS8wYuEoJK++24
        fm3o16IpEqUZVIGEAazBjHaloWIb2BH8xg8BcbNJ57IHjV5Kfv6KUmAr6Yx3imLjXRehA87V1tcj1
        0rzwIZKA==;
Received: from [2001:4bb8:198:6bf4:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l6zKs-00FVyD-Ty; Tue, 02 Feb 2021 17:19:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Subject: cleanup bvec allocation
Date:   Tue,  2 Feb 2021 18:19:18 +0100
Message-Id: <20210202171929.1504939-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This series cleans up various lose ends in the bvec allocator.
