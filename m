Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0783E91C8
	for <lists+linux-block@lfdr.de>; Wed, 11 Aug 2021 14:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhHKMp6 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Aug 2021 08:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhHKMp5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 08:45:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6218CC061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 05:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7exWYwWdX/mv9kmXqGggLCNL3l1kVcMUuVRwKGhNT5E=; b=CnY08ocpUvwr/BCpB5fZPnaLiD
        +GLqcWfqC5YcqvvVjdGi1BXD92OQT4Epi8udeWTOlITReYGt3pmPSfkNJikW/OavRgqKRO8deBGp7
        +ilzX3RLxW/M1un6O1F0p/4vzPw0iZji4Desakjox32ZOnfWYCmtDKWeRQ31hI5Gjmdsi16Sn/L4+
        edugwLDW5SHvw176fG86O/PLFYKYg5OJ7AkoJx/lxJmXN4yNUQk6fJyQtdMr6YpVHL2W2qNBCd37A
        QH5b55oaLaAUQ+x5rJNd2BGDnftcpxwn6VL83H28YEdyOf9C6AClt00ERKLhixq8X/NJerzuojNRM
        XugHuVlA==;
Received: from [2001:4bb8:184:6215:7ee3:d0e9:131a:82ff] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDnav-00DPV8-Jt; Wed, 11 Aug 2021 12:44:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Tao <houtao1@huawei.com>
Subject: nbd locking fixups
Date:   Wed, 11 Aug 2021 14:44:22 +0200
Message-Id: <20210811124428.2368491-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Josef and Jens,

this series fixed the lock order reversal that is showing up with
nbd lately.  The first patch contains the asynchronous deletion
from Hou which is needed as a baseline.
