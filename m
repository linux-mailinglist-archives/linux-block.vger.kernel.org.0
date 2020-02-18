Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFEC162D6D
	for <lists+linux-block@lfdr.de>; Tue, 18 Feb 2020 18:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBRRwZ (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Feb 2020 12:52:25 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53477 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgBRRwZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Feb 2020 12:52:25 -0500
Received: by mail-wm1-f46.google.com with SMTP id s10so3692621wmh.3
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2020 09:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=BPfhtFI4dL6bMuI+S7/9pZqCvnVzrtE24J1oai+Y2JE=;
        b=TQNwyIVaeGZAEy1lYknE5xsIAa0rBavt7l6Xmx/2bHlDBMOsXJwLPHQ964j4fuLcoz
         CPjx5zkQGtf+You9j0jK64MvycHq6vIu/zHfO94MzAx+dIz48bkC+5QGdC2Vrw7tTyxL
         SPBEpQ/1ADIBljRVGAuEJKqlyIAwoL+CBevbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=BPfhtFI4dL6bMuI+S7/9pZqCvnVzrtE24J1oai+Y2JE=;
        b=am9h5sWyVUvKVvNsmVAqLB4b9Tqx0gFvQLWTZtEtlyDyS+aMtIJHFMT/NC2i/hj4o7
         SpNskUFENYe6rkETS3olHunEM6c7GZSo/sfak5y7YY6zx+sunXwRlOnj0PTDpokq5Z3Q
         UPa2mV+ChDTLJLH8j7mXwBduOwA83DTb3G7yczOVGjNo8Zf9t/nDdJ0n/mUBTyyPCKpk
         9jFRf+UDWrddeAI7rj3Gm0DebctRmGwDV4EviwQvUNDMVbGc4epNSGtgkYzUG9OB5dXl
         ksOHA7IjD/wLFFD1j6GlSYpHN+tXqiE8yWmxQ6MiynHeRDcCNUzMrFgMfC8JyGyUSeGq
         vWeA==
X-Gm-Message-State: APjAAAXRdThptBo78Ezy5BC0xdMTKRt6JYNPGNApnE5RqW+EOY8wq9t6
        rFr+g2cQ1Rz+qRvWDa4zBDbrxQ==
X-Google-Smtp-Source: APXvYqxMH7yn1TaQwXwjUrc6VJrsiZ4MPGS2ygdZKaispo5YPjWBDjd2WX9yMvgr/UG2egQLmZi2uw==
X-Received: by 2002:a05:600c:2187:: with SMTP id e7mr4328310wme.11.1582048343034;
        Tue, 18 Feb 2020 09:52:23 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id v22sm4202888wml.11.2020.02.18.09.52.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 09:52:22 -0800 (PST)
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
To:     Keith Busch <kbusch@kernel.org>,
        Tim Walker <tim.t.walker@seagate.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
 <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
 <yq1r1yzqfyb.fsf@oracle.com> <2d66bb0b-29ca-6888-79ce-9e3518ee4b61@suse.de>
 <20200214144007.GD9819@redsun51.ssa.fujisawa.hgst.com>
 <d043a58d-6584-1792-4433-ac2cc39526ca@suse.de>
 <20200214170514.GA10757@redsun51.ssa.fujisawa.hgst.com>
 <CANo=J17Rve2mMLb_yJNFK5m8wt5Wi4c+b=-a5BJ5kW3RaWuQVg@mail.gmail.com>
 <20200218174114.GA17609@redsun51.ssa.fujisawa.hgst.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <57808194-dc89-a044-3778-bef607ebe6c8@broadcom.com>
Date:   Tue, 18 Feb 2020 09:52:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200218174114.GA17609@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2/18/2020 9:41 AM, Keith Busch wrote:
> On Tue, Feb 18, 2020 at 10:54:54AM -0500, Tim Walker wrote:
>> With regards to our discussion on queue depths, it's common knowledge
>> that an HDD choses commands from its internal command queue to
>> optimize performance. The HDD looks at things like the current
>> actuator position, current media rotational position, power
>> constraints, command age, etc to choose the best next command to
>> service. A large number of commands in the queue gives the HDD a
>> better selection of commands from which to choose to maximize
>> throughput/IOPS/etc but at the expense of the added latency due to
>> commands sitting in the queue.
>>
>> NVMe doesn't allow us to pull commands randomly from the SQ, so the
>> HDD should attempt to fill its internal queue from the various SQs,
>> according to the SQ servicing policy, so it can have a large number of
>> commands to choose from for its internal command processing
>> optimization.
> You don't need multiple queues for that. While the device has to fifo
> fetch commands from a host's submission queue, it may reorder their
> executuion and completion however it wants, which you can do with a
> single queue.
>   
>> It seems to me that the host would want to limit the total number of
>> outstanding commands to an NVMe HDD
> The host shouldn't have to decide on limits. NVMe lets the device report
> it's queue count and depth. It should the device's responsibility to
> report appropriate values that maximize iops within your latency limits,
> and the host will react accordingly.

+1 on Keith's comments. Also, if a ns depth limit needs to be 
introduced, it should be via the nvme committee and then reported back 
as device attributes. Many of SCSI's problems where the protocol didn't 
solve it, especially in multi-initiator environments, which made all 
kinds of requirements/mish-mashes on host stacks and target behaviors. 
none of that should be repeated.

-- james

