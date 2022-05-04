Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885CD51A232
	for <lists+linux-block@lfdr.de>; Wed,  4 May 2022 16:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351329AbiEDOd2 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 4 May 2022 10:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351254AbiEDOd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 10:33:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEFF275E6
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 07:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=VQPUbesm4O7dNZIEg9XAMnPlIr0v/bxAJJz5ROW2yro=; b=FdoSUsMjBU3Kt/GmtWUYkgyfPq
        wGYi1ti//MT8Av5SJn9GE6/6FJRt9Bn/k2cD5lR7AFZc0pZpdyaTHwnKSwi76fsx8SDS9tytcJbiT
        Xpr3Q3FE6HvEguXOe4nns6xZripyZPO4REca8gDHHk6euvC/sy5CbyKzUDgAKLXEeuAXkjKBUYbDW
        /2cRJrlEtewn7IJ6z0/7x+WTGrhv/C3xRk60KldyXKG4KYjPHzwrmQ+DqUnOlVQVUVuaV9oU1iXIl
        Qw/TJupHvTBLmps6ieFyROdl4xz/sCbsCiP/51V3hxOU1aEUcL8qO8ytYZfYe4jTdQz2fyRMRZekK
        K7psE+EQ==;
Received: from [8.34.116.185] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmG0k-00BGd2-Rs; Wed, 04 May 2022 14:29:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org
Subject: bio clone submission micro optimizations
Date:   Wed,  4 May 2022 07:29:48 -0700
Message-Id: <20220504142950.567582-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series has a few minor optimizations forthe bio clone path
that should make life a little easier for Mike in dm.
