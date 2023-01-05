Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C6665F022
	for <lists+linux-block@lfdr.de>; Thu,  5 Jan 2023 16:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjAEPdj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 5 Jan 2023 10:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjAEPdS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Jan 2023 10:33:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB9FDAA;
        Thu,  5 Jan 2023 07:33:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF485B81B05;
        Thu,  5 Jan 2023 15:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC27C433D2;
        Thu,  5 Jan 2023 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672932794;
        bh=hCKQD9L/C/CByk2ZxqTUtzV8qq/Igqt6nQ632bHe5aY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XPt4aVoGixRDU7A/rg2pqMFqXWFU5sJzw6y+srOluzJhaHVdZWkiPzwVcFA7NQXGZ
         sqMnju2wJ2qj5Yr35tXiIJwO+7SlKqGOCL0SKXg6tV1j/xLjRgim6HIswqnX1evss6
         pRU1RBOp6yXeDlBWzG9Too14aFMtX0RjLdIoQjJFgPXmr25hFp4rIhyFB+5MAXTLtw
         hUx5H543bcfS8IhJVUoOp9eExwwen20tKtRzkMsTG7aBGUHy0Lobps5gLdXXPKRjuB
         FhdthNIlj+EEIHFaENCw0KwrA8s6sz1owlV7UaYz2QEopqnFy8LxmIMiKQBGcX9jw4
         7DG7MPc9NMGxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 53F3B5C029A; Thu,  5 Jan 2023 07:33:14 -0800 (PST)
Date:   Thu, 5 Jan 2023 07:33:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, linux-block@vger.kernel.org
Subject: Re: [PATCH rcu 07/27] block: Remove "select SRCU"
Message-ID: <20230105153314.GS4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-7-paulmck@kernel.org>
 <1a9d0cdf-d39e-7eb5-39dd-3e425016c579@kernel.dk>
 <Y7aE2zzdTyjNId6w@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7aE2zzdTyjNId6w@osiris>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 05, 2023 at 09:05:47AM +0100, Heiko Carstens wrote:
> On Wed, Jan 04, 2023 at 05:43:07PM -0700, Jens Axboe wrote:
> > On 1/4/23 5:37 PM, Paul E. McKenney wrote:
> > > Now that the SRCU Kconfig option is unconditionally selected, there is
> > > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > > Kconfig statements.
> > 
> > I'm assuming something earlier made this true (only CC'ed on this patch,
> > not the cover letter or interesting btis...), then:
> 
> I was wondering the same. But it is already unconditionally enabled
> since commit 0cd7e350abc4 ("rcu: Make SRCU mandatory").

Ah, apologies for the terseness!

I took the coward's way out by making CONFIG_SRCU unconditional during
the last merge window and removing all references during this merge
window.  ;-)

							Thanx, Paul
