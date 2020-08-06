Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EFF23D435
	for <lists+linux-block@lfdr.de>; Thu,  6 Aug 2020 01:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgHEXib (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 5 Aug 2020 19:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgHEXi3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Aug 2020 19:38:29 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA512C061574
        for <linux-block@vger.kernel.org>; Wed,  5 Aug 2020 16:38:28 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id w9so35064971qts.6
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2020 16:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tS465+e6GdpvKXllM7bMAFesYQVtVvr90Wm9oFWZvYA=;
        b=SUpGuGhyy9MWMCjSY3MQXKQwn2vphZjE9gR1oXTVpRbSBjybhZl3fCgneev4QSO3FI
         QlhGBfqL62kWE9DYryav6vu02+DI6jPWC9heHagIGcVqUoL+RIlBXokA0JXxecSJmbcl
         I8nRjS15+WQlEd1BP7F7ojPGi4uYE3afafjqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tS465+e6GdpvKXllM7bMAFesYQVtVvr90Wm9oFWZvYA=;
        b=KRMzU5ktuWOLdVrtMMO1wCN9r4pSMJ9WWNdaBjkGJJHnJw2e2W0ILLckcubplYkYmr
         7jLtzyc1X7rJDD51sOkdTxo77Ihn789QeQuB/zsv46SPLvJFqTSiZW3YSOSdZTGfQ+2r
         68YMFIAx8fBG0ZxeQEeZWSYxR2MuZwxNqbk6VWn3VERg2/gc5PxxyFQz6L/CFpo0mFPk
         6CqvWBsuDtkItsoJUeVYniS3JrAl+LpMIqaCxWzmYOcb+wSSlnYDJ0KpQQOCUXtkzrMw
         JbcCpeoJA2wu9fPwjLbEDqtXEvlKgm+VJ2fvMCJEkjeUQ8tAya0gjNsdeEm47eHDb830
         wPig==
X-Gm-Message-State: AOAM5339Skb0kxYa9ervT2fnBHdlEbDfeNYj24NFCpY52/zBJCQSQ6O6
        fk/po5XrvCcKzR6f7Q9elWVH8w==
X-Google-Smtp-Source: ABdhPJz4BHWcX7OF29gUAJUEkfOy/P6pLCcS6qg2O+FjGLpzvm8qQi14ba9FmEVrP9DSIu1QTDXWsA==
X-Received: by 2002:aed:33e7:: with SMTP id v94mr5922334qtd.18.1596670707359;
        Wed, 05 Aug 2020 16:38:27 -0700 (PDT)
Received: from [192.168.1.42] (ip68-5-85-189.oc.oc.cox.net. [68.5.85.189])
        by smtp.gmail.com with ESMTPSA id t12sm2799399qkt.56.2020.08.05.16.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 16:38:26 -0700 (PDT)
Subject: Re: [RFC 16/16] lpfc: vmid: Introducing vmid in io path.
To:     Hannes Reinecke <hare@suse.de>,
        Muneendra <muneendra.kumar@broadcom.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     pbonzini@redhat.com, emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
 <1596507196-27417-17-git-send-email-muneendra.kumar@broadcom.com>
 <61d2fd75-84ea-798b-aee9-b07957ac8f1b@suse.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <08b9825b-6abb-c077-ac0d-bd63f10f2ac2@broadcom.com>
Date:   Wed, 5 Aug 2020 16:38:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <61d2fd75-84ea-798b-aee9-b07957ac8f1b@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/5/2020 12:16 AM, Hannes Reinecke wrote:
> Well.
>
> Creating a VMID in the hotpath with a while() loop will be bogging 
> down performance to no end.
> I'd rather have restricted the ->queuecommand() function to a direct 
> lookup.
> If that fails (as the VMID isn't registered) we should kicking of a 
> workqueue for registering the VMID and return BUSY.
> Or tweak blkcg to register the VMID directly, and reject the command 
> if the VMID isn't registered :-)
>
> Cheers,
>
> Hannes

That's actually what's supposed to be happening. fastpath uses the uuid 
to look up a vmid tag. If no vmid tag, kick off the fabric traffic that 
will get one but don't wait for it to complete. Any io issued while that 
process is occurring will be not be vmid tagged.    I'll circle back on 
lpfc to make sure this is happening.

In the mean time - the most important patch to review is the cgroup 
patch - patch1.

If we wanted to speed the driver's io path up, one thing to consider is 
adding a driver-settable value on the blkcg structure.  Once the fabric 
traffic obtained the vmid, the driver would set the blkcg structure with 
the value.  In this scenario though, as the vmid is destroyed as of link 
down, the driver needs a way, independent of an io, to reach into the 
blkcg struct to clear the vmid value.  We also need to be sure the blkcg 
struct won't be on top of a multipath device or something such that the 
blkcg struct may be referenced by a different scsi host - I assume we're 
good in that area.

-- james
