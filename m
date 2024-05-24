Return-Path: <linux-block+bounces-7703-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7AE8CE3FD
	for <lists+linux-block@lfdr.de>; Fri, 24 May 2024 12:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B8DEB22715
	for <lists+linux-block@lfdr.de>; Fri, 24 May 2024 10:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A638614B;
	Fri, 24 May 2024 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RfBuRSJe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E4coGURg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cTjFpdU9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tKR63jq/"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C0785274
	for <linux-block@vger.kernel.org>; Fri, 24 May 2024 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545077; cv=none; b=Maer3SSr56+xuxVzoHriy6qKsRUNy8iYU4jIW9n3VBa7T405dcfshOzQA6ovaHsjw4Ufu3gDecUwqSN+MmNJhorj9V/alg7ZUSruVMoA9a8E5tyLyIGv5ucszQwUE+89UHBKCFKlRvC7fy82Cymsse7W1k7bzG0TGvmV7smtRzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545077; c=relaxed/simple;
	bh=HMxK3C1y1IHCnb4d+tV1iDkaT4vX2CjT29aRysFDwIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqQaK6ihEK7gH8kOkas4iLsOvAB20UZXbDSYHGkznYtv83beEJ6KHy5IGMnrQs6pN+INGlsBGDSMj5PmvXye/OU+Fv8SHuyDlN9HlpHw6QrPfHVac5nibeDwtWBf9IDm7nI5/k86n0pBiq2Crg/ULnX8gPKLB80G9hgbME8h7iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RfBuRSJe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E4coGURg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cTjFpdU9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tKR63jq/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D97ED20917;
	Fri, 24 May 2024 10:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716545074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xHbiaJs1W0Sv1cfe+3vdgj0Et8HT3KPYW1ruDnYOHA=;
	b=RfBuRSJeu3Au75UvHhtmdORfMuZK66BEGlk/FdmzpCOz9rfl04eP6K6/ECpUU/Xq8fhxTm
	Ll/eSoqcPDUbi9eUXU45b3E5n/pd0cCY4zZeFHwtaI0rHhjVHK7GxEv/szaRDrZ7gK+2s6
	TCMtqpoYFMXp3AuLP3GEUmCrGVLbRoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716545074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xHbiaJs1W0Sv1cfe+3vdgj0Et8HT3KPYW1ruDnYOHA=;
	b=E4coGURgXgElyPa1QDQgmaxF2tRxQA+DurWmYuOeEVaWbCuKmHBiXZx4fldqmco0O3gCeR
	MFtq6avaB5b4anAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cTjFpdU9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="tKR63jq/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716545073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xHbiaJs1W0Sv1cfe+3vdgj0Et8HT3KPYW1ruDnYOHA=;
	b=cTjFpdU9Wt8Ub1WPq6GdMm/yZTHLMPIsS2rYtupPRWklaEdhKjfE60xufH37SSjBt5Ocl1
	i+YOpSyyqnQiI0COoGQVHNxry476BLt/AEwT5l15uRDsIbCXcQmgGm+MAWmGbH2Nm+y8+s
	1lmUHoXHraIupmt6MWVOfQFNzGvm+a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716545073;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xHbiaJs1W0Sv1cfe+3vdgj0Et8HT3KPYW1ruDnYOHA=;
	b=tKR63jq/g25Mmbof9gkEeAhVpwvruvO8ye1fVEbNGOJ07/QcbHzpV37GLd015DBowM5c0I
	qo2XWyJm6XUgV5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEDBA13A6B;
	Fri, 24 May 2024 10:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ON0mLjFmUGZcagAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 24 May 2024 10:04:33 +0000
Message-ID: <adac0fb2-191a-45d0-804d-6a51b715e2d4@suse.de>
Date: Fri, 24 May 2024 12:04:33 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, hare@kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Pankaj Raghav <kernel@pankajraghav.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
 <Zj__oIGiY8xzrwnb@casper.infradead.org>
 <ZkAEhFLVD9gSk0y0@bombadil.infradead.org>
 <ZkAszpvBkb5_UUiH@bombadil.infradead.org>
 <ZkCI_21z_h1ez4sN@bombadil.infradead.org>
 <993991e6-7f06-4dfd-b5d7-554b9574384c@suse.de>
 <ZkKAoHoC5yvNUKSE@bombadil.infradead.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZkKAoHoC5yvNUKSE@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D97ED20917
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.50

