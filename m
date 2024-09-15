Return-Path: <linux-block+bounces-11675-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982FD9798B6
	for <lists+linux-block@lfdr.de>; Sun, 15 Sep 2024 22:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD17281F87
	for <lists+linux-block@lfdr.de>; Sun, 15 Sep 2024 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC7322334;
	Sun, 15 Sep 2024 20:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JC3UHWSB"
X-Original-To: linux-block@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0633EA69
	for <linux-block@vger.kernel.org>; Sun, 15 Sep 2024 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726432357; cv=none; b=EdweIgWBZ7eeEflFfyV4n7SDbP4/PPeM4VMNmOzONi4dLDDmMOOsXJCf2nK/kb+srkqj81uxDPPJFRsrpgTavIx+im5wU8rSXcDINVl+vVyiWg3++fA8UeRQ/Gyg6btn8dT0k11ZR7ZaON1a8dXumvG9rSLpLcSSvBhef30+L3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726432357; c=relaxed/simple;
	bh=a8qUJ8Sm5t1yd934wra0SGfS/kNYzYpHbuN05xQcH9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDm7h/imJ9AO1ERoX8W645fBxLfRVkI+09WCxp/7bF4mcW4qiwRmg1Hofk6krWssj2OiyIkVokpIPmbhQeNefzuzhVeOwI4BD3yqeow9vj/NsUMCwHUTV8RddwXJKMlMh3sT9DWBKNgpOc5L2YVS2BzLYUzjA1iE8j1OpFXqeso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JC3UHWSB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-205659dc63aso36995575ad.1
        for <linux-block@vger.kernel.org>; Sun, 15 Sep 2024 13:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726432354; x=1727037154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bFpdsxfx1Ace/q4aasi99xOr7vx0867TrczqjNMxQY=;
        b=JC3UHWSBQ++hPq725lNzqNvMf+3GTzsXYytZtAGBjAd+8ajPqEubBps98zQ4ZY0R1w
         NXaljXTq4pB6iUNRdqEBdbnvYv+ZCO2uGyAJkpoOoYUxLleS1y4Uz2VK/Bphg2mBv/9y
         BpAINSuXB5cPHTWUSTE+QU0+DCKgFxOmWt3sF9CPJ8M9YeSHoGDXFQdDjtfzGpOE8cOr
         If5uLxX2xt3eTJmVmEIdNkLzjQgs7IMviPzmVXhHcF18F/eUHfZXfpADi8ZrRDEHilZB
         V4bV/nhsdbJ5NX8I0a7dstSPD3wefxKGzAagrb1bCIluwJrIrSOK6CKVt33vV+FfR5/K
         iQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726432354; x=1727037154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bFpdsxfx1Ace/q4aasi99xOr7vx0867TrczqjNMxQY=;
        b=STsodAtG3iUjytNKJytQ113SiIyy6Zr9Ru08PXHtOYHc8onH7Jg+5NzCxiBRTH/hst
         +U8KK15lfM9ObYQ+k37PcjKIOSV0byngMrZ2jzU89D4vDD5AGPIjetM0IbTg4euZA105
         HbKyHQ9pxnq1NH4Vh7QI7LBEGoYynivaTCrjXLygzqBtTfBtOSzWW0ZvXDr1xZo4B2o8
         jP3AG/zDrrkzQ74R9k/7yvLgvY8AlOwdoa0d0jnKoWP8oRC4Rh8fIJ4EWk2FPt5GA6LR
         G6Re5tod+7dlHVP7DAxE36mhvwbvsUAob9OVuQ9j3+crynkhQIiwKfVwbJGwDUNKtx2i
         2uUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0qrN8JQomR85JabUGxHXEBtgbFSC2TpWr2QoQo329XHkfJSpnsjKuo3HEJPQhk6sXqz8Reol/+7eSug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqC3gWvhc9iT7Ub8XxJQMjzjM095GZ2SAxqm2sY0EK3r675w2
	IzmA6q7oo01K9EK1ppdV5zbxzIsQBdSxKHf6um6TEilgA/w3MjNYSKOcMYK01zo=
X-Google-Smtp-Source: AGHT+IFqzpuwo8+eE5vUuJR+DujfLNGM59YFl+GDSbrA+peia+5jh6zgtexzrlgiRgj766UReKE8nQ==
X-Received: by 2002:a17:902:d2d2:b0:205:8a1a:53eb with SMTP id d9443c01a7336-2076e39c2e4mr194842025ad.18.1726432353601;
        Sun, 15 Sep 2024 13:32:33 -0700 (PDT)
Received: from [172.16.7.106] ([63.78.52.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9c3f57esm5730249a91.8.2024.09.15.13.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 13:32:32 -0700 (PDT)
Message-ID: <0bd0be63-5595-4aae-829f-6b278a5b5e60@kernel.dk>
Date: Sun, 15 Sep 2024 14:32:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] blk-mq: introduce blk_mq_hctx_map_queues
To: Bjorn Helgaas <helgaas@kernel.org>, Daniel Wagner <wagi@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
 megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
 MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de,
 Ming Lei <ming.lei@redhat.com>
References: <20240913162654.GA713813@bhelgaas>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240913162654.GA713813@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/13/24 10:26 AM, Bjorn Helgaas wrote:
> On Fri, Sep 13, 2024 at 09:41:59AM +0200, Daniel Wagner wrote:
>> From: Ming Lei <ming.lei@redhat.com>
>>
>> blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
>> hardware queue mapping based on affinity information. These two
>> function share code which only differs on how the affinity information
>> is retrieved. Also there is the hisi_sas which open codes the same loop.
>>
>> Thus introduce a new helper function for creating these mappings which
>> takes an callback function for fetching the affinity mask. Also
>> introduce common helper function for PCI and virtio devices to retrieve
>> affinity masks.
> 
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index e3a49f66982d..84f9c16b813b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -6370,6 +6370,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>>  	return 0;
>>  }
>>  
>> +#ifdef CONFIG_BLK_MQ_PCI
>> +/**
>> + * pci_get_blk_mq_affinity - get affinity mask queue mapping for PCI device
>> + * @dev_data:	Pointer to struct pci_dev.
>> + * @offset:	Offset to use for the pci irq vector
>> + * @queue:	Queue index
>> + *
>> + * This function returns for a queue the affinity mask for a PCI device.
>> + * It is usually used as callback for blk_mq_hctx_map_queues().
>> + */
>> +const struct cpumask *pci_get_blk_mq_affinity(void *dev_data, int offset,
>> +					      int queue)
>> +{
>> +	struct pci_dev *pdev = dev_data;
>> +
>> +	return pci_irq_get_affinity(pdev, offset + queue);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_get_blk_mq_affinity);
>> +#endif
> 
> IMO this doesn't really fit well in drivers/pci since it doesn't add
> any PCI-specific knowledge or require any PCI core internals, and the
> parameters are blk-specific.  I don't object to the code, but it seems
> like it could go somewhere in block/?

Probably not a bad idea.

Unrelated to that topic, but Daniel, all your email gets marked as spam.
I didn't see your series before this reply. This has been common
recently for people that haven't kept up with kernel.org changes, please
check for smtp changes there.

-- 
Jens Axboe

