Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7025F33DA4
	for <lists+linux-block@lfdr.de>; Tue,  4 Jun 2019 06:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbfFDEA4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 4 Jun 2019 00:00:56 -0400
Received: from m12-17.163.com ([220.181.12.17]:45169 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFDEAz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Jun 2019 00:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=1VTqQ
        gEDd3JZRtoJvuoKSY0JH0mZPEA/QxHC2d4JBZ8=; b=noEmiKrVsP6UgZGt+Htub
        koQ9fLpTEOdj1Zk4gXja6vSPXiFEfDJBFfX6lLWn1C3voljGHTm+2pKomH+/eM7H
        dAEdnGrBJAFNHXKmSQlfECYmgbxAn/MMRRkEZPpJFmo9hYUwO7Qfs3Fp6qHY4ca1
        kvHmC1/5MSgOMkc88Caob0=
Received: from tero-machine (unknown [124.16.85.241])
        by smtp13 (Coremail) with SMTP id EcCowADXuuza7PVcto8PAA--.5930S3;
        Tue, 04 Jun 2019 12:00:27 +0800 (CST)
Date:   Tue, 4 Jun 2019 12:00:26 +0800
From:   Lin Yi <teroincn@163.com>
To:     bvanassche@acm.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 0/2] Fix kobject_add refcount imbalance on block layer
Message-ID: <cover.1559620437.git.teroincn@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CM-TRANSID: EcCowADXuuza7PVcto8PAA--.5930S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUaa0PUUUUU
X-Originating-IP: [124.16.85.241]
X-CM-SenderInfo: 5whu0xxqfqqiywtou0bp/xtbBERvJElaD4-DLBAAAsY
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

kobject_add increments the parent kobj refcount, but forget to release it
after err return, it will lead to a memory leak.

Lin Yi (2):
  block :blk-sysfs :fix kobj refcount imbalance on the err return path
  block :blk-mq-sysfs :fix kobj refcount imbalance on err return path

 block/blk-mq-sysfs.c | 4 +++-
 block/blk-sysfs.c    | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
1.9.1


