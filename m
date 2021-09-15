Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1D540C0AF
	for <lists+linux-block@lfdr.de>; Wed, 15 Sep 2021 09:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhIOHlt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 15 Sep 2021 03:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbhIOHls (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 03:41:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268B2C061768;
        Wed, 15 Sep 2021 00:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RgofGn+umU+m4JnOxQaFBbakywgOkw508JWEpMYIKQ4=; b=JBUImLVxSMv7b3xVJzY4R03fQ3
        ApTXzkq+JHpWv8zrY4lKcQ0+4SBPofIAeaK2ZP97uytJQe3QlN18vw/E5cGgIfxl3s1Qbtrs5uTyJ
        q7wBlHrr9e2GTVWWElYRPkFbvm2RM8gasUNNTyAkc9X5u+Ntd7CyW+9C/KkhVdehtbuV2KfV0dYy7
        llKmWgWWzlAq2FIg32YGVa9ZOldgmfr360tPvDXbIcrh1EWRIGGqVtdGjrhSvDo1KZJgcOfTwSzwd
        2/G5Fl79d4v6mg33mTbtPBJxg/G3ABJcz3PhrMI5GoewLyDlO3QYi/R7yzpQtXHgKnatcay4gMM6J
        dbN5flag==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQPWL-00FT6b-Nd; Wed, 15 Sep 2021 07:40:06 +0000
Date:   Wed, 15 Sep 2021 08:39:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        Satya Tangirala <satyaprateek2357@gmail.com>
Subject: Re: [PATCH 2/5] blk-crypto-fallback: consolidate static variables
Message-ID: <YUGjSR1g+EH0o2xo@infradead.org>
References: <20210913013135.102404-1-ebiggers@kernel.org>
 <20210913013135.102404-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913013135.102404-3-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 12, 2021 at 06:31:32PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> blk-crypto-fallback.c has many static variables with inconsistent names,
> e.g. "blk_crypto_*", "crypto_*", and some unprefixed names.  This is
> confusing.  Consolidate them all into a struct named
> "blk_crypto_fallback" so that it's clear what they are.

I always find this pattern of a single instance global struct rather
confusing.  What is the advantage over just using a consistent prefix?
