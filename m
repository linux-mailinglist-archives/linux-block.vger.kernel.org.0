Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5AF14B10D
	for <lists+linux-block@lfdr.de>; Tue, 28 Jan 2020 09:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgA1Ior (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Jan 2020 03:44:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:36990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgA1Ior (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jan 2020 03:44:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DB7E1AD48;
        Tue, 28 Jan 2020 08:44:45 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 0/2] nmve/018 fixes
Date:   Tue, 28 Jan 2020 09:44:32 +0100
Message-Id: <20200128084434.128750-1-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

changes from v0:
  - added "nmve/018: Reword misleading error message"

Daniel Wagner (2):
  nvme/018: Ignore message generated by nvme read
  nmve/018: Reword misleading error message

 tests/nvme/018 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.16.4

