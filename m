Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328051D103A
	for <lists+linux-block@lfdr.de>; Wed, 13 May 2020 12:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgEMKti (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 May 2020 06:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgEMKti (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 06:49:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EFFC061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 03:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RmgSkMCRaeTP/cQxVgEQwUPFVD1x+1nR5aY7gk71cSI=; b=E7xEO+KbJvV0Hi1E/FvFg6FWmM
        Hoky+tkwsYOCHhsTTF4lLahPslJdO5W5Zo1YaX4IRQLhdmYlbn6U3LjGF/Kc4Y5S9fkt3msu981Bc
        AKNrdBiy3BGkp5PCYRUGerrF5LveehgfmcLiFxkTGSfzb0t1/u56R1lUF1vAyut2bpt5YCYxvHVm6
        mkTVLG37ZRDr7SNz1jDd55MTBtwZNtizcq3oBaooNh01+ynNgkgjbVgOMUHJI+5p55Pf3MihLojtu
        HFzs5KLPTnayDHNIyggrOVRy3bMtBD9NB+7wZaubcRqM1ZpKylzTPFwwudjCIWKnFId5Bsz5JI8g0
        w/PsXH5w==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoxF-0005a3-Ad; Wed, 13 May 2020 10:49:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: small block accounting cleanups
Date:   Wed, 13 May 2020 12:49:31 +0200
Message-Id: <20200513104935.2338779-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

find a few small accounting cleanups attached, mostly cleaning up
the somewhat ad-hoc blk-mq vs bio split.
