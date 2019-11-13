Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857B6FA035
	for <lists+linux-block@lfdr.de>; Wed, 13 Nov 2019 02:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKMBfc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 12 Nov 2019 20:35:32 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:36775 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726977AbfKMBfc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 20:35:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0ThwHhR._1573608929;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0ThwHhR._1573608929)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Nov 2019 09:35:30 +0800
Date:   Wed, 13 Nov 2019 09:35:29 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     idryomov@gmail.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 'current_state' is uninitialized in rbd_object_map_update_finish()
Message-ID: <20191113013529.GA64000@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

There is a warning during compiling driver rbd for uninitialized
'current state' in rbd_object_map_update_finish():
	
drivers/block/rbd.c: In function 'rbd_object_map_callback':
drivers/block/rbd.c:2122:21: warning: ¡®current_state¡¯ may be used uninitialized in this function [-Wmaybe-uninitialized]
      (current_state == OBJECT_EXISTS && state == OBJECT_EXISTS_CLEAN))

drivers/block/rbd.c:2090:23: note: ¡®current_state¡¯ was declared here
  u8 state, new_state, current_state;
                       ^~~~~~~~~~~~~

Cheers.
Tony Lu
