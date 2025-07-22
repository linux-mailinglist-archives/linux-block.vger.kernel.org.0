Return-Path: <linux-block+bounces-24636-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A93B0E316
	for <lists+linux-block@lfdr.de>; Tue, 22 Jul 2025 19:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880A3564840
	for <lists+linux-block@lfdr.de>; Tue, 22 Jul 2025 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F27727F747;
	Tue, 22 Jul 2025 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="brTG1yiy"
X-Original-To: linux-block@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826E66AA7;
	Tue, 22 Jul 2025 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206919; cv=none; b=SydRC3KhUu780oy8+DDsXGsdnVlN757QRoqdnOGGweKVYC5MGEsiJUEAMdVk8T23g6YD33rzvpb6f9pAsrzlG9gmAH0cqo/yi4ekVhKXbY5Fwo6RfWNvv/KdsLCtfyenyakmO0DIsobIs/nhxk8sFD1ECnH84ujpAf0lm3J23P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206919; c=relaxed/simple;
	bh=wJdYOngkgWC0aeC2r+zC/QGcV6RGLv1GZlAKGoT3220=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrjkqeqZ7BGZXdQmTXRUWwsTMhDDlfzsgaKWhhpuK3ghPb1a5Bpj+i9UOvhZ9qHHvYgRnfg22BcEH7dG6/Ka4iREQIKbENSwNB6qaIH9O7L58vmQ8N2wywE5W3bC+UGgzlD6lGqWI60hqfUTlwFX5I09HjZlUEXXL6tAimjhCpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=brTG1yiy; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 13:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753206904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wJdYOngkgWC0aeC2r+zC/QGcV6RGLv1GZlAKGoT3220=;
	b=brTG1yiyg+5CdPhPZjGkhvNW6G8LuB9uUvrk2lLwC4GqVWOq6C18R/YWkW6YvFgl3Joz1Y
	v/XKP1qS7748XZy3z8We3eOOFTLTMFhQ9UEPr022FBfTica/mtEQGTqmWZqlG7TS29o3Q7
	QsGnSz1r07IXeqAVaca0Xx94ogmd8cE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+4eb503ec2b8156835f24@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-bcachefs@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [block?] [bcachefs?] kernel panic: KASAN: panic_on_warn
 set ...
Message-ID: <xq4a62ukblverdhefpn3e43dkhaxvk2brdytqonrbzy3mud76m@srllmpvcv4e5>
References: <68036084.050a0220.297747.0018.GAE@google.com>
 <7mzjrydosm7fnkskvwjwvzpdverxidzfdqgjjyfmqljffen5ou@jy6c626sjrxr>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7mzjrydosm7fnkskvwjwvzpdverxidzfdqgjjyfmqljffen5ou@jy6c626sjrxr>
X-Migadu-Flow: FLOW_OUT

On Sat, Apr 19, 2025 at 08:23:50AM -0400, Kent Overstreet wrote:
> I'm not sure which subsystem this is, but it's definitely not bcachefs -
> we don't use buffer heads.

I think there's some incorrect deduplication going on with this bug,
some of the reports do not look closely related, I believe they're all
buffer heads related.

#syz set-subsystems: block fs

