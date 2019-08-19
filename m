Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B5094D14
	for <lists+linux-block@lfdr.de>; Mon, 19 Aug 2019 20:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbfHSShM (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Aug 2019 14:37:12 -0400
Received: from rin.romanrm.net ([91.121.75.85]:42602 "EHLO rin.romanrm.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbfHSShL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 14:37:11 -0400
Received: from natsu (natsu.40.romanrm.net [IPv6:fd39:aa:c499:6515:e99e:8f1b:cfc9:ccb8])
        by rin.romanrm.net (Postfix) with SMTP id A18D5202D3;
        Mon, 19 Aug 2019 18:37:09 +0000 (UTC)
Date:   Mon, 19 Aug 2019 23:37:09 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: 5.1.21 Dell 2950 terrible swraid5 I/O performance with swraid
 on top of Perc 5/i raid0/jbod
Message-ID: <20190819233709.76900bbf@natsu>
In-Reply-To: <20190819070823.GH12521@merlins.org>
References: <20190819070823.GH12521@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 19 Aug 2019 00:08:23 -0700
Marc MERLIN <marc@merlins.org> wrote:

> > Default Cache Policy: WriteBack, ReadAheadNone, Direct, No Write Cache if Bad BBU
> > Current Cache Policy: WriteBack, ReadAheadNone, Direct, No Write Cache if Bad BBU
> > Default Access Policy: Read/Write
> > Current Access Policy: Read/Write
> > Disk Cache Policy   : Disabled

So does it have a BBU? (Battery backup unit)

> I tried to disable the card's write cache to let linux and its 32GB of
> RAM, do it better, but I didn't see a real improvement:

I'd expect that on the contrary, you should look for ways to enable it, and
force-enable even without that BBU (in case of lack of one), because it feels
like what you did is disable disks' own write buffering, and not (only) the
card's!

What you are observing seems to me like what "dd" does with "oflag=dsync" (and
comparable performance that it gets). Definitely feels like it's in some
"extra safe mode" and, say, every 4KB piece of data leads to full flush to
disk before accepting to write the next 4KB.

More things to try, check if it's possible to set up disks not as 1-member
RAID0, but 1-member "linear" ("JBOD"), or even 1-member RAID1, who knows maybe
some of this would work better.

-- 
With respect,
Roman
