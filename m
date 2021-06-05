Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8297F39CB8D
	for <lists+linux-block@lfdr.de>; Sun,  6 Jun 2021 00:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhFEW47 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 5 Jun 2021 18:56:59 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:28362 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229998AbhFEW46 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Jun 2021 18:56:58 -0400
X-Greylist: delayed 1000 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jun 2021 18:56:58 EDT
Received: from host86-157-72-169.range86-157.btcentralplus.com ([86.157.72.169] helo=[192.168.1.65])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1lpew0-000CKG-Ap; Sat, 05 Jun 2021 23:38:28 +0100
Subject: Re: [Bug Report] Discard bios cannot be correctly merged in blk-mq
To:     Wang Shanker <shankerwangmiao@gmail.com>,
        linux-block@vger.kernel.org
Cc:     linux-raid@vger.kernel.org
References: <85F98DA6-FB28-4C1F-A47D-C410A7C22A3D@gmail.com>
From:   antlists <antlists@youngman.org.uk>
Message-ID: <6c407281-ee90-f577-d6db-d36211b1fdc0@youngman.org.uk>
Date:   Sat, 5 Jun 2021 23:38:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <85F98DA6-FB28-4C1F-A47D-C410A7C22A3D@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/06/2021 21:54, Wang Shanker wrote:
> You may wonder the importance of merging discard operations. In the
> implementation of RAID456, bios are committed in 4k trunks (they call
> them as stripes in the code and the size is determined by DEFAULT_STRIPE_SIZE).
> The proper merging of the bios is of vital importance for a reasonable
> operating performance of RAID456 devices.

Note that I have seen reports (I'm not sure where or how true they are), 
that even when requests are sent as 512k or whatever, certain upper 
layers break them into 4k's, presumably expecting lower layers to merge 
them again.

You might have better luck looking for and suppressing the breaking up 
of large chunks.

Cheers,
Wol
