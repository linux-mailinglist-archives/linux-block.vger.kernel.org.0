Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0911AAC6
	for <lists+linux-block@lfdr.de>; Wed, 11 Dec 2019 13:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfLKMaG (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 11 Dec 2019 07:30:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:40000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727477AbfLKMaG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 07:30:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDB67AE50;
        Wed, 11 Dec 2019 12:30:04 +0000 (UTC)
Subject: Re: [PATCH v6 1/3] xenbus/backend: Add memory pressure handler
 callback
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        SeongJae Park <sj38.park@gmail.com>
Cc:     axboe@kernel.dk, konrad.wilk@oracle.com,
        SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191211042428.5961-1-sjpark@amazon.de>
 <20191211042657.6037-1-sjpark@amazon.de> <20191211114651.GN980@Air-de-Roger>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <f626a29c-e307-38c8-b08d-471ad9b871e4@suse.com>
Date:   Wed, 11 Dec 2019 13:30:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211114651.GN980@Air-de-Roger>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11.12.19 12:46, Roger Pau Monné wrote:
> On Wed, Dec 11, 2019 at 04:26:57AM +0000, SeongJae Park wrote:
>> +
>>   	return 0;
>>   }
>>   subsys_initcall(xenbus_probe_backend_init);
>> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
>> index 869c816d5f8c..196260017666 100644
>> --- a/include/xen/xenbus.h
>> +++ b/include/xen/xenbus.h
>> @@ -104,6 +104,7 @@ struct xenbus_driver {
>>   	struct device_driver driver;
>>   	int (*read_otherend_details)(struct xenbus_device *dev);
>>   	int (*is_ready)(struct xenbus_device *dev);
>> +	void (*reclaim)(struct xenbus_device *dev);
> 
> reclaim_memory (if Juergen agrees).

I do agree.


Juergen
