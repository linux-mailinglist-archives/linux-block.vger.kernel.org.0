Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A35B54C1CD
	for <lists+linux-block@lfdr.de>; Wed, 15 Jun 2022 08:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbiFOG1n (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Jun 2022 02:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbiFOG1i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 02:27:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D49F6320
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 23:27:33 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 37EB767373; Wed, 15 Jun 2022 08:27:30 +0200 (CEST)
Date:   Wed, 15 Jun 2022 08:27:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/6] block: cleanup variable naming in get_max_io_size
Message-ID: <20220615062729.GA22728@lst.de>
References: <20220614090934.570632-1-hch@lst.de> <20220614090934.570632-5-hch@lst.de> <4b846753-bb89-c123-2813-bcb587fdcaaf@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b846753-bb89-c123-2813-bcb587fdcaaf@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 09:50:00AM -0700, Bart Van Assche wrote:
> On 6/14/22 02:09, Christoph Hellwig wrote:
>> get_max_io_size has a very odd choice of variables names and
>> initialization patterns.  Switch to more descriptive names and more
>> clear initialization of them.
>
> Hmm ... what is so odd about the variable names? I have done my best to 
> chose clear and descriptive names when I introduced these names.

Major confusion:

 - we have a local variable to hold the queue max sectors value,
   but it is callled sectors
 - while we have a variable the holds the rounded end of the I/O
   range that is called max_sectors

Minor confusion:

 - a variable that hold that rounded start of the range has a random
   _offset suffix despite not really being an offset
