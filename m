Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC062CCA7
	for <lists+linux-block@lfdr.de>; Wed, 16 Nov 2022 22:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiKPV3R (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 16 Nov 2022 16:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiKPV3Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2022 16:29:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E6D4E412
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 13:29:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D39F361FC7
        for <linux-block@vger.kernel.org>; Wed, 16 Nov 2022 21:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77E9C433C1;
        Wed, 16 Nov 2022 21:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1668634154;
        bh=PYSJpKFSv9Yw0fLdeZTIHzN3HuZ8VupG/uOb0QE2L8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FUQdtVNIREkg3e0lRCm28VETKwJ0cddzycnHiqQVofKqrlBZ2d1WjHC3dG0ibuiWy
         UGg6QA7iT309mSw1F+soRcJ4aqj5xMUYljpN1+9QBldyHOuScSDQpPOxU5dkVV3QBY
         oZFTR0FT792l833N4lZxHZlKT/ltbgmZ3/e/798M=
Date:   Wed, 16 Nov 2022 13:29:13 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-mm@kvack.org, axboe@kernel.dk, clm@meta.com,
        willy@infradead.org, hch@infradead.org
Subject: Re: [RFC PATCH v3 07/14] mm: add bdi_set_max_bytes() function.
Message-Id: <20221116132913.7105e98f7c7111f87ad37797@linux-foundation.org>
In-Reply-To: <20221024190603.3987969-8-shr@devkernel.io>
References: <20221024190603.3987969-1-shr@devkernel.io>
        <20221024190603.3987969-8-shr@devkernel.io>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Oct 2022 12:05:56 -0700 Stefan Roesch <shr@devkernel.io> wrote:

> This introduces the bdi_set_max_bytes() function. The max_bytes function
> does not store the max_bytes value. Instead it converts the max_bytes
> value into the corresponding ratio value.
> 
> ...
>
> +EXPORT_SYMBOL_GPL(bdi_set_max_bytes);

Is this needed?
