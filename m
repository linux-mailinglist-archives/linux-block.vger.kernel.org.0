Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0CFEEC9A0
	for <lists+linux-block@lfdr.de>; Fri,  1 Nov 2019 21:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKAUaJ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 1 Nov 2019 16:30:09 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:35597 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfKAUaJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Nov 2019 16:30:09 -0400
Received: by mail-io1-f52.google.com with SMTP id h9so12273587ioh.2
        for <linux-block@vger.kernel.org>; Fri, 01 Nov 2019 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=EA4HviSDBj8RIzT18RSZtVS32M9p6m1mOAshuls/3J4=;
        b=OLLPvCDzPO2nVXFi4qr0/1yao4YgUvmG54rXW8D9CtHz8033Stpcd1DBUHhKSoYAdF
         2+orHD5xvFdZMyAp09wCrp72m/Ui70ytA96IOaRPLjD6Mk/KKVGSTB1BMaUFTzXzCqUo
         B76Lu4MYt6uxQ//fPIbjY4U3h2cciQZhyjuVY69boicjnqXccS8orBoekmmieLpUBpSn
         zd1OCSU2txiCC1W+lmJx+GY1wHQ5UcU0nk7WiW4OkZgsFAHN6dxVolPKp6unjK5wzfGA
         g+iR99aVj15qrvo6RHPDkFZGKu13dYtT+EnXOTjba86k5JpagUBLS5L358Yno6jCceVJ
         99vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=EA4HviSDBj8RIzT18RSZtVS32M9p6m1mOAshuls/3J4=;
        b=VLWAotcG9S348EPKjKXU0C0W+62VI3FtVNqrfonSZgB9O4EyrLIKn/2RVdADxYZEoH
         bOF1Hpx1rbGbO3jQlUl+IL/rKCgWjGUgT/999iyFFfhxj+2Os57Xmi3yALAhAcMsgFAv
         qBOMZFJjyOs7F6M4GkTaktUYqTmpIdcQhB2B52Db4NYeGPOg2tISlKgTnM8LoW9zbKo3
         EMTvdVUGHcKrVGMeA60KX/qhNcegjVbibZ/9MtZdx4U4D7fV5Yc/rzT8Hi8sjMMbP+5q
         JV5qtaU1fwmGJzjxAPaeVdht/ff4yMpCDiKzS2rj8SImDD9Z5m228/HJGrco77bwHEMy
         IXgw==
X-Gm-Message-State: APjAAAVc1Zd5EbcOmHASRLv01IGD8ZMaHXvNpfE+FH0oDKoukgO7HdTe
        ZZa6IEVcwMCDAUjGaJH1rNWlOxzNZIgadQ==
X-Google-Smtp-Source: APXvYqy097hzNFeMelWJWzUcx5tupQLnfi8Np+tiqBy99c/BqsznyrfwQvC8fMjeyDpD1LtHoEcBHw==
X-Received: by 2002:a05:6638:928:: with SMTP id 8mr7008647jak.124.1572640207488;
        Fri, 01 Nov 2019 13:30:07 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n28sm1119708ili.70.2019.11.01.13.30.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Nov 2019 13:30:06 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.4-rc6
Message-ID: <61bab3c6-d24b-e528-bd01-fa9a61c8b2f3@kernel.dk>
Date:   Fri, 1 Nov 2019 14:30:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Small set of fixes that should go into this release. This pull request
contains:

- Two small nvme fixes, one is a fabrics connection fix, the other one a
  cleanup made possible by that fix (Anton, via Keith)

- Fix requeue handling in umb ubd (Anton)

- Fix spin_lock_irq() nesting in blk-iocost (Dan)

- Three small io_uring fixes:
	- Install io_uring fd after done with ctx (me)
	- Clear ->result before every poll issue (me)
	- Fix leak of shadow request on error (Pavel)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20191101


----------------------------------------------------------------
Anton Eidelman (2):
      nvme-multipath: fix possible io hang after ctrl reconnect
      nvme-multipath: remove unused groups_only mode in ana log

Anton Ivanov (1):
      um-ubd: Entrust re-queue to the upper layers

Dan Carpenter (1):
      iocost: don't nest spin_lock_irq in ioc_weight_write()

Jens Axboe (2):
      io_uring: don't touch ctx in setup after ring fd install
      io_uring: ensure we clear io_kiocb->result before each issue

Pavel Begunkov (1):
      io_uring: Fix leaked shadow_req

 arch/um/drivers/ubd_kern.c    |  8 ++++++--
 block/blk-iocost.c            |  4 ++--
 drivers/nvme/host/multipath.c |  9 ++++-----
 fs/io_uring.c                 | 14 ++++++++++----
 4 files changed, 22 insertions(+), 13 deletions(-)

-- 
Jens Axboe

