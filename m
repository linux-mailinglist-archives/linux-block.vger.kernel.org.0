Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8C03B4DBA
	for <lists+linux-block@lfdr.de>; Sat, 26 Jun 2021 10:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFZIyX (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 26 Jun 2021 04:54:23 -0400
Received: from luna.lichtvoll.de ([194.150.191.11]:48027 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229518AbhFZIyX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Jun 2021 04:54:23 -0400
Received: from ananda.localnet (unknown [IPv6:2001:a62:1a52:5a00:19da:1263:b56c:4c4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 2675027AF85;
        Sat, 26 Jun 2021 10:52:00 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: Assumption on fixed device numbers in Plasma's desktop search Baloo
Date:   Sat, 26 Jun 2021 10:51:59 +0200
Message-ID: <1769070.0rzTUBzp5V@ananda>
In-Reply-To: <162466884942.28671.6997551060359774034@noble.neil.brown.name>
References: <41661070.mPYKQbcTYQ@ananda> <162466884942.28671.6997551060359774034@noble.neil.brown.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Authentication-Results: mail.lichtvoll.de;
        auth=pass smtp.auth=martin2 smtp.mailfrom=martin@lichtvoll.de
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NeilBrown - 26.06.21, 02:54:09 CEST:
> > And that Baloo needs an "invariant" for
> 
> > a file. See comment #11 of that bug report:
> That is really hard to provide in general.  Possibly the best approach
> is to use the statfs() systemcall to get the "f_fsid" field.  This is
> 64bits.  It is not supported uniformly well by all filesystems, but I
> think it is at least not worse than using the device number.  For a
> lot of older filesystems it is just an encoding of the device number.
> 
> For btrfs, xfs, ext4 it is much much better.

Thank you for the clear statement and for your alternative suggestion. I 
will forward this to Baloo upstream.

I think the main focus of Baloo would be to work on currently mostly in 
use Linux filesystem which should be BTRFS, XFS, EXT4 and probably F2FS.

-- 
Martin


