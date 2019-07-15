Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1E69875
	for <lists+linux-block@lfdr.de>; Mon, 15 Jul 2019 17:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfGOPk4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 15 Jul 2019 11:40:56 -0400
Received: from ale.deltatee.com ([207.54.116.67]:55688 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfGOPk4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 11:40:56 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hn35q-00066X-Pe; Mon, 15 Jul 2019 09:40:47 -0600
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Stephen Bates <sbates@raithlin.com>
References: <20190712235742.22646-1-logang@deltatee.com>
 <20190712235742.22646-8-logang@deltatee.com> <20190715071522.GB4495@x250>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e1008f94-1cb7-8619-bbdd-802968e9402d@deltatee.com>
Date:   Mon, 15 Jul 2019 09:40:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190715071522.GB4495@x250>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, tytso@mit.edu, mmoese@suse.de, chaitanya.kulkarni@wdc.com, osandov@fb.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, jthumshirn@suse.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH blktests 07/12] nvme/018: Ignore error message generated
 by nvme read]
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-07-15 1:15 a.m., Johannes Thumshirn wrote:
> On Fri, Jul 12, 2019 at 05:57:37PM -0600, Logan Gunthorpe wrote:
>> nvme-cli at some point started printing the error message:
>>
>>   NVMe status: CAP_EXCEEDED: The execution of the command has caused the
>> 	capacity of the namespace to be exceeded(0x6081)
>>
>> This was not accounted for by test 018 and caused it to fail.
>>
>> This test does not need to test the error message content, it's
>> only important that a read past the end of the file fails. Therefore,
>> pipe stderr of nvme-cli to /dev/null.
> 
> How about redirecting all of the output to $FULL?

Sure, I'll update it and send a v2.

Logan

