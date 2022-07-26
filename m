Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10960581182
	for <lists+linux-block@lfdr.de>; Tue, 26 Jul 2022 12:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiGZK5i (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 26 Jul 2022 06:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiGZK5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 06:57:37 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66D430F5E
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 03:57:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D46268AA6; Tue, 26 Jul 2022 12:57:33 +0200 (CEST)
Date:   Tue, 26 Jul 2022 12:57:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] remove the sx8 block driver
Message-ID: <20220726105733.GA30558@lst.de>
References: <20220721064102.1715460-1-hch@lst.de> <05e6e50e-073b-3017-7630-33b7571d07c2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05e6e50e-073b-3017-7630-33b7571d07c2@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 25, 2022 at 05:23:31PM -0600, Jens Axboe wrote:
> On 7/21/22 12:41 AM, Christoph Hellwig wrote:
> > This driver is for fairly obscure hardware, and has only seen random
> > drive-by changes after the maintainer stopped working on it in 2015
> > (about a year and a half after it was introduced).  It has some
> > "interesting" block layer interactions, so let's just drop it unless
> > anyone complains.
> 
> 2015? I think you mean 2005, or earlier.

Yes, this was meant to be 2015.
