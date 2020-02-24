Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A7D16A9D4
	for <lists+linux-block@lfdr.de>; Mon, 24 Feb 2020 16:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgBXPUc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Feb 2020 10:20:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39236 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgBXPUc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 10:20:32 -0500
Received: by mail-pf1-f195.google.com with SMTP id 84so5519946pfy.6
        for <linux-block@vger.kernel.org>; Mon, 24 Feb 2020 07:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WDCkjGM3fgtW4JPiMGZTVGouytm+nwZx0bWaIv/hYVo=;
        b=ba1CO+08Yhhcpyh+okjqYADOHwpX5aGw9iAzq525IZ2jqUKRKWt1dME5+6+e7SzWjD
         SQNLvsL5rOC2yfk/RjYI6DQnoijrq0k04z4P3kc83GSfU1W306HxAyQCfFGOKvL08s7n
         BvyZTPLIG5cpiI6Hz4i7VVwiO90tujF+gPdpr0U4x1B4mP6njlDhqY8K7li4aYQySNBe
         P4E6udQNQcgDDT5Gyql+1uBTOP1HQdfzZQ+Gn/esflxhcpKSlWSmmUL/CZ50v1EreVve
         XKLzVLNlUuubbtpWZi39bSVXWp1aQxsjtdfoWKZcIGgR5cUPPriSB8vDv73ug7RHcKHM
         O75g==
X-Gm-Message-State: APjAAAXyANPioen0ba5x1bIbd16BCQlkEHWHFGoXKeqPnbzXhc8a3CGB
        tilImERZ7DYMANERHMr1yvo=
X-Google-Smtp-Source: APXvYqzs7yXo0KmypHmS8gZLODgtXGsVmL4xyKacEAl9PCoYaSRdGD/huT9qE8pSy9z5ACK9o8/jPg==
X-Received: by 2002:a63:e007:: with SMTP id e7mr52628098pgh.414.1582557630427;
        Mon, 24 Feb 2020 07:20:30 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:af99:b4cf:6b17:1075? ([2601:647:4000:d7:af99:b4cf:6b17:1075])
        by smtp.gmail.com with ESMTPSA id 188sm13214549pgf.24.2020.02.24.07.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 07:20:29 -0800 (PST)
Subject: Re: [PATCH v3 4/8] null_blk: Suppress an UBSAN complaint triggered
 when setting 'memory_backed'
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>
References: <20200221032243.9708-1-bvanassche@acm.org>
 <20200221032243.9708-5-bvanassche@acm.org>
 <BYAPR04MB5749D28FD6A0B9A3EB58652C86EC0@BYAPR04MB5749.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <486df5d9-501c-b552-2f94-28d978f6bffb@acm.org>
Date:   Mon, 24 Feb 2020 07:20:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB5749D28FD6A0B9A3EB58652C86EC0@BYAPR04MB5749.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/24/20 3:28 AM, Chaitanya Kulkarni wrote:
> On 2/20/20 7:23 PM, Bart Van Assche wrote:
>> Although it is not clear to me why UBSAN complains when 'memory_backed'
>> is set, this patch suppresses the UBSAN complaint that is triggered when
>> setting that configfs attribute.
>
> Is it due to "An uninitialized bool will have indeterminate value and using
> an indeterminate value is undefined behavior." ?

But where is the code that reads that boolean before it is set? I 
haven't found it. Hence the comment in the patch description.

Bart.
