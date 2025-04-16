Return-Path: <linux-block+bounces-19778-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E5EA8B4E3
	for <lists+linux-block@lfdr.de>; Wed, 16 Apr 2025 11:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69631444079
	for <lists+linux-block@lfdr.de>; Wed, 16 Apr 2025 09:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF42233145;
	Wed, 16 Apr 2025 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OCewESw4"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C78233722
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794772; cv=none; b=Lxz5AKI5YkuUkoQQxBEJT1kfzVNq3CM0VfYjuz/gzohuHUag96hdycOeX/xz7X+t7dibz3JLeAfTA2QVfhlRCWgYjnPiSmwwfRMGB4IrNfxaa4qrlQcHtnPj9THk6XNLxQUICVBdsGn2+3lcILtukFlLKIHdBm5ubnRsSpT0aIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794772; c=relaxed/simple;
	bh=9AJpCXxPFMRjAJoqk5X7cshYC17OjfxvXDXymPXCSKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkhg6xz/y/zwLUltun2DNmM+SSP2s88KobhchOB+H2lJ12OIP+Eo/I+p19FUaW5+T24xqqtUSb1YG6qeXo4hnc5FnQK5EXEd2JeLb0tc5jpja53AtgoVIQZ20VVA2nwDkXYhvYz7fNvy7a7dX7t4pOQyuNGIUCeknVn+8guOrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OCewESw4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744794770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ePYf4+OpqodMMJHsgqqdfSfVdKxuAuZh5DJjBZf/fg=;
	b=OCewESw4GGFT1FjrE+PIijVIX10VsaNVwtF1DrBA+5gaWgp8CTB2i/rBInYMzsexL35D1E
	wD848OrHrTXIzrvQxOt7BzBR+NR1OxDZyyNfw93ztA+5vDb8fPLMCf3rBX4EK02+b7Nd0X
	u5ldqfAi01vy0YmT8OKkTPKIgfW2EN4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-f7AFqXdnNsy-g4odUdcEmg-1; Wed,
 16 Apr 2025 05:12:45 -0400
X-MC-Unique: f7AFqXdnNsy-g4odUdcEmg-1
X-Mimecast-MFC-AGG-ID: f7AFqXdnNsy-g4odUdcEmg_1744794764
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1B2A19560AE;
	Wed, 16 Apr 2025 09:12:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.82])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACEE019560A3;
	Wed, 16 Apr 2025 09:12:41 +0000 (UTC)
Date: Wed, 16 Apr 2025 17:12:36 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: ublk: Graceful Upgrade of ublk server application
Message-ID: <Z_90hHRXe7R3fQuk@fedora>
References: <DM4PR12MB63282BE4C94D28AA2E1CACA0A9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z_49m8awtNFsY8pl@fedora>
 <DM4PR12MB63285A6617D8A9B9F22B912BA9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z/7/LTSxqLH7JgAl@dev-ushankar.dev.purestorage.com>
 <Z_8KO5uJfkB-SKvT@fedora>
 <DM4PR12MB632890760804D06B3CBC357AA9BD2@DM4PR12MB6328.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB632890760804D06B3CBC357AA9BD2@DM4PR12MB6328.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Apr 16, 2025 at 08:16:44AM +0000, Yoav Cohen wrote:
> Hi,
> 
> The use case is as you say to replace the binary (update) without making the bdev to disappear.
> Currently I don't even use the user_copy(to avoid the 1 more system call) so the io buffer is also part of the sqe which is prevent me from free it from userspace perspective.
> So yes, even ABORT_URING_CMD by given tag can be enough.
> What do you think?

I think the requirement is reasonable, which could be one QUIESCE_DEV command:

- only usable for UBLK_F_USER_RECOVERY

- need ublk server cooperation for handling inflight IO command

- fallback to normal cancel code path in case that io_uring is exiting

The implementation shouldn't be hard:

- mark ubq->canceling as ture 
	- freeze request queue
	- mark ubq->canceling as true
	- unfreeze request queue

- canceling all uring_cmd with UBLK_IO_RES_ABORT (*)
	- now there can't be new ublk IO request coming, and ublk server won't
	send new uring_cmd too, 

	- the gatekeeper code of __ublk_ch_uring_cmd() should be reliable to prevent
	any new uring_cmd from malicious application, maybe need audit & refactoring
	a bit

	- need ublk server to handle UBLK_IO_RES_ABORT correctly: release all
	  kinds resource, close ublk char device...

- wait until ublk char device is released by checking UB_STATE_OPEN

- now ublk state becomes UBLK_S_DEV_QUIESCED or UBLK_S_DEV_FAIL_IO,
and userspace can replace the binary and recover device with new
application via UBLK_CMD_START_USER_RECOVERY & UBLK_CMD_END_USER_RECOVERY

Please let us know if the above works for your requirement.

Thanks,
Ming


