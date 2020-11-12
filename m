Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99FE2B0AB8
	for <lists+linux-block@lfdr.de>; Thu, 12 Nov 2020 17:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgKLQuL (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 Nov 2020 11:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgKLQuL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 11:50:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A37C0613D1
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2020 08:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ylrmEYZNG5pYyvXLBCVYe0gE7PXJOC+vOmyxjlPkRGk=; b=mSZVYvh6UeQWklsZT3s6RpCg8g
        BKjUWiio4SgsYZI2D5eAOuAE3Ttaix53sdYELuJyYGimW199L3fe8wU1Dgx6uGmNOqnEfD4sgVt9/
        ygBx2hshTGsjhAyY061uk003902VV5cQ2qtIuQSarJyIzb4qEwn/RtKI5CCJp/6+Qa5JTr57f7R8G
        T47wPu69WU2KXVpfnAMWOqzFbrnUb2P4rIABT8ok2+60foSCObWhMLw/ZA0N3UggKTU+Nk+z4KC7v
        zgPP67XpZH+x9h/LI6e0Ydh1tDeUmc4Iiw89rO/V+CWze1lovP9oP7fJy5gC6SIoEQPfPFryta9K1
        KB3v+ahQ==;
Received: from [2001:4bb8:180:6600:5c73:9bb4:23ff:391c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdFnT-0006yk-QU; Thu, 12 Nov 2020 16:50:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Petr Vorel <pvorel@suse.cz>, Martijn Coenen <maco@android.com>,
        linux-block@vger.kernel.org
Subject: loop uevent fix
Date:   Thu, 12 Nov 2020 17:50:03 +0100
Message-Id: <20201112165005.4022502-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Peter and Jens,

this is how I'd slightly respin the patch from Petr on top of the
set_capacity_revalidate_and_notify I need for 5.11.  Let me know what
you think.
