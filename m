Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2815735EB3A
	for <lists+linux-block@lfdr.de>; Wed, 14 Apr 2021 05:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345324AbhDNDGF (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Apr 2021 23:06:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41496 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232009AbhDNDGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Apr 2021 23:06:00 -0400
X-UUID: fc60bbea1456446faa5ac9499d2fdc9b-20210414
X-UUID: fc60bbea1456446faa5ac9499d2fdc9b-20210414
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1816240359; Wed, 14 Apr 2021 11:05:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Apr 2021 11:05:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Apr 2021 11:05:33 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <mkubecek@suse.cz>, <linux-kernel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <emamd001@umn.edu>, <josef@toxicpanda.com>,
        <kjlu@umn.edu>, <linux-block@vger.kernel.org>,
        <navid.emamdoost@gmail.com>, <nbd@other.debian.org>,
        <smccaman@umn.edu>, <mark-pk.tsai@mediatek.com>,
        <jy.ho@mediatek.com>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v3] nbd_genl_status: null check for nla_nest_start
Date:   Wed, 14 Apr 2021 11:05:32 +0800
Message-ID: <20210414030532.22451-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191021064210.GD27784@unicorn.suse.cz>
References: <20191021064210.GD27784@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4A00A68432B36DCE715F97B2FDE1AB765143FFB8F4A5D93CA4CA4541DAEAFCC62000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Michal Kubecek <mkubecek@suse.cz>

Hi,

I found that CVE-2019-16089 still exist in upstream kernel.
Does anyone know why this patch was not merged?


