Return-Path: <linux-block+bounces-1144-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05B9813F8D
	for <lists+linux-block@lfdr.de>; Fri, 15 Dec 2023 03:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85119283E49
	for <lists+linux-block@lfdr.de>; Fri, 15 Dec 2023 02:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3413B7FC;
	Fri, 15 Dec 2023 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axcgIukN"
X-Original-To: linux-block@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E437EA
	for <linux-block@vger.kernel.org>; Fri, 15 Dec 2023 02:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763B0C433C7;
	Fri, 15 Dec 2023 02:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702605793;
	bh=m8svtA8/B5TYh/FkDKhxdr5n4FtqdlfJ89HvBTDBQuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axcgIukNQ4Yvjlwt9UUUtTwbL9FSB0itnCcYkFm1DeLfxmGWfnxFZRqz6qASGQy9D
	 e/Hyk7a1izNvkNLmJAS9xAyKEIL03fBmvRLMFxa6iBoTTPqa41wf9+zTy3lBRO4B69
	 QZ8PQtVnyM4M6GZHpnn3vRfPFkl3O5xM5QOmPcMKB+MmqbStW7EWqxopL92yhT68Y9
	 zspoOORMvHiSlWOBV01P2O8n4+zxKLUDaEcrlOu1drNbzjU78azREaF0SuMOq1sRv+
	 m6L1OJsORXY+6DW18c+L5qFiu0R2dkjF/9l2LoWebwAkp9EQ4T5xGBIcgw+LMfr9zf
	 th8ScCktWBQaA==
Date: Thu, 14 Dec 2023 18:03:11 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block/mq-deadline: Disable I/O prioritization in
 certain cases
Message-ID: <ZXuz36STuYajyccm@google.com>
References: <5b7be2e9-3691-409d-abff-f1fbf04cef7d@acm.org>
 <20231212181304.GA32666@lst.de>
 <19cd459e-d79e-4ecd-8ec8-778be0066e84@acm.org>
 <20231212182613.GA1216@lst.de>
 <ZXiual-UkUY4OWY2@google.com>
 <20231213155606.GA8748@lst.de>
 <ZXnevBo4eIZEXbhK@google.com>
 <20231214085729.GA9099@lst.de>
 <ZXs563M66THrUw50@google.com>
 <168ed2f4-cf58-4ee9-bfbb-449f06f7348d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168ed2f4-cf58-4ee9-bfbb-449f06f7348d@kernel.org>

