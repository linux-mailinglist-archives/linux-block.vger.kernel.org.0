Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5996AAA434
	for <lists+linux-block@lfdr.de>; Thu,  5 Sep 2019 15:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbfIENVC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Sep 2019 09:21:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731556AbfIENVC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Sep 2019 09:21:02 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 565F7AF1611654BC1043;
        Thu,  5 Sep 2019 21:21:00 +0800 (CST)
Received: from [127.0.0.1] (10.184.194.169) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 21:20:56 +0800
Subject: Re: [PATCH blktests] nbd/003:add mount and clear_sock test for nbd
To:     Omar Sandoval <osandov@osandov.com>
CC:     <osandov@fb.com>, <linux-block@vger.kernel.org>
References: <1567567949-87156-1-git-send-email-sunke32@huawei.com>
 <20190904174240.GC7452@vader>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <4b69a3fd-c02b-f1ec-1582-cafc9bf04edd@huawei.com>
Date:   Thu, 5 Sep 2019 21:20:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190904174240.GC7452@vader>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.194.169]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Omar,

     The test creates 15 nbd connections, so the problem will reappear 
soon, takes about one minute. However, if only creat one connection, it 
takes about 15 minutes or more to reappear. So, can not only use one 
connection and just repeat the test 15 times.

