Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBBC518DDC
	for <lists+linux-block@lfdr.de>; Tue,  3 May 2022 22:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiECUKO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 3 May 2022 16:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbiECUKJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 May 2022 16:10:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC7521E0F;
        Tue,  3 May 2022 13:06:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 243K6SNK021603
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 May 2022 16:06:28 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 38AF315C3EA1; Tue,  3 May 2022 16:06:28 -0400 (EDT)
Date:   Tue, 3 May 2022 16:06:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: Re: SPDX tag and top of file comment cleanups for the loop driver
Message-ID: <YnGLRAuS8QGaSADK@mit.edu>
References: <20220419063303.583106-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419063303.583106-1-hch@lst.de>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 19, 2022 at 08:32:59AM +0200, Christoph Hellwig wrote:
> Hi Jens, hi Ted,
> 
> the loop driver still had no SPDX tag, so this series cleans up some
> lose ends and fixes that up.
> 
> Ted, does the SPDX tag match your original licensing decision back then,
> or do we need to correct it?  Does the auto-converted tag on the loop.h
> SPDX header (GPL1.0 or later with syscall exception) make sense, or
> should that have been GPL2 only with syscall exception?

I think you've removed the loop.h in the patch series, so it shouldn't
matter what the tag would be for loop.h, right?  In any case, GPLv2
only was certainly the intent at the time.

Cheers,

						- Ted
