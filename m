Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1993088498
	for <lists+linux-block@lfdr.de>; Fri,  9 Aug 2019 23:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfHIV0X (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 9 Aug 2019 17:26:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfHIV0W (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Aug 2019 17:26:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C336DC047B6E;
        Fri,  9 Aug 2019 21:26:22 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-125-29.rdu2.redhat.com [10.10.125.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C1EE60872;
        Fri,  9 Aug 2019 21:26:22 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org
Subject: [PATCH 0/4] nbd: cmd timeout fixes
Date:   Fri,  9 Aug 2019 16:26:06 -0500
Message-Id: <20190809212610.19412-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 09 Aug 2019 21:26:22 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following patches fix bugs related to the nbd cmd timeout feature.

The patches were made over Linus's current tree and also apply over
this nbd patch:

https://marc.info/?l=linux-block&m=156494582914495&w=2


