Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD72E70FA
	for <lists+linux-block@lfdr.de>; Tue, 29 Dec 2020 14:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgL2NsT (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Dec 2020 08:48:19 -0500
Received: from mx.rz.hs-furtwangen.de ([141.28.2.11]:60460 "EHLO
        mx.rz.hs-furtwangen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgL2NsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Dec 2020 08:48:19 -0500
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Dec 2020 08:48:18 EST
Received: from mx.rz.hs-furtwangen.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id E59E5618D3
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 14:41:00 +0100 (CET)
Received: from mail.rz.hs-furtwangen.de (mail.rz.hs-furtwangen.de [141.28.2.16])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.rz.hs-furtwangen.de (Postfix) with ESMTPS
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 14:41:00 +0100 (CET)
Received: from [192.168.11.84] (p4ffb2d34.dip0.t-ipconnect.de [79.251.45.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.rz.hs-furtwangen.de (Postfix) with ESMTPSA id BD18426087D
        for <linux-block@vger.kernel.org>; Tue, 29 Dec 2020 14:41:00 +0100 (CET)
To:     linux-block@vger.kernel.org
From:   Stefan Lederer <lederers@hs-furtwangen.de>
Subject: How to utilize a PCIE4.0 SSD?
Message-ID: <eeaa8871-59f5-a56a-f4e5-723c91ac8d5a@hs-furtwangen.de>
Date:   Tue, 29 Dec 2020 14:40:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2020.12.29.133316, AntiVirus-Engine: 5.79.0, AntiVirus-Data: 2020.12.29.5790000
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello dear list,

(I hope I do not annoy you as a simple application programmer)

for a seminar paper at my university we reproduced the 2009 paper
"Pathologies of big data" by Jacobs, where he basically reads a
100GB file sequentially from a HDD with some light processing.

We have a PCIE4.0 SSD with up to 7GB/s reading (Samsung 980) but
nothing we programmed so far comes even close to that speed (regular
read(), mmap() with optional threads, io_uring, multi-process) so we
wonder if it is possible at all?

According to iostat mmap is the fastest with 4GB/s and a queue depth
of ~3. All other approaches do not go beyond 2.5GB/s.

Also we get some strange effects like sequential read() with 16KB
buffers being faster than one with 16MB and io_uring being alot
slower than mmap (all tested on Manjaro with kernel 5.8/5.10 and ext4).

So, now we are quite lost and would appreciate a hint into the right
direction :)

What is neccesary to simply read 100GB of data at 7GB/s?

I wish everybody a happy new year!
Stefan Lederer
