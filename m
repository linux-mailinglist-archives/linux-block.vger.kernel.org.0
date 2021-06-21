Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8683AE6E3
	for <lists+linux-block@lfdr.de>; Mon, 21 Jun 2021 12:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhFUKU4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 21 Jun 2021 06:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUKU4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 06:20:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAEEC061756
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 03:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=284/DoXBnGJsBKFN094fpGnokc/0VVOFNvD9vzIpZOE=; b=bR2opcsLo54hJwC4SrLZVFEIen
        yVwoSKiSJGzXWUBGYlto8IYLvcLrnRSS33Bg6q1EsvcEfb4sNNpuIhkWIjm70NO5PzB4dwb1UUkBR
        xagJRWJOKQEzoBsu188aT05ER+NnlAO+0vuhE+xtYHD8nhmnzRbvxuV79E3x+Kp99RzME66HoWPqT
        wApb70wgn21s0M0TTbX3yFisCp6z+R3Qd2wLK50rK0q7I+AEB1HmMwnfC96OR/BjncGW5Y1fzE3Yc
        wGDuRz+SPP5GrpEwb1QW/1HbVkFnXy9MaSWJaJ+Oi97Em9fSz9jM+GLwWxeZNoLM0qNOOpjf1aqiT
        rClzoKbg==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvH0A-00CyZn-Fi; Mon, 21 Jun 2021 10:18:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: loop cleanups
Date:   Mon, 21 Jun 2021 12:15:38 +0200
Message-Id: <20210621101547.3764003-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series contains a bunch of cleanups for the loop driver,
mostly related to probing and the control device.
