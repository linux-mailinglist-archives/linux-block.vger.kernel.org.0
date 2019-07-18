Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D6C6C9AC
	for <lists+linux-block@lfdr.de>; Thu, 18 Jul 2019 09:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfGRHDc (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 18 Jul 2019 03:03:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:55604 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfGRHDc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 03:03:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62042AD35;
        Thu, 18 Jul 2019 07:03:31 +0000 (UTC)
Date:   Thu, 18 Jul 2019 09:03:30 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests v2 03/12] nvme: Add new test to verify the
 generation counter
Message-ID: <20190718070330.GC15760@x250.microfocus.com>
References: <20190717171259.3311-1-logang@deltatee.com>
 <20190717171259.3311-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190717171259.3311-4-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 17, 2019 at 11:12:50AM -0600, Logan Gunthorpe wrote:
[...]
> +_discovery_genctr() {
> +	nvme discover -t loop |
> +		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
> +}

Sorry for not having spotted this in v1, but do we really want to hard-core
the transport type in a library function?

Maybe sth like this:

_discovery_genctr() {
	local trtype=$1
	nvme discover -t ${trtype} |
		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
}

I think Omar can fix it up when applying.

Byte,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
