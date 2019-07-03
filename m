Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1CBA5E594
	for <lists+linux-block@lfdr.de>; Wed,  3 Jul 2019 15:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfGCNfB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 3 Jul 2019 09:35:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:41130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbfGCNfB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Jul 2019 09:35:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4988B78E;
        Wed,  3 Jul 2019 13:34:55 +0000 (UTC)
Date:   Wed, 3 Jul 2019 15:34:55 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: create bio_try_merge_pc_page helper
 __bio_add_pc_page
Message-ID: <20190703133446.GE4026@x250.microfocus.com>
References: <20190703130036.4105-1-hch@lst.de>
 <20190703130036.4105-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190703130036.4105-3-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 03, 2019 at 06:00:35AM -0700, Christoph Hellwig wrote:
[snip]
>  	phys_addr_t addr2 = page_to_phys(page) + offset + len - 1;
>  
>  	if ((addr1 | mask) != (addr2 | mask))
>  		return false;
> -
>  	if (bv->bv_len + len > queue_max_segment_size(q))
>  		return false;
> -
> -	return true;
> +	return __bio_try_merge_page(bio, page, len, offset, same_page);
>  }

That's a lot of spurious whitespace changes here.

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
