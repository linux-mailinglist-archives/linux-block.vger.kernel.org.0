Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4566F305906
	for <lists+linux-block@lfdr.de>; Wed, 27 Jan 2021 12:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236211AbhA0K7O (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 27 Jan 2021 05:59:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:46450 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236284AbhA0K5n (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 05:57:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611745017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X22pjoc3R05cEyBcSdDS4M+jzZBi8OqIcNLr6tG6NLo=;
        b=nWOlT5MKFwcGje+YqBzXMPqVKCRFjabR9mcyxK5VaWeAAj2AB61FSPqmvMIC96JshZSh15
        E/ttqk3HsfnyQzDb3FuyzUWFrqGv9F4pRupOeYjEtUX5mzbiu9+YhMg+RkxaVWKQYiyG/v
        y4OM9V4DsGMBEY4bt99qv7mCEL/8r3I=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F674AD2B;
        Wed, 27 Jan 2021 10:56:57 +0000 (UTC)
Subject: Re: [PATCH] xen-blkback: fix compatibility bug with single page rings
To:     Paul Durrant <paul@xen.org>
Cc:     Paul Durrant <pdurrant@amazon.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org
References: <20210127103034.2559-1-paul@xen.org>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <cd70ae5e-a389-7521-8caf-15650a276152@suse.com>
Date:   Wed, 27 Jan 2021 11:56:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127103034.2559-1-paul@xen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27.01.2021 11:30, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> Prior to commit 4a8c31a1c6f5 ("xen/blkback: rework connect_ring() to avoid
> inconsistent xenstore 'ring-page-order' set by malicious blkfront"), the
> behaviour of xen-blkback when connecting to a frontend was:
> 
> - read 'ring-page-order'
> - if not present then expect a single page ring specified by 'ring-ref'
> - else expect a ring specified by 'ring-refX' where X is between 0 and
>   1 << ring-page-order
> 
> This was correct behaviour, but was broken by the afforementioned commit to
> become:
> 
> - read 'ring-page-order'
> - if not present then expect a single page ring
> - expect a ring specified by 'ring-refX' where X is between 0 and
>   1 << ring-page-order
> - if that didn't work then see if there's a single page ring specified by
>   'ring-ref'
> 
> This incorrect behaviour works most of the time but fails when a frontend
> that sets 'ring-page-order' is unloaded and replaced by one that does not
> because, instead of reading 'ring-ref', xen-blkback will read the stale
> 'ring-ref0' left around by the previous frontend will try to map the wrong
> grant reference.
> 
> This patch restores the original behaviour.

Isn't this only the 2nd of a pair of fixes that's needed, the
first being the drivers, upon being unloaded, to fully clean up
after itself? Any stale key left may lead to confusion upon
re-use of the containing directory.

Jan
