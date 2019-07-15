Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E68BC683F7
	for <lists+linux-block@lfdr.de>; Mon, 15 Jul 2019 09:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfGOHPY (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 15 Jul 2019 03:15:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:37352 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfGOHPY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 03:15:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91E31AF04;
        Mon, 15 Jul 2019 07:15:23 +0000 (UTC)
Date:   Mon, 15 Jul 2019 09:15:22 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests 07/12] nvme/018: Ignore error message generated
 by nvme read]
Message-ID: <20190715071522.GB4495@x250>
References: <20190712235742.22646-1-logang@deltatee.com>
 <20190712235742.22646-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190712235742.22646-8-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 12, 2019 at 05:57:37PM -0600, Logan Gunthorpe wrote:
> nvme-cli at some point started printing the error message:
> 
>   NVMe status: CAP_EXCEEDED: The execution of the command has caused the
> 	capacity of the namespace to be exceeded(0x6081)
> 
> This was not accounted for by test 018 and caused it to fail.
> 
> This test does not need to test the error message content, it's
> only important that a read past the end of the file fails. Therefore,
> pipe stderr of nvme-cli to /dev/null.

How about redirecting all of the output to $FULL?

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
