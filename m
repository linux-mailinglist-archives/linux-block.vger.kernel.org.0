Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5858C20ED3E
	for <lists+linux-block@lfdr.de>; Tue, 30 Jun 2020 07:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgF3FNe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Jun 2020 01:13:34 -0400
Received: from verein.lst.de ([213.95.11.211]:34513 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgF3FNe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 01:13:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2FB886736F; Tue, 30 Jun 2020 07:13:32 +0200 (CEST)
Date:   Tue, 30 Jun 2020 07:13:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, jack@suse.czi,
        rdunlap@infradead.org, sagi@grimberg.me, mingo@redhat.com,
        rostedt@goodmis.org, snitzer@redhat.com, agk@redhat.com,
        axboe@kernel.dk, paolo.valente@linaro.org, ming.lei@redhat.com,
        bvanassche@acm.org, fangguoju@gmail.com, colyli@suse.de, hch@lst.de
Subject: Re: [PATCH 10/11] block: use block_bio class for getrq and sleeprq
Message-ID: <20200630051332.GG27033@lst.de>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com> <20200629234314.10509-11-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629234314.10509-11-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 29, 2020 at 04:43:13PM -0700, Chaitanya Kulkarni wrote:
> The only difference in block_get_rq and block_bio was the last param
> passed  __entry->nr_sector & bio->bi_iter.bi_size respectively. Since
> that is not the case anymore replace block_get_rq class with block_bio
> for block_getrq and block_sleeprq events, also adjust the code to handle
> null bio case in block_bio.

To me it seems like keeping the NULL bio case separate actually is a
little simpler..

