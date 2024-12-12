Return-Path: <linux-block+bounces-15285-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1A29EE850
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2024 15:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE70284016
	for <lists+linux-block@lfdr.de>; Thu, 12 Dec 2024 14:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BAA21171A;
	Thu, 12 Dec 2024 14:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GnMtdq6X"
X-Original-To: linux-block@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365D2147FE
	for <linux-block@vger.kernel.org>; Thu, 12 Dec 2024 14:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012302; cv=none; b=lkYiMgN29PzpRD7S/5+xZV0E2KkydDU0YJuzGuoEY9IFqoqKm4DCKDi/cK4k/ekeqGMqoA/7tlD4sUTj2sFOcUOzJYcg4e+Q25bZ4e3RwP7hi9a2YERX1HdjhsszXq2GsruhU/9FbxsHQNZW3dlo8z/5A7sybtNhfgLaDJpykTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012302; c=relaxed/simple;
	bh=l9768Zqi5xPWgcHMMQWbEUEnTWaMaMqZ2EmdRUnwV/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETbLOZAlJ3ubpEGm2KpNEp+7V06KuFeXNQCABOpZN/M6yv/aICe+5JMwLktQj8zXR3duyAIMBEO7cdMoX0yepSfYPDVwZTXeUovJ9nG1dtyHDuvwznjcB9UXNsmHWsPHm7N88JKKL4XOH1Ff0oAIlKFucA7p+rFnxZoAyL/9MDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GnMtdq6X; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BCE4bXm020641
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 09:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734012280; bh=bJ0E8CSMJXun6+FY128vT4vUAPTDy2onmEqDnF7ORQU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GnMtdq6XQbejiNVXkjPP0Zbzm/9x+oU97EZIVRzkDUotWOhzaY/vVjy5dGI2lPmzI
	 mHjwNy2tuLsHBMGLFt9++iAgYAG4/pj7+xYpd0sfP+PoV8A2eGpaTKgk5um60FGqXd
	 V+5RAr/7jUFfmiTcmYlnjjrENFeYvLlR5IXKRlicVg8KogG1KTCVA5VAbKiOxWz1ww
	 OQ0byRLkAp7v5rmWZzihILj26mLv0ZteTzPadhyuBI9W9LmkD/J1uKaHXlUjfQOwK5
	 8GL9WBXuCGvdbh9G1xJrj9rP+gUgbPGT76tAEmfyldW55OAl+4UA488G6g7DFvBm1+
	 GS/aRCn7UUjOA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A21C315C028A; Thu, 12 Dec 2024 09:04:37 -0500 (EST)
Date: Thu, 12 Dec 2024 09:04:37 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, caiqingfu <baicaiaichibaicai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <20241212140437.GD1265540@mit.edu>
References: <20241212035826.GH2091455@google.com>
 <20241212053739.GC1265540@mit.edu>
 <Z1qSTM_Eibvw0bM5@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1qSTM_Eibvw0bM5@infradead.org>

On Wed, Dec 11, 2024 at 11:35:40PM -0800, Christoph Hellwig wrote:
> On Thu, Dec 12, 2024 at 12:37:39AM -0500, Theodore Ts'o wrote:
> > More generally, any file system which uses the buffer cache, and
> > doesn't use jbd2 to control when writeback happens, I think is going
> > to be at risk with a block device which requires stable writes.  The
> > only way to fix this, really, is to have the buffer cache code copy
> > the data to a bounce buffer, and then issue the write from the bounce
> > buffer.
> 
> Should there be a pr_warn_once when using a file systems using the legacy
> buffer cache interfaces on a device that requires stable pages?

Well, either that, or we need to teach the buffer cache writeback code
to issue writes through a bounce buffer if the device requires stable
writes.

I'll note that this could also manifest if some program was writing to
a device that requires stable writes using buffered I/O.  For example,
if they are using postgres, which won't be switching to direct I/O for
another 2-5 years (depending on how optimistic you are and how willing
enterprise customers will be to move to the latest version of
Postgres; some are stillu using very ancient Postgres for the same
reason that RHEL 7 systems based on the 3.10 kernel are still in
production use even today.)

For this particular use case, which is running VM's on
Chromium/ChromeOS, I suspect we do need to have some kind of solution
other than triggering a WARN_ON.  Besides, I'd really rather not get
the kind of syzbot noise we would have by having some scheme that
would be trivially easy for syzbot to trigger.  (We're not should use
WARN_ON for things that can be triggered by Stupid User Tricks,
because syzbot fuzzers can be so ingenious.  :-)

	       	       	      	 	     - Ted

