Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B583EDB24
	for <lists+linux-block@lfdr.de>; Mon, 16 Aug 2021 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhHPQmw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 16 Aug 2021 12:42:52 -0400
Received: from verein.lst.de ([213.95.11.211]:55372 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhHPQmw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:42:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 78D4D6736F; Mon, 16 Aug 2021 18:42:18 +0200 (CEST)
Date:   Mon, 16 Aug 2021 18:42:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        Ondrej Zary <linux@rainbow-software.org>
Subject: Re: paride initialization cleanup
Message-ID: <20210816164218.GA5244@lst.de>
References: <20210816161110.909076-1-hch@lst.de> <953db079-d556-f0c5-31eb-932d7f78a3c7@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <953db079-d556-f0c5-31eb-932d7f78a3c7@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 16, 2021 at 09:33:10AM -0700, Bart Van Assche wrote:
> On 8/16/21 9:11 AM, Christoph Hellwig wrote:
>> the paride drivers currently have a major Linux 1.x-style mess for
>> initializing the gendisks.  This series refactors them to be modular
>> and self-contained in preparation of error handling for add_disk.
>
> Hi Christoph,
>
> My understanding is that both the parallel port and IDE are obsolete 
> technologies. Is anyone still using the paride drivers?

It is fairly obsolete indeed.  But three years ago Ondrej still had
some and did test the blk-mq conversion.
