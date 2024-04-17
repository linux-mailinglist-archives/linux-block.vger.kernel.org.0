Return-Path: <linux-block+bounces-6308-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2F38A7A2A
	for <lists+linux-block@lfdr.de>; Wed, 17 Apr 2024 03:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E93B283A86
	for <lists+linux-block@lfdr.de>; Wed, 17 Apr 2024 01:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9341852;
	Wed, 17 Apr 2024 01:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5bqvebF"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC2A47
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713317610; cv=none; b=CBkb57q2A0hyspjMA7QzB3Yb40ctKTpEOnxFnJaYx0+wfkx8p5VHWVsxnWy5ODDZaOO6NzcltC4xixZP8XR+D74V+zJTTjCLIWr70weUaMLkX0m9U6C/1wKN9Mlwmrgv0cIuqsSMo/aHw0ude3zQqf42hH6m7QFfEak9elzcBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713317610; c=relaxed/simple;
	bh=8TUspfH/j0jB+NGyXeFKCYbXQ5gmKtDRLbtYjogjHFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHE5Zk84JJjzQJmQAGt50ESR8MzFJZg6xA26EtJaJy1kORa4pnTsA+4bRH7hqKpDsL99mguSvP/CTdbDXxfi4UbG0Mlka4IFyLPJII2Bbl4ZJTmpUAfeN+1Li6hGVTRo3QI1Fh/CPeMYE45iwvTaFhpFYl9KXtN1/Qvhv9IRri8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P5bqvebF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713317608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZ28i7wR4++HF1LOz4QwDQAvkWeiJgqz8eW7WOEsp2M=;
	b=P5bqvebFA8VevX6aLK6otctUSZnAD1hbiXHoIFhGUtzNLeCbWI8PKSWsf83AlPuqkr2LuN
	1OevNH70lIq0UtMlZkGOB5pLpOpqXbXTllFvJKKsn+ohki8UjpKxTQcfG5H0SS6qhLX/Kh
	pwFFRkVbcQvCewPb7NnfIe0BlV/rXJw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-hDWIjlT2M4GKdodIpbQEuA-1; Tue, 16 Apr 2024 21:33:23 -0400
X-MC-Unique: hDWIjlT2M4GKdodIpbQEuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F403188ACA0;
	Wed, 17 Apr 2024 01:33:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 93FF040C6CB2;
	Wed, 17 Apr 2024 01:33:19 +0000 (UTC)
Date: Wed, 17 Apr 2024 09:32:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: brauner@kernel.org, czhong@redhat.com, dm-devel@lists.linux.dev,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] dm: restore synchronous close of device mapper block
 device
Message-ID: <Zh8mx4yIGyv2InCq@fedora>
References: <20240416005633.877153-1-ming.lei@redhat.com>
 <20240416152842.13933-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416152842.13933-1-snitzer@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Tue, Apr 16, 2024 at 11:28:42AM -0400, Mike Snitzer wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> 'dmsetup remove' and 'dmsetup remove_all' require synchronous bdev
> release. Otherwise dm_lock_for_deletion() may return -EBUSY if the open
> count is > 0, because the open count is dropped in dm_blk_close()
> which occurs after fput() completes.
> 
> So if dm_blk_close() is delayed because of asynchronous fput(), this
> device mapper device is skipped during remove, which is a regression.
> 
> Fix the issue by using __fput_sync().
> 
> Also: DM device removal has long supported being made asynchronous by
> setting the DMF_DEFERRED_REMOVE flag on the DM device. So leverage
> using async fput() in close_table_device() if DMF_DEFERRED_REMOVE flag
> is set.

IMO, this way isn't necessary, because the patch is one bug fix, and we are
supposed to recover into exact previous behavior before commit a28d893eb327
("md: port block device access to file") for minimizing regression risk.

But the extra change seems work.


thanks, 
Ming


