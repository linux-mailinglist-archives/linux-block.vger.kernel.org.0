Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F166776BA6
	for <lists+linux-block@lfdr.de>; Thu, 10 Aug 2023 00:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjHIWCw (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 9 Aug 2023 18:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHIWCu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 18:02:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFCDFE
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 15:02:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28EE164AEC
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 22:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71134C433C7;
        Wed,  9 Aug 2023 22:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691618568;
        bh=0JZWBZyc7Y9wfXoloSzdrw2QgX5w5zayWt9GtZxJQ9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m2k/MCrmXLrlwGOwtMvOufID5yN80HZ7vUG6CqnNVeojN/TVxLbQVQzcupTh2+vY3
         qXw1HAty12qGgegGw3NLPlJ/o3JslNfLQs7YLK3+xvY+9vDJZLgIpr+4Utc4Xjqgai
         HDilGbnyRQgHykrv9hXwvqxTZZfWLl4rX5AxoHWSqHG+IZe8ZJZLVkeOQBX82cHgLM
         XeMjem/8yGTISRI8vcj0UCgIadWdXcnPO2t+9ugsG63Cfe7DgblxCrd7tbLkcn+K3p
         RK4HeGMfCRBYUZ9IyVqOtjcKewXNu/jItz1zKjpFlKFR0a/VmKodot5HXjSM7/IOIR
         YqBa836GN00gQ==
Date:   Wed, 9 Aug 2023 15:02:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
        pabeni@redhat.com, jiri@resnulli.us, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
        axboe@kernel.dk, pshelar@ovn.org, jmaloy@redhat.com,
        ying.xue@windriver.com, jacob.e.keller@intel.com,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        dev@openvswitch.org, tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 03/10] genetlink: remove userhdr from struct
 genl_info
Message-ID: <20230809150246.4d1c0be6@kernel.org>
In-Reply-To: <6f4b7e118ac60394db7e5f8e062e8ddeb4370323.camel@sipsolutions.net>
References: <20230809182648.1816537-1-kuba@kernel.org>
        <20230809182648.1816537-4-kuba@kernel.org>
        <6f4b7e118ac60394db7e5f8e062e8ddeb4370323.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 09 Aug 2023 22:59:47 +0200 Johannes Berg wrote:
> On Wed, 2023-08-09 at 11:26 -0700, Jakub Kicinski wrote:
> > Only three families use info->userhdr and fixed headers
> > are discouraged for new families. So remove the pointer
> > from struct genl_info to save some space. Compute
> > the header pointer at runtime. Saved space will be used
> > for a family pointer in later patches.  
> 
> Seems fine to me, but I'm not sure I buy the rationale that it's for
> saving space - it's a single pointer on the stack? I'd probably argue
> the computation being pointless for basically everyone except for a
> handful users?

Fair, I'll update all the commit messages.

> Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

Thanks!
