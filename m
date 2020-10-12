Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC35C28BE5E
	for <lists+linux-block@lfdr.de>; Mon, 12 Oct 2020 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403995AbgJLQqB (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 12 Oct 2020 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390541AbgJLQqB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Oct 2020 12:46:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA411C0613D0;
        Mon, 12 Oct 2020 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=h5j4wcpVtXZLGhNpJo9+h3r4FuiBGt0jGJAE34cafXY=; b=Y1zprB7JIZn1TSp93/8jvbop3Y
        lr3nQrOeisTRQp34205+WklIZoerz74CTIU8V5N3/5/aNs30MmrVglt7ha40qBBu+h5XBl6zqyUxP
        UHivng0mQmJFEivw5XXi+q2jbvXySVQYg9mLXsfud/P9so1HbRcCFYltmN2CIsOsEV/45SdQq1DPq
        /hwNZspPBW/rsjDLBsNDqnHqhBxXXG0CPB0b6Q7DJLPvKC3V4VS9csViwUJOg8R3bYqzrJjjeDU6S
        BQXfecuOpFq50xcc8E0egYCNM5M/Bxz+2GS/BjzWaxtsnTjcVYPAjz2lgniv7nPlCcXzpLkYmFebP
        9YpcNFiQ==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kS0xP-000538-Rx; Mon, 12 Oct 2020 16:45:56 +0000
Subject: Re: [PATCH v2 01/22] mpool: add utility routines and ioctl
 definitions
To:     Nabeel M Mohamed <nmeeramohide@micron.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Cc:     smoyer@micron.com, gbecker@micron.com, plabat@micron.com,
        jgroves@micron.com
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201012162736.65241-2-nmeeramohide@micron.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <954153c4-ee2f-2a2f-8643-8ff67d8cd649@infradead.org>
Date:   Mon, 12 Oct 2020 09:45:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201012162736.65241-2-nmeeramohide@micron.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/20 9:27 AM, Nabeel M Mohamed wrote:
> +#define MPIOC_MAGIC             ('2')

Hi,

That value should be documented in
Documentation/userspace-api/ioctl/ioctl-number.rst.

thanks.
-- 
~Randy

