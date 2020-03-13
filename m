Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258F7184AAD
	for <lists+linux-block@lfdr.de>; Fri, 13 Mar 2020 16:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCMP1u (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 13 Mar 2020 11:27:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:44468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgCMP1u (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Mar 2020 11:27:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 090D9AAC2;
        Fri, 13 Mar 2020 15:27:49 +0000 (UTC)
Subject: Re: [PATCH] sata_fsl: fixup compilation errors
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Guenther Roeck <linux@roeck-us.net>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org
References: <20200313151722.74659-1-hare@suse.de>
 <50f5c462-e68d-ad99-4a76-bb72a126d43d@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <04f74bbf-7957-2e79-5236-1f8ee0549d99@suse.de>
Date:   Fri, 13 Mar 2020 16:27:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <50f5c462-e68d-ad99-4a76-bb72a126d43d@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/13/20 4:21 PM, Jens Axboe wrote:
> On 3/13/20 9:17 AM, Hannes Reinecke wrote:
>> Fixup compilation errors introduced by the libata DPRINTK rewrite.
> 
> How many more are we going to uncover? There's no excuse for not
> having even compiled this stuff, seriously.
> 
Well, I did, but I don't have a full cross-arch setup here.
Will be setting it up for any further libata updates, promise.

Sorry about this.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