On 5/13/24 23:05, Luis Chamberlain wrote:
> On Mon, May 13, 2024 at 06:07:55PM +0200, Hannes Reinecke wrote:
>> On 5/12/24 11:16, Luis Chamberlain wrote:
>>> On Sat, May 11, 2024 at 07:43:26PM -0700, Luis Chamberlain wrote:
>>>> I'll try next going above 512 KiB.
>>>
>>> At 1 MiB NVMe LBA format we crash with the BUG_ON(sectors <= 0) on bio_split().
>>>
>>> [   13.401651] ------------[ cut here ]------------
>>> [   13.403298] kernel BUG at block/bio.c:1626!
>> Ah. MAX_BUFS_PER_PAGE getting in the way.
>>
>> Can you test with the attached patch?
> 
> Nope same crash:
> 
> I've enabled you to easily test with with NVMe on libvirt with kdevops,
> please test.
> 
>   Luis
> 
> [   14.972734] ------------[ cut here ]------------
> [   14.974731] kernel BUG at block/bio.c:1626!
> [   14.976906] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   14.978899] CPU: 3 PID: 59 Comm: kworker/u36:0 Not tainted 6.9.0-rc6+ #4
> [   14.981005] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   14.983782] Workqueue: nvme-wq nvme_scan_work [nvme_core]
> [   14.985431] RIP: 0010:bio_split+0xd5/0xf0
> [   14.986627] Code: 5b 4c 89 e0 5d 41 5c 41 5d c3 cc cc cc cc c7 43 28 00 00 00 00 eb db 0f 0b 45 31 e4 5b 5d 4c 89 e0 41 5c 41 5d c3 cc cc cc cc <0f> 0b 0f 0b 4c 89 e7 e8 bf ee ff ff eb e1 66 66 2e 0f 1f 84 00 00
> [   14.992063] RSP: 0018:ffffbecc002378d0 EFLAGS: 00010246
> [   14.993416] RAX: 0000000000000001 RBX: ffff9e2fe8583e40 RCX: ffff9e2fdcb73060
> [   14.995181] RDX: 0000000000000c00 RSI: 0000000000000000 RDI: ffff9e2fe8583e40
> [   14.996960] RBP: 0000000000000000 R08: 0000000000000080 R09: 0000000000000000
> [   14.998715] R10: ffff9e2fe8583e40 R11: ffff9e2fe8583eb8 R12: ffff9e2fe884b750
> [   15.000510] R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
> [   15.002128] FS:  0000000000000000(0000) GS:ffff9e303bcc0000(0000) knlGS:0000000000000000
> [   15.003956] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   15.005294] CR2: 0000561b2b5ce478 CR3: 0000000102484002 CR4: 0000000000770ef0
> [   15.006921] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   15.008509] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [   15.010001] PKRU: 55555554
> [   15.010672] Call Trace:
> [   15.011297]  <TASK>
> [   15.011868]  ? die+0x32/0x80
> [   15.012572]  ? do_trap+0xd9/0x100
> [   15.013306]  ? bio_split+0xd5/0xf0
> [   15.014051]  ? do_error_trap+0x6a/0x90
> [   15.014854]  ? bio_split+0xd5/0xf0
> [   15.015597]  ? exc_invalid_op+0x4c/0x60
> [   15.016419]  ? bio_split+0xd5/0xf0
> [   15.017113]  ? asm_exc_invalid_op+0x16/0x20
> [   15.017932]  ? bio_split+0xd5/0xf0
> [   15.018624]  __bio_split_to_limits+0x90/0x2d0
> [   15.019474]  blk_mq_submit_bio+0x111/0x6a0
> [   15.020280]  ? kmem_cache_alloc+0x254/0x2e0
> [   15.021040]  submit_bio_noacct_nocheck+0x2f1/0x3d0
> [   15.021893]  ? submit_bio_noacct+0x42/0x5b0
> [   15.022658]  block_read_full_folio+0x2b7/0x350
> [   15.023457]  ? __pfx_blkdev_get_block+0x10/0x10
> [   15.024284]  ? __pfx_blkdev_read_folio+0x10/0x10
> [   15.025073]  ? __pfx_blkdev_read_folio+0x10/0x10
> [   15.025851]  filemap_read_folio+0x32/0xb0
> [   15.026540]  do_read_cache_folio+0x108/0x200
> [   15.027271]  ? __pfx_adfspart_check_ICS+0x10/0x10
> [   15.028066]  read_part_sector+0x32/0xe0
> [   15.028701]  adfspart_check_ICS+0x32/0x480
> [   15.029334]  ? snprintf+0x49/0x70
> [   15.029875]  ? __pfx_adfspart_check_ICS+0x10/0x10
> [   15.030592]  bdev_disk_changed+0x2a2/0x6e0
> [   15.031226]  blkdev_get_whole+0x5f/0xa0
> [   15.031827]  bdev_open+0x201/0x3c0
> [   15.032360]  bdev_file_open_by_dev+0xb5/0x110
> [   15.032990]  disk_scan_partitions+0x65/0xe0
> [   15.033598]  device_add_disk+0x3e0/0x3f0
> [   15.034172]  nvme_scan_ns+0x5f0/0xe50 [nvme_core]
> [   15.034862]  nvme_scan_work+0x26f/0x5a0 [nvme_core]
> [   15.035568]  process_one_work+0x189/0x3b0
> [   15.036168]  worker_thread+0x273/0x390
> [   15.036713]  ? __pfx_worker_thread+0x10/0x10
> [   15.037312]  kthread+0xda/0x110
> [   15.037779]  ? __pfx_kthread+0x10/0x10
> [   15.038316]  ret_from_fork+0x2d/0x50
> [   15.038829]  ? __pfx_kthread+0x10/0x10
> [   15.039364]  ret_from_fork_asm+0x1a/0x30
> [   15.039924]  </TASK>
> 
So, finally nailed it down.

Problem was that qemu is setting a default mdts of '7', which obviously
is too small for 1M sector sizes.
And the next problem was that we don't validate the 'max_hw_sectors' 
setting against the 'logical_sector_size' setting, letting the block
layer happily accept limit which have an hw_sector_size smaller than
the logical block size.
For that I've meanwhile sent a patch, but if you want continue testing
you need to the 'mdts=0' for the qemu nvme emulation.
We _might_ want to send a patch for qemu to set mdts to '0' as the
default value, but that probably is too much hassle.

Cheers,

Hannes


