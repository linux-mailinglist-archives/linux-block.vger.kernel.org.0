Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3383AA9B6
	for <lists+linux-block@lfdr.de>; Thu, 17 Jun 2021 05:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhFQDxK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Jun 2021 23:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229673AbhFQDxK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 23:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8C106117A;
        Thu, 17 Jun 2021 03:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623901863;
        bh=1flQ5v/jNp4/ps/FZDuKqGxBV/Yzlof4nAnM0HGqJPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usY7AOlur5KXNcKsTy+fPuDEOvwWgNyLPfAa2n4xELsWhM7bYgpnKVmgONbrZKWHF
         67cSWdPCiiKB0B0Ymw6LH+nQGPGNov/05A7DOi+65gtpLWTQ1CyxckqtIaXD6zQsxQ
         1e6sRdXeduApgyJM32w2I+Yztm13DlDQysbcpKdH0VsmixMdX5nZQMFMOL2PK58H/s
         iD/AdVvZKLl/nGJwIbXY9qvA9uZa4H2450vdMAzYoaMHg+7puhDygj7Wm+f5UhNqfJ
         f86KsDt9/r0GatXnf1AkEKMGlQLaGX1M8cJUTObblfHYv3yDoN46d1vXy2Hm333BWg
         zQhCXrunwVOFA==
Date:   Wed, 16 Jun 2021 20:51:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 00/10] ensure bios aren't split in middle of crypto
 data unit
Message-ID: <YMrGpfXYtGmvtSsO@sol.localdomain>
References: <20210604195900.2096121-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604195900.2096121-1-satyat@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 04, 2021 at 07:58:50PM +0000, Satya Tangirala wrote:
> When a bio has an encryption context, its size must be aligned to its
> crypto data unit size. A bio must not be split in the middle of a data
> unit. Currently, bios are split at logical block boundaries, but a crypto
> data unit size might be larger than the logical block size - e.g. a machine
> could be using fscrypt (which uses 4K crypto data units) with an eMMC block
> device with inline encryption hardware that has a logical block size of 512
> bytes. So we need to support cases where the data unit size is larger than
> the logical block size.

It's worth explaining the motivation for this more clearly.  Currently the only
user of blk-crypto is fscrypt (on ext4 and f2fs), which (currently) only submits
bios where the size of each segment is a multiple of data_unit_size.  That
happens to avoid most of the cases where bios could be split in the middle of a
data unit.  However, when support for direct I/O on encrypted files is added, or
when support for filesystem metadata encryption is added, it will be possible
for bios to have segment lengths that are only multiples of the logical block
size.  So the block layer needs to start handling this case appropriately.

- Eric
