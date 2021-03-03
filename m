Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5932AE8E
	for <lists+linux-block@lfdr.de>; Wed,  3 Mar 2021 03:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhCBXqV (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Mar 2021 18:46:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:41930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351177AbhCBNe7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Mar 2021 08:34:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB4EBAF78;
        Tue,  2 Mar 2021 13:20:08 +0000 (UTC)
To:     "Norman.Kern" <norman.kern@gmx.com>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <9b7dfd49-67b0-53b1-96e1-3b90c2d9d09a@gmx.com>
From:   Coly Li <colyli@suse.de>
Subject: Re: Large latency with bcache for Ceph OSD(new mail thread)
Message-ID: <f6755b89-4d13-92a5-df1a-343602dec957@suse.de>
Date:   Tue, 2 Mar 2021 21:20:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <9b7dfd49-67b0-53b1-96e1-3b90c2d9d09a@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/2/21 6:20 PM, Norman.Kern wrote:
> Sorry for creating a new mail thread(the origin is so long...)
> 
> 
> I made a test again and get more infomation:
> 
> root@WXS0089:~# cat /sys/block/bcache0/bcache/dirty_data
> 0.0k
> root@WXS0089:~# lsblk /dev/sda
> NAME      MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
> sda         8:0    0 447.1G  0 disk
> `-bcache0 252:0    0  10.9T  0 disk
> root@WXS0089:~# cat /sys/block/sda/bcache/priority_stats
> Unused:         1%
> Clean:          29%
> Dirty:          70%
> Metadata:       0%
> Average:        49
> Sectors per Q:  29184768
> Quantiles:      [1 2 3 5 6 8 9 11 13 14 16 19 21 23 26 29 32 36 39 43 48 53 59 65 73 83 94 109 129 156 203]
> root@WXS0089:~# cat /sys/fs/bcache/066319e1-8680-4b5b-adb8-49596319154b/internal/gc_after_writeback
> 1
> You have new mail in /var/mail/root
> root@WXS0089:~# cat /sys/fs/bcache/066319e1-8680-4b5b-adb8-49596319154b/cache_available_percent
> 28
> 
> I read the source codes and found if cache_available_percent > 50, it should wakeup gc while doing writeback, but it seemed not work right.
> 

If gc_after_writeback is enabled, and after it is enabled and the cache
usage > 50%, a tag BCH_DO_AUTO_GC will be set to c->gc_after_writeback.
Then when the writeback completed the gc thread will wake up in force.

so the auto gc after writeback will be triggered when,
1, the bcache device is in writeback mode
2, gc_after_writeback set to 1
3, After 2) done, the cache usage exceeds 50% threshold.
4, writeback rate set to maximum rate when the bcache device is idle (no
regular I/O request)
5, after the writeback accomplished, the gc thread will be waken up.

But /sys/block/bcache0/bcache/dirty_data is 0.0k doesn't mean the
writeback is accomplished. It is possible the writeback thread still
goes through all btree keys for the last try even all the dirty data are
flushed. Therefore you should check whether the writeback thread is
still active before a conclusion is made that the writeback is completed.

BTW, do you try a Linux v5.8+ kernel and see how things are ?

Thanks.

Coly Li
