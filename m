Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B88C020ED2E
	for <lists+linux-block@lfdr.de>; Tue, 30 Jun 2020 07:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgF3FKp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 30 Jun 2020 01:10:45 -0400
Received: from verein.lst.de ([213.95.11.211]:34458 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbgF3FKp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jun 2020 01:10:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E934C6736F; Tue, 30 Jun 2020 07:10:42 +0200 (CEST)
Date:   Tue, 30 Jun 2020 07:10:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, jack@suse.czi,
        rdunlap@infradead.org, sagi@grimberg.me, mingo@redhat.com,
        rostedt@goodmis.org, snitzer@redhat.com, agk@redhat.com,
        axboe@kernel.dk, paolo.valente@linaro.org, ming.lei@redhat.com,
        bvanassche@acm.org, fangguoju@gmail.com, colyli@suse.de, hch@lst.de
Subject: Re: [PATCH 02/11] block: rename block_bio_merge class to block_bio
Message-ID: <20200630051042.GB27033@lst.de>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com> <20200629234314.10509-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629234314.10509-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 29, 2020 at 04:43:05PM -0700, Chaitanya Kulkarni wrote:
> There are identical TRACE_EVENTS presents which can now take an
> advantage of the block_bio_merge trace event class.
> 
> This is a prep patch which renames block_bio_merge to block_bio so
> that the next patches in this series will be able to resue it.

The changes look good, but I'd merged it with the patches adding
actual new users (which also look good to me).
