Return-Path: <linux-block+bounces-18583-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3638A66A39
	for <lists+linux-block@lfdr.de>; Tue, 18 Mar 2025 07:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DA6189B2DA
	for <lists+linux-block@lfdr.de>; Tue, 18 Mar 2025 06:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F921BC099;
	Tue, 18 Mar 2025 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dAUbH0FE"
X-Original-To: linux-block@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA51C701E;
	Tue, 18 Mar 2025 06:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742278590; cv=none; b=g+9LVx/mB1yKn3N+WnC+ozfPInuV9WCWkTOfY8IqnVwMluxW06d5FYm1nC5XzLIz3cqv5JxEQ90wr2zw/57Uw//npmxdTEd/9TI/O1K4d+JJhKEKCUMfT1BfjOjba2YcsadmvpWOSM1fGLmWBAIfa+SqR6GBOAQHUeavbyHLPhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742278590; c=relaxed/simple;
	bh=2kqWhQJzo90CLa0BZ2WBq8Tv/tXOun9qLpQk365Wqtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4ad0dSR76WfJyDtGpukFKEoJyaKqhxi9Bvf07+ngIeiHGjX/wDvdN8+Bp6N9O151BxJ6gpAhxZBKwbdChm1YgF2LxbYj2R5SbaYsGoB7L7TrwuyzLbJqQDNtCkbkYRTN6Sh19oEPScSPbKKRL36KpwQEhSOWErLhEKIwWVPcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dAUbH0FE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0npmmvwtytRyUTFaIH0wZY5yPj8ZHxwNnSx9JVRtdaA=; b=dAUbH0FEWDbpSpqYBKxAwir+L5
	lu2Kjzvcs+Ez0OAOrMHz44w/bL3ivESDLE1WZd6fLCPl+Ef0TP5q7ec9Xgv7bODH5h0YvnuoPAzZ7
	h+EXo0RJQ2Dl1flOebsV8quz15aOu4iGds8V49gOo7XAn03BS+NaaJIvDbpYiN2DvjDKwBbuKvDPz
	022VGELSMLIRl52oq7fgfjj3zScSISTPz3mBrT68A4HMwspajK8ier5keYQ/yGvLgPU9Kj+d3PR5k
	zKdhlJDtvNNSIYdxrTs72mQ+SxndYNujpBZ/Vjx4Yf8txEzZU5P7tOJTEXpX2B0ELaXPbzfu9w/98
	xILAlc7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuQFV-00000004oBO-1ALL;
	Tue, 18 Mar 2025 06:16:25 +0000
Date: Mon, 17 Mar 2025 23:16:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 13/14] block: Allow REQ_FUA|REQ_READ
Message-ID: <Z9kPuS6c7otvCGuw@infradead.org>
References: <Z9guJ2VxvqAmm9o9@kbusch-mbp.dhcp.thefacebook.com>
 <yq1msdjg23p.fsf@ca-mkp.ca.oracle.com>
 <qhc7tpttpt57meqqyxrfuvvfaqg7hgrpivtwa5yxkvv22ubyia@ga3scmjr5kti>
 <yq1bjtzfyen.fsf@ca-mkp.ca.oracle.com>
 <zjwvemsjlshzm5zes7jznmhchvf2erebmuil4ssnkax3lwpw3a@5gnzbjlta36f>
 <Z9h25wvi0VQOaGh2@kbusch-mbp.dhcp.thefacebook.com>
 <ysvt4npanz4qfoxm5cv627cq2ommq6rxpka6pkvl3l2crcatmc@ic7tn5tt7aw4>
 <Z9iIa770ySTgKgp0@kbusch-mbp.dhcp.thefacebook.com>
 <566e4f59-4aaa-4d8e-b61f-b27cf79c1201@acm.org>
 <4mqi7e74ji7j3pzfdhfncz2yz3vvvvb6jivtzry4pmljgygcg5@hd5pv2lddzeq>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4mqi7e74ji7j3pzfdhfncz2yz3vvvvb6jivtzry4pmljgygcg5@hd5pv2lddzeq>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Mar 17, 2025 at 09:06:13PM -0400, Kent Overstreet wrote:
> What bcachefs is doing is entirely in line with the behaviour the
> standard states.

Setting the FUA bit on any READ command (if supported by the device)
is entirely in line with the behaviour the standards.  It's just not
going to do what you hope.  And while you claim that it helps you
with data recovery, you've not shown either a practical example where
it does, or a theory based on hardware architeture how it could.

> It's an amusing state of affairs, but it'd be easily resolved with an
> admin level NVME command to flip a state bit (like the read recovery
> level we were also talking about), and anyways multihoming capable NVME
> devices are an entirely different market from the conventional stuff.

Please joing the NVMe technical working group and write a proposal.
NVMe requires you to clearly state the benefits of the proposal, which
means you have to actually clearly write that down first.

