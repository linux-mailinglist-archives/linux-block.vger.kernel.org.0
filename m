Return-Path: <linux-block+bounces-5406-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C262890FEC
	for <lists+linux-block@lfdr.de>; Fri, 29 Mar 2024 01:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA62B2198A
	for <lists+linux-block@lfdr.de>; Fri, 29 Mar 2024 00:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C06917BA6;
	Fri, 29 Mar 2024 00:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bi6raWBK"
X-Original-To: linux-block@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0B7179B7
	for <linux-block@vger.kernel.org>; Fri, 29 Mar 2024 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711673967; cv=none; b=Zi+mPHbuxecWSqzEQgreBxop3PW2RTKevjwxDkt9vdnLF4VaccbpkskfBh3G53Ug7h0CAzxwcC2HiIOTWNVgIdldHHzp3X16R8mYOhX2P4OIUag0qv4MYe4HBjS4OOCYOiVVNldNC6MmwqptZtRgLvUc8uVa5sLI4LU76gF4ff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711673967; c=relaxed/simple;
	bh=iF/vouNuh+hKx9L4wnVeRQ/T0SOFoiPL/06j048++fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIVQmRfUetetwp++MEJ07woOFbYPjXNrjRakK8HUfWOQP/is5ZfJxjJLDYsgoMggijXV/44Q4fUcZZ08Icd3evN0T+LH+GKky0mRh/kaKDFnl8vWwGmDrxy+z2p9QO6PNGSbDK26iCY5yYWPaPuK/FYHkpXANadmi2nzi2tZErw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bi6raWBK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711673964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nARZ042JED3YY8PVgEd4GjTAZYkPl2errMjI0givjeE=;
	b=Bi6raWBKEKGaW0n3UuSegkgU9bP53li3OKCREbvpdw/hLuR6UFK8IXqkQk2a8JpAteSbwx
	GV6ruhryAZ7UOSRZE/Vuod2z2H6LErfT9nKGhPNOERQVNT/GFdJWHwCB6kWOoyRFEqJ1BL
	846UkiLaP7UhdCvKoyJr5t4nwszz8D4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-Cqvuhfa0N5COFzV2AFzFHg-1; Thu, 28 Mar 2024 20:59:22 -0400
X-MC-Unique: Cqvuhfa0N5COFzV2AFzFHg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 63828101A526;
	Fri, 29 Mar 2024 00:59:22 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AC6E6C1576F;
	Fri, 29 Mar 2024 00:59:19 +0000 (UTC)
Date: Thu, 28 Mar 2024 19:59:14 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alasdair Kergon <agk@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
	David Teigland <teigland@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Joe Thornber <ejt@redhat.com>
Subject: Re: [RFC 7/9] selftests: block_seek_hole: add dm-linear test
Message-ID: <tb76h2qr2aoj6gi5q2ps4dszgvb723vsevm3637kuimxhnhhup@ezvqkck4qgt3>
References: <20240328203910.2370087-1-stefanha@redhat.com>
 <20240328203910.2370087-8-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328203910.2370087-8-stefanha@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Thu, Mar 28, 2024 at 04:39:08PM -0400, Stefan Hajnoczi wrote:
> The dm-linear linear target passes through SEEK_HOLE/SEEK_DATA. Extend
> the test case to check that the same holes/data are reported as for the
> underlying file.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/testing/selftests/block_seek_hole/test.py | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/block_seek_hole/test.py b/tools/testing/selftests/block_seek_hole/test.py
> index 4f7c2d01ab3d3..6360b72aee338 100755
> --- a/tools/testing/selftests/block_seek_hole/test.py
> +++ b/tools/testing/selftests/block_seek_hole/test.py
> @@ -45,6 +45,20 @@ def loop_device(file_path):
>      finally:
>          run(['losetup', '-d', loop_path])
>  
> +@contextmanager
> +def dm_linear(file_path):
> +    file_size = os.path.getsize(file_path)
> +
> +    with loop_device(file_path) as loop_path:
> +        dm_name = f'test-{os.getpid()}'
> +        run(['dmsetup', 'create', dm_name, '--table',
> +             f'0 {file_size // 512} linear {loop_path} 0'])

Would it be worth tryiing to create the dm with two copies of
loop_path concatenated one after the other?  You'd have to do more
work on expected output (coalescing adjacent data or holes between the
tail of the first copy and the head of the second), but without that
in place, I worry that you are missing logic bugs for when there is
more than one table in the overall dm (as evidenced by my review in
4/9).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


