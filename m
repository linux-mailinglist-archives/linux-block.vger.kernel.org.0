Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427AD652865
	for <lists+linux-block@lfdr.de>; Tue, 20 Dec 2022 22:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiLTV2r (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 20 Dec 2022 16:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbiLTV2q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 16:28:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C071EAE0
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 13:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uk//xnFF9s+wkGimPH4UmEyWe6edFnqnttAQCxTAmrY=; b=WlQYN464FuPztf/O685AkO1e7z
        MhMsMYLRl9iJR2hOyX7jUDLiENSQDePxD5Syow3icZ4W97vlqqTc33Hmf+BXsukBlJXGULFrBvmd3
        sLg4JVDrlWEFXpbbdiGOzguSNxvU0i39nB2xf5VZ+bpB1NRRVzxOm5iRPgp/O2gCHYPsUP+sEMb3u
        XX+HLisgIQa75oMOl7CW4pYuPLM+2HslUbo5ck9MCROzfx/CzKN5fE4ynSlCu1BJWxDma/GleczO3
        QqDM/kYQp2zHI7q9dapvDhkySipq/2UhNkY4gn3GJZYu2aeQm8XQskJV8AmEO0LS0TGCGde215iKp
        trhlx9Xg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p7kAF-004LtL-RQ; Tue, 20 Dec 2022 21:28:43 +0000
Date:   Tue, 20 Dec 2022 13:28:43 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     osandov@fb.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] blktests: replace module removal with patient module
 removal
Message-ID: <Y6IpC3Rv5QRSRCs0@bombadil.infradead.org>
References: <YlogluONIoc1VTCI@bombadil.infradead.org>
 <c584cf40-2181-2617-92aa-bcdbc56a5ab8@acm.org>
 <Yl2KU6vLxawrIXi/@bombadil.infradead.org>
 <1293a7e7-71d0-117e-1a4f-8ccfc609bc43@acm.org>
 <Ynv2BaRJcL0I3vAR@bombadil.infradead.org>
 <71af1a93-1950-b480-afbb-d61b6590f6fe@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71af1a93-1950-b480-afbb-d61b6590f6fe@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 11, 2022 at 11:22:52AM -0700, Bart Van Assche wrote:
> On 5/11/22 10:44, Luis Chamberlain wrote:
> > I suspect you ran into the issue of the refcnt being bumped by anything
> > multipathd tried, and not being able to remove the module, but  if it is
> > adding *new* mpath devices that would seem like a bug which we'd need to
> > address. The point to the patient module removal is to keep on trying
> > until the recnt  is 0 and if that fails wait and keep trying, until the
> > the timeout. Anytihng userspace does, say multipathd does, like
> > bdev_open(), would be yielded to.
> > 
> > So I'd like to keep this change as it is exactly the sort of hack I am
> > chasing after with this crusade.
> > 
> > Let me know how you'd like to proceed so I can punt a v3.
> 
> Please implement the patient module removal and the stop_srp_ini() behavior
> changes as separate patches such that the stop_srp_ini() behavioral changes
> can be reverted easily in case these would trigger a regression.

I had dropped the ball here, because well, it takes a bit of time to
re-test everything. And also just around this time I was also ironing
out how to properly automate testing for srp. That's all done now
and I finally had time to re-test so will send a v3 out shortly.

  Luis
