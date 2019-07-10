Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F58F634C8
	for <lists+linux-block@lfdr.de>; Tue,  9 Jul 2019 13:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfGILPI (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 9 Jul 2019 07:15:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:38840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfGILPI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Jul 2019 07:15:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F198AEB3;
        Tue,  9 Jul 2019 11:15:07 +0000 (UTC)
Date:   Tue, 9 Jul 2019 13:15:05 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH] block: Disable write plugging for zoned block devices
Message-ID: <20190709111505.GC32272@x250.microfocus.com>
References: <20190709090219.8784-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190709090219.8784-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not sure if I like the new helper or I'd prefer another 'else' in 
blk_mq_make_request().

But all variants I can come up with are ugly and disgusting, so let's got the
route you proposed.

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
