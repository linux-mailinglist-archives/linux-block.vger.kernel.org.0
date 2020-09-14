Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6235268575
	for <lists+linux-block@lfdr.de>; Mon, 14 Sep 2020 09:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgINHGI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 14 Sep 2020 03:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgINHGB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 03:06:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7EBC06174A
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 00:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BrXBd0ikksxbg+wI2t80vq4hDOHC15HKTVqkikU8+GA=; b=Czl+frnAo/vBDkxWY7ySqLmFcW
        27OBEI2x7gYifpGoPka6PxLSfinymEQXoKq8xVGkesxp2FdahrsYp2BS4cLsVcC3jJCA+RH0MOxA6
        5FGJNt6SGHET+VwUdc8Qlsc1efZbPzdl3qfdYw1XH8tFaFkRBWyDigs5g5AlNx2KvjD2cmHhgyeGR
        0CT8g/TgBKibrftp21o/d2fALoSzMA5DP+JR4lS8ffTZDpepl6SeOIZw9sHRQTb6eA6MnpitHfqx0
        kmGiERaBrP9WPZT2GaQFGyEi6HpoFCs0VsRPjKr5+yoXn0IlVBQu0c6LfwiPnU9XBm7PahUgD1tZV
        PcFDPPoA==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHiYg-0006bA-GC; Mon, 14 Sep 2020 07:05:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>
Cc:     linux-block@vger.kernel.org
Subject: remove ->revalidate_disk
Date:   Mon, 14 Sep 2020 09:03:34 +0200
Message-Id: <20200914070337.1578317-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

with the previously merged patches all real users of ->revalidate_disk
are gone.  This series removes the two remaining not actually required
instances and the method itself.
