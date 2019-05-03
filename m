Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4F81346F
	for <lists+linux-block@lfdr.de>; Fri,  3 May 2019 22:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfECUc1 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 3 May 2019 16:32:27 -0400
Received: from mailgw2.fjfi.cvut.cz ([147.32.9.131]:45470 "EHLO
        mailgw2.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECUc1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 May 2019 16:32:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTP id C8394A02D9;
        Fri,  3 May 2019 22:32:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1556915544; i=@fjfi.cvut.cz;
        bh=BJ8xtY5tE1UsjBZM+tJhGnLlyY1AyDM3NR5t6Yvpe8s=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=WwfGGluIBoqF6EAlVj5RHVGBy1aOQRCr4fBkBf5GCso+7mSB5/gxSuy7DIxCIS0Ti
         ouqp/SbK1ZV4sbt3dz5EDJEGpMykfLc/Vhj6bwFUXH9ArTGaLs7tEaEZyqAb54MPcy
         mW9DOyG+FqXKbPJicBnrG1fUdFPPQveWTFejQaWc=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw2.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw2.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id L4VnO6i2tLtK; Fri,  3 May 2019 22:32:21 +0200 (CEST)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw2.fjfi.cvut.cz (Postfix) with ESMTPS id 1CEDDA02D3;
        Fri,  3 May 2019 22:32:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw2.fjfi.cvut.cz 1CEDDA02D3
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id D8D9B6004D; Fri,  3 May 2019 22:32:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id C57C36002A;
        Fri,  3 May 2019 22:32:19 +0200 (CEST)
Date:   Fri, 3 May 2019 22:32:19 +0200 (CEST)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Christoph Hellwig <hch@infradead.org>,
        Scott Bauer <sbauer@plzdonthack.me>
cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 0/3] block: sed-opal: add support for shadow MBR done
 flag and write
In-Reply-To: <20190501134917.GC24132@infradead.org>
Message-ID: <alpine.LRH.2.21.1905032058110.30331@linux.fjfi.cvut.cz>
References: <1556666459-17948-1-git-send-email-zub@linux.fjfi.cvut.cz> <20190501134917.GC24132@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 1 May 2019, Christoph Hellwig wrote:

>> I successfully tested toggling the MBR done flag and writing the shadow MBR
>> using some tools I hacked together[4] with a Samsung SSD 850 EVO drive.
>
> Can you submit the tool to util-linux so that we get it into distros?

There is already Scott's sed-opal-temp[1] and a fork by Jonas that adds 
support for older version of these new IOCTLs[2]. There was already some 
discussion of getting that to util-linux.[3]

While I like my hack, sed-opal-temp can do much more (my tool supports 
just the few things I actually use). But there are two things which 
sed-opal-temp currently lacks which my hack has:

* It can use a PBKDF2 hash (salted by disk serial number) of the password
   rather than the password directly. This makes it compatible with sedutil
   and I think it's also better practice (as firmware can contain many
   surprises).

* It contains a 'PBA' (pre-boot authorization) tool. A tool intended to be
   run from shadow mbr that asks for a password and uses it to unlock all
   disks and set shadow mbr done flag, so after restart the computer boots
   into the real OS.

@Scott: What are your plans with sed-opal-temp? If you want I can update 
Jonas' patches to the adapted IOCTLs. What are your thoughts on PW hashing 
and a PBA tool?

Best regards,
David

[1] https://github.com/ScottyBauer/sed-opal-temp
[2] https://github.com/ghostav/sed-opal-temp
[3] https://lkml.org/lkml/2019/2/4/736
