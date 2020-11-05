Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31B22A7825
	for <lists+linux-block@lfdr.de>; Thu,  5 Nov 2020 08:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKEHml (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Nov 2020 02:42:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:32812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729369AbgKEHml (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Nov 2020 02:42:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3716EAB95;
        Thu,  5 Nov 2020 07:42:40 +0000 (UTC)
Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
To:     "hch@lst.de" <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Klaus B. Jensen" <k.jensen@samsung.com>,
        "Niklas.Cassel@wdc.com" <Niklas.Cassel@wdc.com>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102180836.GC20182@lst.de>
 <20201102183355.GB1970293@dhcp-10-100-145-180.wdc.com>
 <20201102185851.GA21349@lst.de>
 <23e10fd1-d20c-cf77-4dc0-dd8b0774fd7a@suse.de> <20201104142908.GA7941@lst.de>
 <01c72262-1839-05cc-ba9a-94b260511a7c@suse.de> <20201105073737.GA4747@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6e584b6a-776f-1e3b-5716-152685a6ac5d@suse.de>
Date:   Thu, 5 Nov 2020 08:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201105073737.GA4747@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/5/20 8:37 AM, hch@lst.de wrote:
> On Wed, Nov 04, 2020 at 03:46:02PM +0100, Hannes Reinecke wrote:
>> ... as would a bsg device which could accept said ioctl ...
> 
> Sure we could.  So we'd have to add more code to almost 1000 lines of
> code in bsg that are not useful to the nvme use case to make it useful
> for that use case.  Or we could just add about 50 lines of code to NVMe
> to do the right thing.
> My point wasn't so much that it'd be easier to code.
Just wanted to point out how we've argued in the past.

But anyway: you are the maintainer, you get to decide.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
