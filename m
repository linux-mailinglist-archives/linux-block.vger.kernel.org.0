Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6045F365578
	for <lists+linux-block@lfdr.de>; Tue, 20 Apr 2021 11:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhDTJei (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Apr 2021 05:34:38 -0400
Received: from verein.lst.de ([213.95.11.211]:49864 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhDTJei (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Apr 2021 05:34:38 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CC17A68C4E; Tue, 20 Apr 2021 11:34:04 +0200 (CEST)
Date:   Tue, 20 Apr 2021 11:34:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 1/3] nvme: return BLK_STS_DO_NOT_RETRY if the DNR
 bit is set
Message-ID: <20210420093404.GA28625@lst.de>
References: <20210416235329.49234-1-snitzer@redhat.com> <20210416235329.49234-2-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416235329.49234-2-snitzer@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I don't think this works at all.  We lose way too much information here.
The proposal you linked was to literally propagate the DNR bit.  We'd
still need to make sure drivers for protocols don't support it have
a somewhat sensible options when to set or clear the bit.
