Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4B45003A4
	for <lists+linux-block@lfdr.de>; Thu, 14 Apr 2022 03:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiDNBag (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 13 Apr 2022 21:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiDNBaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 21:30:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935BF3A5C6
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 18:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6s+LWxVRdsflumj/D/kMiwRTy6+4yPRgy47Cv7E/LOc=; b=C4tbcO89Q0AGkoq0CVlXNHbFLg
        YbQf4syNjiASw2JIh1iF9CDpifm/2kMipI0kKKR7FedFHMKCJkeSCjzyYiVvdk651dmq9lxOh4djS
        DPnFUrpprftvOnjArw2mRymYkouiZ8MNWOkKpHKoZ5NTg56/GTjcyrSyJ4TT4rgu/JAK3oZ48faYw
        zWo4wHXOsFpUNu8I81XBCCXF+wCWTUv6jmETwZ/tf6GtNBpbxYw5d+fHHvK3MO35nHYirz6N+e+D1
        9JgEVd+yUxQ1qkm1f4DlrJMaoqhMv/nrn2me/Kyg4IcvAsUXShOB4LlFl40Ew6JMNzxgawy8mZRv6
        Lybj5PPw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neoHM-003HKH-85; Thu, 14 Apr 2022 01:28:12 +0000
Date:   Wed, 13 Apr 2022 18:28:12 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
Subject: Re: blktests srp failures with a guest with kdevops on v5.17-rc7
 removal
Message-ID: <Yld4rOqj24l72UaR@bombadil.infradead.org>
References: <YldoSh6o5sbifsJf@bombadil.infradead.org>
 <8db9ded3-ae12-3c56-5ac6-35ee9b9117bc@acm.org>
 <Yldyy3ZSEbaTxwSj@bombadil.infradead.org>
 <Yld0t1DeZdNBzMR+@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yld0t1DeZdNBzMR+@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 13, 2022 at 06:11:19PM -0700, Luis Chamberlain wrote:
> A couple of more failures on the 3rd ru

30 minutes later and the list of tests I can actually run *without*
failures are just srp/003 and srp/004 and these don't fail as they
are not run as I don't have an old device mapper.

So it's not looking too good. But hey, things don't crash.

  Luis
