Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257355712B2
	for <lists+linux-block@lfdr.de>; Tue, 12 Jul 2022 09:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiGLHDn (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Jul 2022 03:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiGLHDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 03:03:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD61057E;
        Tue, 12 Jul 2022 00:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=sTQGdJSCJ/rBteNrfOF6Wt85x3qfsMQ6GlW2+UrLatk=; b=3TVYRfxfcyBrYzIvKw+tI2eztW
        ObWUgcTh+Jj+8cQ3WrE9OFidC6v7dQJ1bYaIrtycOuTKnLqey7JOB1SV+Rx8wPgSaRLKEU7XYviNj
        gYyTzp+J2noMzRc9YCqqRBM9nWQi2zMbxzjCql96QvBFLookku4677hNp+cwbYxJ5fVhDeIMcGyy1
        oVjHGlT4oIxwVx7kPaEQv3mujl5gPd9/VtoqcVKxHTWmZ45UzHgt+gJsM72uZdU7YvWQjb/d22SoF
        lWrNOA1FTAN0j4TElCNYiHJmfKl+2YAA+uzF/DS9U0og/U+c+YSUqfjrvwcGrw7ED9VSTKIFjgue3
        KoNQ/h6g==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oB9vi-008DR4-Nb; Tue, 12 Jul 2022 07:03:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Song Liu <song@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-raid@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: fix md disk_name lifetime problems
Date:   Tue, 12 Jul 2022 09:03:23 +0200
Message-Id: <20220712070331.1390700-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series tries to fix a problem repored by Logan where we see
duplicate sysfs file name in md.  It is due to the fact that the
md driver only checks for duplicates on currently live mddevs,
while the sysfs name can live on longer.  It is an old problem,
but the race window got longer due to waiting for the device freeze
earlier in del_gendisk.

Note that I still can't reproduce this problem so this was based
on code inspection.  Also note that I occasionally run into a hang
in the 07layouts tests with or without this series.

Diffstat:
 md.c |  272 +++++++++++++++++++++++++++++++++----------------------------------
 md.h |    1 
 2 files changed, 139 insertions(+), 134 deletions(-)
