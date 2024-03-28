Return-Path: <linux-block+bounces-4830-lists+linux-block=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6545E886659
	for <lists+linux-block@lfdr.de>; Fri, 22 Mar 2024 06:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93FC21C2362D
	for <lists+linux-block@lfdr.de>; Fri, 22 Mar 2024 05:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C87DFBF2;
	Fri, 22 Mar 2024 05:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="eMjQ2r2z"
X-Original-To: linux-block@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31512DF62;
	Fri, 22 Mar 2024 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086261; cv=none; b=Nbd+ZABNjGozkp0fy22/kJIedM4qedmG6VliA22zKjuTZwPGIEgfMnP/B7axYqgd7L5TItTjvm5vUnlG5vPZB9xhckJ/UrtjUx1fH0vFBYzPekPh5JoTZky/OZH1AKLfk2verTLLMgY8Sf+RZP+ik4zq58hsaCHRxfmTiRtVJMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086261; c=relaxed/simple;
	bh=yYbvlpzpXJH1X+f6CYuiiU9tz9iwi0pKFgeKwqL+Myg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBx6863VMWRRsevQKOEUWB0A1GIz2CGK3m9WZys9KzhMtV96s3LXiN8O8mAew1FmCnQjjCFABziuL0PYEgYGgvdT0FxF0wxui2TYcRd7q1pMelP7HdYBvarqF/0vH6sCdsLf02w9qqEcMfRrDLWr97qwzR51R5wSsGY9tmjqBHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=eMjQ2r2z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KX4qkw+KfuleA0M7WLc0YlfSHjZK3/ruuBrkGWfjxIE=; b=eMjQ2r2zTZO92cOAkgjK41WJRl
	GIfZ4+ClPiw7c/gT4yqOYeFq7A5sJvUovI7OsMuZviWFIwWIGhEt1MebmTiqRkYhqBiz6felNRtt+
	RLO+rUl/S/M24vSwCCNzpXLQRpN1tsHEA9cX/F4o57SoLG3bhvh6xLgKEWAxEUkjL37ywW+NXyh8S
	msAHKvhIj2UmchBuRe1C59tXA3ja/MINke4qec+WUwO4jNq/rSNkmhmhCywBbhJBmcBX8Trqxw5oJ
	kCp4uyzhJKIN+sS5zzkOsznOD/IpaljW/b5av29GLSLNv0qa7e4E9OOQ3p/44OPACx4K6sjYYaFvG
	2gHDMIjQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rnXhD-00EJ2N-33;
	Fri, 22 Mar 2024 05:44:04 +0000
Date: Fri, 22 Mar 2024 05:44:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [RFC v4 linux-next 04/19] block: prevent direct access of
 bd_inode
Message-ID: <20240322054403.GA3404528@ZenIV>
References: <20240222124555.2049140-1-yukuai1@huaweicloud.com>
 <20240222124555.2049140-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222124555.2049140-5-yukuai1@huaweicloud.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Feb 22, 2024 at 08:45:40PM +0800, Yu Kuai wrote:

> +static inline struct bdev_inode *BDEV_B(struct block_device *bdev)
> +{
> +	return container_of(bdev, struct bdev_inode, bdev);
> +}
> +
> +struct inode *bdev_inode(struct block_device *bdev)
> +{
> +	return &BDEV_B(bdev)->vfs_inode;
> +}
> +
> +struct address_space *bdev_mapping(struct block_device *bdev)
> +{
> +	return BDEV_B(bdev)->vfs_inode.i_mapping;
> +}

Nit: that might as well had been &BDEV_B(bdev)->vfs_inode.i_data
These inodes always have ->i_mapping pointing their own ->i_data.
If we ever change that, we would have enough bdev.c work on hands
anyway.

