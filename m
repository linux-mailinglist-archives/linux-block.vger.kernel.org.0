Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E208539D25
	for <lists+linux-block@lfdr.de>; Wed,  1 Jun 2022 08:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiFAGUu (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 1 Jun 2022 02:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349772AbiFAGUr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:20:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AFE8B08F
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:20:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7F31D68AFE; Wed,  1 Jun 2022 08:20:43 +0200 (CEST)
Date:   Wed, 1 Jun 2022 08:20:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 2/9] common: add a helper if a driver is
 available
Message-ID: <20220601062043.GA22611@lst.de>
References: <20220530130811.3006554-1-hch@lst.de> <20220530130811.3006554-3-hch@lst.de> <20220531111245.h5fclixuoltcvea3@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531111245.h5fclixuoltcvea3@shindev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 31, 2022 at 11:12:45AM +0000, Shinichiro Kawasaki wrote:
> > +_have_driver()
> > +{
> > +	local modname="${1/-/_}"
> > +
> > +	if [ ! -d "/sys/module/${modname}" ] && ! modprobe -q ${modname}; then
> 
> Nit: double quote is required for ${modname} to make shellcheck happy.

It is aready quote when assigning to modname, so there is no actual need.
But I'll add the quotes to make the checker happy.
