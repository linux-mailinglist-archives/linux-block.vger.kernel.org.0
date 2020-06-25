Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FBE20A061
	for <lists+linux-block@lfdr.de>; Thu, 25 Jun 2020 15:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405082AbgFYN5U (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 25 Jun 2020 09:57:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:35540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404890AbgFYN5U (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 09:57:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6CA1EAD11;
        Thu, 25 Jun 2020 13:57:19 +0000 (UTC)
Subject: Re: SCSI sync unsupported: who's guilty?
To:     Janpieter Sollie <janpieter.sollie@kabelmail.de>,
        linux-block@vger.kernel.org
References: <9b8fac70-ace7-a625-0c1d-e48f52bd2e99@kabelmail.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <cd82e068-5884-7f91-1c11-27f9d8805b65@suse.de>
Date:   Thu, 25 Jun 2020 15:57:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <9b8fac70-ace7-a625-0c1d-e48f52bd2e99@kabelmail.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/25/20 1:51 PM, Janpieter Sollie wrote:
> Hi everyone,
> During testing of bcachefs with a aacraid controller, I encountered the following issue: The
> bcachefs kernel thread reports a critical IO error due to aacraid disabling SCSI command
> SYNCHRONIZE_CACHE by default.
> Who should handle those cases?
> - adapter: does it need to "discard" the invalid CDB and act like it completed successfully?
> - aacraid: enable when explicity requested?
> - block: does it need to "skip" the block error and move on?
> - kernel thread: "ignore" the error?
> I have no idea what the proper way to do here would be.  Anyone who does?
> Janpieter.
> 
> 
This would be more properly redirected to the linux-scsi mailing list;
but anyway I think your problem should be solved by passing the module 
parameter 'aac_cache=6' to the aacraid module.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
