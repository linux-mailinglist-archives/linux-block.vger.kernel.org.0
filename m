Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72F1317A19E
	for <lists+linux-block@lfdr.de>; Thu,  5 Mar 2020 09:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCEInP (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Mar 2020 03:43:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbgCEInO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Mar 2020 03:43:14 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DD93BD35DA42EBB842B0;
        Thu,  5 Mar 2020 16:43:11 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.66) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Mar 2020
 16:43:08 +0800
Subject: Re: [PATCH blktests] nbd/003: improve the test
To:     Omar Sandoval <osandov@osandov.com>
CC:     <linux-block@vger.kernel.org>, <osandov@fb.com>
References: <20200224042728.31886-1-sunke32@huawei.com>
 <20200305013554.GC293405@vader>
From:   "sunke (E)" <sunke32@huawei.com>
Message-ID: <5dd5e067-346b-1f4b-b959-6cd67c4bdfa0@huawei.com>
Date:   Thu, 5 Mar 2020 16:43:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200305013554.GC293405@vader>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



ÔÚ 2020/3/5 9:35, Omar Sandoval Ð´µÀ:
> On Mon, Feb 24, 2020 at 12:27:28PM +0800, Sun Ke wrote:
>> Modify the DESCRIPTION, remove the umount and add rm.
>>
>> Signed-off-by: Sun Ke <sunke32@huawei.com>
>> ---
>>   tests/nbd/003 | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/nbd/003 b/tests/nbd/003
>> index 57fb63a..49ca30e 100644
>> --- a/tests/nbd/003
>> +++ b/tests/nbd/003
>> @@ -7,7 +7,7 @@
>>   
>>   . tests/nbd/rc
>>   
>> -DESCRIPTION="mount/unmount concurrently with NBD_CLEAR_SOCK"
>> +DESCRIPTION="connected by ioctl, mount/unmount concurrently with NBD_CLEAR_SOCK"
>>   QUICK=1
>>   
>>   requires() {
>> @@ -23,8 +23,8 @@ test() {
>>   
>>   	mkdir -p "${TMPDIR}/mnt"
>>   	src/mount_clear_sock /dev/nbd0 "${TMPDIR}/mnt" ext4 5000
>> -	umount "${TMPDIR}/mnt" > /dev/null 2>&1
> 
> Is the umount causing problems?
No, it do not cause problems, but it is redundant.
> 
>>   
>>   	nbd-client -d /dev/nbd0 >> "$FULL" 2>&1
>> +	rm -rf "${TMPDIR}/mnt"
> 
> The test harness already removes the TMPDIR directory. Why is this
> necessary?
>
I see.

Thanks,
Sun Ke


