Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A177D2D0560
	for <lists+linux-block@lfdr.de>; Sun,  6 Dec 2020 15:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLFOGh (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 6 Dec 2020 09:06:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:39518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727696AbgLFOGh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 6 Dec 2020 09:06:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9B467ADD7;
        Sun,  6 Dec 2020 14:05:55 +0000 (UTC)
Subject: Re: [PATCH 3/3] block: set REQ_PREFLUSH to the final bio from
 __blkdev_issue_zero_pages()
To:     Tom Yan <tom.ty89@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20201206055332.3144-1-tom.ty89@gmail.com>
 <20201206055332.3144-3-tom.ty89@gmail.com>
 <2eb8f838-0ec6-3e70-356b-8c04baba2fc4@suse.de>
 <CAGnHSEk0C6VNQysGiysPS1yEXwu4U8PVCaVB2RR7oEgnr4Xz=w@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4304d959-9155-3126-a858-28b338968916@suse.de>
Date:   Sun, 6 Dec 2020 15:05:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAGnHSEk0C6VNQysGiysPS1yEXwu4U8PVCaVB2RR7oEgnr4Xz=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/20 2:32 PM, Tom Yan wrote:
> Why? Did you miss that it is in the condition where
> __blkdev_issue_zero_pages() is called (i.e. it's not WRITE SAME but
> WRITE). From what I gathered REQ_PREFLUSH triggers a write back cache
> (that is on the device; not sure about dirty pages) flush, wouldn't it
> be a right thing to do after we performed a series of WRITE (which is
> more or less purposed to get a drive wiped clean).
> 

But what makes 'zero_pages' special as compared to, say, WRITE_SAME?
One could use WRITE SAME with '0' content, arriving at pretty much the 
same content than usine zeroout without unmapping. And neither of them 
worries about cache flushing.
Nor should they, IMO.

These are 'native' block layer calls, providing abstract accesses to 
hardware functionality. If an application wants to use them, it would be 
the task of the application to insert a 'flush' if it deems neccessary.
(There _is_ blkdev_issue_flush(), after all).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
