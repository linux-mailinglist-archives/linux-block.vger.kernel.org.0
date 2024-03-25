Return-Path: <linux-block+bounces-5024-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E72988A25A
	for <lists+linux-block@lfdr.de>; Mon, 25 Mar 2024 14:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DBF1F3C0E1
	for <lists+linux-block@lfdr.de>; Mon, 25 Mar 2024 13:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAD013A87A;
	Mon, 25 Mar 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfPij3gz"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBC13AA4E;
	Mon, 25 Mar 2024 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353153; cv=none; b=o2vcyWjgDx9JPrs5Zec0Ig+wJ0Sps6hjZ0+VcGsvw0xu/nuyRHu0vFx9lBO1oap5k0NcFyoui1vxHcmSbyYXxNUmGgBoBP4yNylaxD9TdRbQ88Hh3jgspau6dZBYiAIbAs0RaBk/CXNAVZj1oap2XPT1zfcFkHhUsVOjvLBmysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353153; c=relaxed/simple;
	bh=r51vGShS3f7UKkNKLXLhjmUVpqdreZEEL+dD3KcPW7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNgdIBBytljg8BPInUA7VxZisWC/fKXkF7QOGuD778CsBwkFxRcQqHnnfzr2Xaj+rWWSkNaRysEI6paPso38lSiWAIKa7k4XWqpaBkwrHz7zZE4aIKMa6ygLWiI/+Ed1970GVdMWHFnEwz7x+Gi1D28Q4jeBcQ8cCFSaFWbw/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfPij3gz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1373BC433F1;
	Mon, 25 Mar 2024 07:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711353152;
	bh=r51vGShS3f7UKkNKLXLhjmUVpqdreZEEL+dD3KcPW7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BfPij3gzbQeB41ZDZN7T0cMOgAXctXArUWJs2OpsA0Fsjop5N2gvJIJyM7jrmpaoy
	 MYD2/6QhYD6nRI9IC1yYKnLi3WOhv1AnfQyWtWECCVXCL7wsZRSDeTLi695hnomw8N
	 ekyeX37KrjXRkwzZPasLvFszBi91ADSsw7eNh1NyyE9E0XPd7WLSx/jIKFsbHrEZuz
	 D3OUPVQBMvnOjciF/QAGRFcPwxLUGS7zyWLUH2hIclgZuH1CH5wlcYlau6EHYBKwvD
	 iXpjmNoe0dwb7EtddH9cCu55jrDPkKr71w3WH9/DXMjjRMtAz34zukg+Gt1hvsGW6V
	 ZdQKu3PrSN5kw==
Message-ID: <06562b24-1397-4ac3-bb62-f2409503e956@kernel.org>
Date: Mon, 25 Mar 2024 16:52:25 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/23] libata: switch to using ->device_configure
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Niklas Cassel <cassel@kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Sathya Prakash <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
 "Juergen E. Fischer" <fischer@norbit.de>,
 Xiang Chen <chenxiang66@hisilicon.com>,
 HighPoint Linux Team <linux@highpoint-tech.com>,
 Tyrel Datwyler <tyreld@linux.ibm.com>, Brian King <brking@us.ibm.com>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Mike Christie <michael.christie@oracle.com>,
 John Garry <john.g.garry@oracle.com>, Jason Yan <yanaijie@huawei.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
 Chandrakanth patil <chandrakanth.patil@broadcom.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>, Nilesh Javali <njavali@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alan Stern <stern@rowland.harvard.edu>, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
 MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 open-iscsi@googlegroups.com, megaraidlinux.pdl@broadcom.com,
 mpi3mr-linuxdrv.pdl@broadcom.com, linux-samsung-soc@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20240324235448.2039074-1-hch@lst.de>
 <20240324235448.2039074-21-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240324235448.2039074-21-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/24 08:54, Christoph Hellwig wrote:
> Switch to the ->device_configure method instead of ->slave_configure
> and update the block limits on the passed in queue_limits instead
> of using the per-limit accessors.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me. For the ata bits:

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


