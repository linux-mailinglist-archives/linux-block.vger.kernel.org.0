Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645336CC8BD
	for <lists+linux-block@lfdr.de>; Tue, 28 Mar 2023 19:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjC1RCv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 28 Mar 2023 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjC1RCt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 13:02:49 -0400
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 10:02:47 PDT
Received: from out-9.mta0.migadu.com (out-9.mta0.migadu.com [IPv6:2001:41d0:1004:224b::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E78FE1B5
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 10:02:46 -0700 (PDT)
Date:   Tue, 28 Mar 2023 12:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680022641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1o1k2Rmc+4BTUfq+dOCfHNDzWQWBXDCnLlScnSphUD4=;
        b=jJSswMWCZrOd8MvJ9mfrLTlbhA00UJ9AkOzyxboQzjKD73P2BxHWy7l+sPV1N6XEgX2XId
        KxnFEPmXZMdu5ODBe3aTniMNelqOAnvi4uloCl3fHfj4mBw0xeLIpZpq9UaMeajCIWdzXL
        feQts4QoxRShOAnPfK7TGrcD4xWqwQw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Phillip Lougher <phillip.lougher@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk,
        Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: [PATCH 0/2] bio iter improvements
Message-ID: <ZCMcbnlZchi3kWIL@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <CAB3woddAP_6uOUJ4Yjj_PATme-CQao3p2JErBBtjtpzYxQejng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB3woddAP_6uOUJ4Yjj_PATme-CQao3p2JErBBtjtpzYxQejng@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 28, 2023 at 02:42:28PM +0100, Phillip Lougher wrote:
> On Mon, Mar 27, 2023 at 7:02 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > Small patch series cleaning up/standardizing bio_for_each_segment_all(),
> > which means we can use the same guts for bio_for_each_folio_all(),
> > considerably simplifying that code.
> >
> > The squashfs maintainer will want to look at and test those changes,
> > that code was doing some slightly tricky things. The rest was a pretty
> > mechanical conversion.
> 
> An eyeball of the changes doesn't bring up anything obviously wrong.
> 
> I'll apply and do some tests.
> 
> Phillip
> 
> BTW please CC me on the cover letter as well as patch [1/2].

Will do.

There were some squashfs files that got missed, there's a fixup patch
you'll want in this branch:

https://evilpiepirate.org/git/bcachefs.git/log/?h=bio_folio_iter
