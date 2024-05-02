Return-Path: <linux-block+bounces-6833-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F18B948D
	for <lists+linux-block@lfdr.de>; Thu,  2 May 2024 08:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FFB1C2091B
	for <lists+linux-block@lfdr.de>; Thu,  2 May 2024 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856B20B20;
	Thu,  2 May 2024 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q7qJ/Mk7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hK59XzWQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q7qJ/Mk7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hK59XzWQ"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A2719BBA
	for <linux-block@vger.kernel.org>; Thu,  2 May 2024 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714630473; cv=none; b=friip1XMwLtlOcPZwHImWUijmVQFkreEP+OeTZgPKCpt32ryMCUhIL1S57qfG/+kR+Vhvz+iS+pTtHveHh2G8ZYKtZp6RPPs5dYVwG+uGC6TNyzr91eKZEFDWS8JgdA/L9c8zVMGAfRtryoeG8CLQv00kx/vXczkm1gvFRMUynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714630473; c=relaxed/simple;
	bh=I4C2JTF4ZxZ2ncetiBxqSpTfyx74feb2/Tu0jnREt8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j9OVBvFE/osjKzYpZYrONbRfofX3KZmtcKJFTYcBHdnsAOM7qtU1y4doX0fxo1JdLzlkaKb/sw12JFePQZycFspKejdxm0+H4ck5mZ3D5I4HLN+KVB7K9Sa7qK3sr69nMV96IKNFfBKLPeqI7l7nbiNbO1etfKRkkpjXGmGQX68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q7qJ/Mk7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hK59XzWQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q7qJ/Mk7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hK59XzWQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B0A33500E;
	Thu,  2 May 2024 06:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714630470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YTvZN+q+pZDEwEKcrh4zqXcHkw0gElTsT5w/ahQzQQ=;
	b=Q7qJ/Mk7XhkZ2bkP3vEXnlYon/HlzlmVKNP3d79aRUoFvwz+V8Uk7X/puPGk+EVUZYlwkG
	vvNpiJwuBYQhJO1gavmpE42wvhW0sM7nZKOiAiU3MR/Lo+bHlwi/apYzxm0KmjjDLWEJtT
	OkOvTwfcDyXebfl0lZ3xpRWCE568Fas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714630470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YTvZN+q+pZDEwEKcrh4zqXcHkw0gElTsT5w/ahQzQQ=;
	b=hK59XzWQbx10OcsP9mLxHZXLqw3tynQtzdE/oTXWgJVj5C5RMqa3as2hq2p5pvucTtlWUT
	Is/9Ezaz8ghLq0Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Q7qJ/Mk7";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hK59XzWQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714630470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YTvZN+q+pZDEwEKcrh4zqXcHkw0gElTsT5w/ahQzQQ=;
	b=Q7qJ/Mk7XhkZ2bkP3vEXnlYon/HlzlmVKNP3d79aRUoFvwz+V8Uk7X/puPGk+EVUZYlwkG
	vvNpiJwuBYQhJO1gavmpE42wvhW0sM7nZKOiAiU3MR/Lo+bHlwi/apYzxm0KmjjDLWEJtT
	OkOvTwfcDyXebfl0lZ3xpRWCE568Fas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714630470;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0YTvZN+q+pZDEwEKcrh4zqXcHkw0gElTsT5w/ahQzQQ=;
	b=hK59XzWQbx10OcsP9mLxHZXLqw3tynQtzdE/oTXWgJVj5C5RMqa3as2hq2p5pvucTtlWUT
	Is/9Ezaz8ghLq0Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 153011386E;
	Thu,  2 May 2024 06:14:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SNjIAkYvM2ZMNgAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 May 2024 06:14:30 +0000
Message-ID: <bcb81851-5bc4-4f42-86db-c4fe2e56d883@suse.de>
Date: Thu, 2 May 2024 08:14:29 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/14] block: Improve zone write request completion
 handling
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>
References: <20240501110907.96950-1-dlemoal@kernel.org>
 <20240501110907.96950-12-dlemoal@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240501110907.96950-12-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,wdc.com:email,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6B0A33500E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 5/1/24 13:09, Damien Le Moal wrote:
> blk_zone_complete_request() must be called to handle the completion of a
> zone write request handled with zone write plugging. This function is
> called from blk_complete_request(), blk_update_request() and also in
> blk_mq_submit_bio() error path. Improve this by moving this function
> call into blk_mq_finish_request() as all requests are processed with
> this function when they complete as well as when they are freed without
> being executed. This also improves blk_update_request() used by scsi
> devices as these may repeatedly call this function to handle partial
> completions.
> 
> To be consistent with this change, blk_zone_complete_request() is
> renamed to blk_zone_finish_request() and
> blk_zone_write_plug_complete_request() is renamed to
> blk_zone_write_plug_finish_request().
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   block/blk-mq.c    |  6 ++----
>   block/blk-zoned.c | 11 ++++++-----
>   block/blk.h       |  8 ++++----
>   3 files changed, 12 insertions(+), 13 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