On 12/15, Damien Le Moal wrote:
> On 12/15/23 02:22, Jaegeuk Kim wrote:
> > On 12/14, Christoph Hellwig wrote:
> >> On Wed, Dec 13, 2023 at 08:41:32AM -0800, Jaegeuk Kim wrote:
> >>> I don't have any
> >>> concern to keep the same ioprio on writes, since handheld devices are mostly
> >>> sensitive to reads. So, if you have other use-cases using zoned writes which
> >>> require different ioprio on writes, I think you can suggest a knob to control
> >>> it by users.
> >>
> >> Get out of your little handheld world.  In Linux we need a generally usable
> >> I/O stack, and any feature exposed by the kernel and will be used quite
> >> differently than you imagine.
> >>
> >> Just like people will add reordering to the I/O stack that's not there
> >> right now (in addition to the ones your testing doesn't hit).  That
> >> doensn't mean we should avoid them - you genereally get better performance
> >> by not reordering without a good reason (like thotting), but especially
> >> in error handling paths or resource constrained environment they will
> >> hapen all over.  We've had this whole discussion with the I/O barriers
> >> that did not work for exactly the same reasons.
> >>
> >>>
> >>>>
> >>>>> it is essential to place the data per file to get better bandwidth. And for
> >>>>> NAND-based storage, filesystem is the right place to deal with the more efficient
> >>>>> garbage collecion based on the known data locations.
> >>>>
> >>>> And that works perfectly fine match for zone append.
> >>>
> >>> How that works, if the device gives random LBAs back to the adjacent data in
> >>> a file? And, how to make the LBAs into the sequential ones back?
> >>
> >> Why would your device pick random LBAs?  If you send a zone append to
> >> zone it will be written at the write pointer, which is absolutely not
> >> random.  All I/O written in a single write is going to be sequential,
> >> so just like for all other devices doing large sequential writes is
> >> important.  Multiple writes can get reordered, but if you havily hit
> >> the same zone you'd get the same effect in the file system allocator
> >> too.
> > 
> > How can you guarantee the device does not give any random LBAs? What'd> be the selling point of zone append to end users? Are you sure this can
> > give the better write trhought forever? Have you considered how to
> > implement this in device side such as FTL mapping overhead and garbage
> > collection leading to tail latencies?
> 
> Answers to all your questions, in order:
> 
> 1) Asking this is to me similar to asking how can one guarantee that the device
> gives back the data that was written... You are asking for guarantees that the
> device is not buggy. By definition, zone append will return the writen start LBA
> within the zone that the zone append command specified. And that start LBA will
> always be equal to the zone write pointer value when the device started
> executing the zone append command.
> 
> 2) When there is an FS, the user cannot know if the FS is using zone append or
> not, so the user should not care at all. If by "user" you mean "the file
> system", then it is a design decision. We already pointed out that generally
> speaking, zone append will be easier to use because it does not have ordering
> constraints.
> 
> 3) Yes, because the writes are always sequential, which is the least expensive
> pattern for the device internal as that only triggers minimal internal activity
> on the FTL, GC, weir leveling etc, at least for a decently designed device.
> 
> 4) See above. If the device interface forces the device user to always write
> sequentially, as mandated by a zoned device, then FTL, GC and weir leveling is
> minimized. The actual device internal GC that may or may not happen completely
> depend on how the device maps zones to flash super blocks. If the mapping is
> 1:1, then GC will be nearly non-existent. If the mapping is not 1:1, then GC
> overhead may exist. The discussion should then be about the design choices of
> the device. The fact that the host chose zone append will not in anyway make
> things worse for the device. Even with regular writes the host must write
> sequentially, same as what zone append achieves (potentially a lot more easily).
> 
> > My takeaway on the two approaches would be:
> >                   zone_append        zone_write
> > 		  -----------        ----------
> > LBA               from FTL           from filesystem
> > FTL mapping       Page-map           Zone-map
> 
> Not sure what you mean here. zone append always returns an LBA from within the
> zone specified by the LBA in the command CDB. So mapping is still per zone. zone
> append is *NOT* a random write command. Zone append automatically implements
> sequential writing within a zone for the user. In the case of regular writes,
> the user must fully control sentimentality. In both cases the write pattern *is*
> sequential.

Okay, it seems there's first disconnect here, which fails to explain all the
below gaps. Do you think the device supporting zone_append keeps LBAs inline
with PBAs within a zone? E.g., LBA#n guarantees to map to PBA#n in a zone.
If LBA order is exactly matching to the PBA order all the time, the mapping
granularity is zone. Otherwise, it should be page.

> 
> > SRAM/DRAM needs   Large              Small
> 
> There are no differences in this area because the FTL is the same for both. No
> changes, nothing special for zone append.
> 
> > FTL GC            Required           Not required
> 
> Incorrect. See above. That depends on the device mapping of zones to flash
> superblocks. And GC requirements are the same for both because the write pattern
> is identical: it is sequential within each zone being written. The user still
> controls which zone it wants to write. Zone append is not a magic command that
> chooses a target zone automatically.
> 
> > Tail latencies    Exist              Not exisit
> 
> Incorrect. They are the same and because of the lack of ordering requirement
> with zone append, if anything, zone append can give better latency.
> 
> > GC Efficience     Worse              Better
> 
> Nope. See above. Same.
> 
> > Longevity         As-is              Longer
> > Discard cmd       Required           Not required
> 
> There is no discard with zone devices. Only zone reset. So both are "not
> required" here.
> 
> > Block complexity  Small              Large
> > Failure cases     Less exist         Exist
> > Fsck              Don't know         F2FS-TOOLS support
> > Filesystem        BTRFS support(?)   F2FS support
> 
> Yes, btrfs data path uses zone append.
> 
> > 
> > Given this, I took zone_write, especially for mobile devices, since we can
> > recover the unaligned writes in the corner cases by fsck. And, most benefit
> > would be getting rid of FTL mapping overhead which improves random read IOPs
> > significantly due to the lack of SRAM in low-end storages. And, longer lifetime
> > by mitigating garbage collection overhead is more important in mobile world.
> 
> As mentioned, GC is not an issue, or rather, GC depends on how the device is
> designed, not on which type of write command the host uses. Writes are always
> sequential for both types !
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research

