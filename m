Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8007D51902C
	for <lists+linux-block@lfdr.de>; Tue,  3 May 2022 23:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242956AbiECVjp (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 May 2022 17:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiECVjp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 May 2022 17:39:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CBA3134F;
        Tue,  3 May 2022 14:36:11 -0700 (PDT)
Received: from penguin.thunk.org (cn-8-34-116-185.paclightwave.com [8.34.116.185] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 243La4c4019236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 May 2022 17:36:06 -0400
Received: by penguin.thunk.org (Postfix, from userid 1000)
        id ECB33446C7; Tue,  3 May 2022 14:35:59 -0700 (PDT)
Date:   Tue, 3 May 2022 14:35:59 -0700
From:   tytso <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: Re: SPDX tag and top of file comment cleanups for the loop driver
Message-ID: <YnGgP7ubsXxFTaZE@mit.edu>
References: <20220419063303.583106-1-hch@lst.de>
 <YnGLRAuS8QGaSADK@mit.edu>
 <20220503201334.GA7325@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503201334.GA7325@lst.de>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 03, 2022 at 10:13:34PM +0200, Christoph Hellwig wrote:
> On Tue, May 03, 2022 at 04:06:28PM -0400, Theodore Ts'o wrote:
> > > Ted, does the SPDX tag match your original licensing decision back then,
> > > or do we need to correct it?  Does the auto-converted tag on the loop.h
> > > SPDX header (GPL1.0 or later with syscall exception) make sense, or
> > > should that have been GPL2 only with syscall exception?
> > 
> > I think you've removed the loop.h in the patch series, so it shouldn't
> > matter what the tag would be for loop.h, right?  In any case, GPLv2
> > only was certainly the intent at the time.
> 
> Well, there were two loop.h files - drivers/block/loop.h gets removed
> in this series, but include/uapi/linux/loop.h stays.

Ah, thanks for the clarification.  Yes, GPLv2 with the syscall
extension is what would be appropriate for include/uapi/linux/loop.h.

	     	  	   	       - Ted

