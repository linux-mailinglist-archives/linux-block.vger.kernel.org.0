Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 977AD164B44
	for <lists+linux-block@lfdr.de>; Wed, 19 Feb 2020 17:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBSQ75 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 19 Feb 2020 11:59:57 -0500
Received: from avon.wwwdotorg.org ([104.237.132.123]:32954 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSQ75 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:59:57 -0500
Received: from [10.20.204.51] (unknown [216.228.112.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPSA id 7C4F21C092D;
        Wed, 19 Feb 2020 09:59:55 -0700 (MST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at avon.wwwdotorg.org
Subject: Re: [PATCH v1] partitions/efi: Add 'gpt_sector' kernel cmdline
 parameter
To:     Christoph Hellwig <hch@infradead.org>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>,
        Colin Cross <ccross@android.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-efi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200219162339.16192-1-digetx@gmail.com>
 <20200219162738.GA10644@infradead.org>
From:   Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <f9e41108-7811-0deb-6977-be0f60e23b52@wwwdotorg.org>
Date:   Wed, 19 Feb 2020 09:59:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200219162738.GA10644@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/19/20 9:27 AM, Christoph Hellwig wrote:
> On Wed, Feb 19, 2020 at 07:23:39PM +0300, Dmitry Osipenko wrote:
>> The gpt_sector=<sector> causes the GPT partition search to look at the
>> specified sector for a valid GPT header if the GPT is not found at the
>> beginning or the end of block device.
>>
>> In particular this is needed for NVIDIA Tegra consumer-grade Android
>> devices in order to make them usable with the upstream kernel because
>> these devices use a proprietary / closed-source partition table format
>> for the EMMC and it's impossible to change the partition's format. Luckily
>> there is a GPT table in addition to the proprietary table, which is placed
>> in uncommon location of the EMMC storage and bootloader passes the
>> location to kernel using "gpt gpt_sector=<sector>" cmdline parameters.
>>
>> This patch is based on the original work done by Colin Cross for the
>> downstream Android kernel.
> 
> I don't think a magic command line is the way to go.  The best would be
> to reverse-engineer the proprietary partition table format.  If that is
> too hard we can at least key off the odd GPT location based of it's
> magic number.

I thought that the backup GPT was always present in the standard 
location; it's just the primary GPT that's in an odd location. So, this 
kernel parameter just forces the kernel to look first for the primary 
GPT in the unusual location, thus avoiding an error message when that's 
not there, and the system falls back to the backup GPT.

Or, do I misremember the layout, or the kernel's behaviour if primary 
GPT is missing?
