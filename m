Return-Path: <linux-block+bounces-23322-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AE4AEA83C
	for <lists+linux-block@lfdr.de>; Thu, 26 Jun 2025 22:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FCC4A5B20
	for <lists+linux-block@lfdr.de>; Thu, 26 Jun 2025 20:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B72566F2;
	Thu, 26 Jun 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KNxh0IaZ"
X-Original-To: linux-block@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5C2628C
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750969752; cv=none; b=KyLnlocz6HBJ/sHBO/OeLdvNJN/Zhn4lP6eb6va6iXRq2bo+pzMxYWuR+vxt3uPPRwlrE3KCQ+obXcJUFIcbIlaXHXj+S+jJikARN/hoUNd8aGulE0yYHgIWwQJPWlohP4IeRkQ3g2ZrT4FgnXEewXzgemr8h0ux0EKFhTAWrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750969752; c=relaxed/simple;
	bh=M7WOoqABsJjCmonIKo8o9tzHeN9ZcawXP7RUwaYwzyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RmXXC6Qbssykg5Yeql/REgqPLU2y613Hwh9NgnIoFTs0ZdrPTnQtqQzqHiwKkmvOMu4AJ6I6dMnZW9kAjD/dfgDv2n2rvrzbWGruikaQsFkmYF+AiNIp83z74UyRYvIrmSngwSasTiVIWMRgdZTFt53Q5wDEeSiKW/svTSVG7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KNxh0IaZ; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bSqzB0w72zlvNR9;
	Thu, 26 Jun 2025 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1750969748; x=1753561749; bh=mKl6bjLFD1ziHolgR/Gbf63I
	+xPGVnzd+9bDu31GOPg=; b=KNxh0IaZvM0MkNhC7yRFmZ90xEM7CWPGZMiT5j3Q
	mW0UYDE0h1xyUx3AEd2D6Hvz0kG9JdxjaZEk7NBp3W7lEjvetzNmI+7iFS8uPeXD
	VIdolbb/jG1Z1EBDcIIwaAwCpAS9wL2AcIs5Htc1FQj/pjSmy1aCXOCMxDeNaOC1
	J+ydHzbbIw8scrM72sxtTBdmC4y6bj58A1Pt4NjJQn9wueZyePPpugMcPIR9Bpxw
	bekFJJXU166x/dIsj5vjMILBhHuNcB249tL8peLejbVidcWdnNgEyZFHGJS9cFsr
	AYgdTQPYJp1QBDKO9vRbQ0HF46hwSOVoGUxx/LYq80/+kA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Ne2VQpVv0-Rq; Thu, 26 Jun 2025 20:29:08 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bSqz45GBFzlgqyl;
	Thu, 26 Jun 2025 20:29:03 +0000 (UTC)
Message-ID: <62ecf314-40a8-4bf7-975b-f6aac450aafa@acm.org>
Date: Thu, 26 Jun 2025 13:29:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] block: Make REQ_OP_ZONE_FINISH a write operation
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20250625093327.548866-1-dlemoal@kernel.org>
 <20250625093327.548866-2-dlemoal@kernel.org>
 <3f292307-30ac-442c-a694-5fc3560036a4@acm.org>
 <d0ae85c4-8fd7-49e2-96b1-a08f01154cf2@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d0ae85c4-8fd7-49e2-96b1-a08f01154cf2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/25 4:36 PM, Damien Le Moal wrote:
> On 6/26/25 01:29, Bart Van Assche wrote:
>> On 6/25/25 2:33 AM, Damien Le Moal wrote:
>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
>>> index 3d1577f07c1c..930daff207df 100644
>>> --- a/include/linux/blk_types.h
>>> +++ b/include/linux/blk_types.h
>>> @@ -350,11 +350,11 @@ enum req_op {
>>>    	/* Close a zone */
>>>    	REQ_OP_ZONE_CLOSE	= (__force blk_opf_t)11,
>>>    	/* Transition a zone to full */
>>> -	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)12,
>>> +	REQ_OP_ZONE_FINISH	= (__force blk_opf_t)13,
>>>    	/* reset a zone write pointer */
>>> -	REQ_OP_ZONE_RESET	= (__force blk_opf_t)13,
>>> +	REQ_OP_ZONE_RESET	= (__force blk_opf_t)15,
>>>    	/* reset all the zone present on the device */
>>> -	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)15,
>>> +	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
>>>    
>>>    	/* Driver private requests */
>>>    	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
>>
>> Since we are renumbering operation types, how about also
>> renumbering REQ_OP_ZONE_OPEN and/or REQ_OP_ZONE_CLOSE? Neither operation
>> modifies data on the storage medium nor any write pointers so these
>> operations shouldn't be considered as write operations, isn't it?
> 
> Open and close change the zone condition and act on the drive count of
> explicitly open zone resources which impacts the ability to write to zones. So I
> would rather consider these also write operations given the changes they imply.

It's probably a good idea to document above the op_is_write() function
that this function is used for multiple purposes:
- Whether it is allowed to submit an operation to a read-only device.
   bio_check_ro() and the loop driver uses op_is_write() for this
   purpose.
- Whether or not lim->zone_write_granularity applies. See also
   bio_split_rw_at().
- Whether or not to throttle the queue depth. See also various I/O
   schedulers.
- To determine the DMA data transfer direction.
- By the block layer I/O statistics code.
- By the blkio cgroup controller statistics code.

Thanks,

Bart.

