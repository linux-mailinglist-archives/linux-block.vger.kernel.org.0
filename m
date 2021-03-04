Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556A132D34D
	for <lists+linux-block@lfdr.de>; Thu,  4 Mar 2021 13:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbhCDMf3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 4 Mar 2021 07:35:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:55696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240994AbhCDMfU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Mar 2021 07:35:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D10AAE47;
        Thu,  4 Mar 2021 12:34:39 +0000 (UTC)
Subject: Re: [PATCH v8 08/16] lpfc: vmid: Add support for vmid in mailbox
 command, does vmid resource allocation and vmid cleanup
To:     Muneendra <muneendra.kumar@broadcom.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
 <1614835646-16217-9-git-send-email-muneendra.kumar@broadcom.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <3560411e-8a5b-1e0c-aa76-affb7488f145@suse.de>
Date:   Thu, 4 Mar 2021 13:34:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1614835646-16217-9-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/21 6:27 AM, Muneendra wrote:
> From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> 
> This patch does the following -
> 1.adds supporting datastructures for mailbox command which helps in
> determining if the firmware supports appid or not.
> 2.This patch allocates the resource for vmid and checks if the firmware
> supports the feature or not.
> 3.The patch cleans up the vmid resources and stops the timer.
> 
> Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> ---
> v8:
> Added new function declaration, return error code and
> memory allocation API changes
> 
> v7:
> No change
> 
> v6:
> Added Forward declarations and functions to static
> 
> v5:
> Merged patches 8 and 11 of v4 to this patch
> Changed Return code to non-numeric/Symbol
> 
> v4:
> No change
> 
> v3:
> No change
> 
> v2:
> Ported the patch on top of 5.10/scsi-queue
> ---
>   drivers/scsi/lpfc/lpfc_hw4.h  | 12 +++++++
>   drivers/scsi/lpfc/lpfc_init.c | 66 +++++++++++++++++++++++++++++++++++
>   drivers/scsi/lpfc/lpfc_mbox.c |  6 ++++
>   drivers/scsi/lpfc/lpfc_scsi.c | 21 +++++++++++
>   drivers/scsi/lpfc/lpfc_sli.c  |  9 +++++
>   5 files changed, 114 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
