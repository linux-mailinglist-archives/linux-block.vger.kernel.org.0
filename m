Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168CA3F4DFB
	for <lists+linux-block@lfdr.de>; Mon, 23 Aug 2021 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhHWQHE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 23 Aug 2021 12:07:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60902 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWQHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 12:07:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A448B21FFE;
        Mon, 23 Aug 2021 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629734778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=emgdQM4ALijpY/q4pLD4A6w9BfTTbJEoaHoeF1tVe9I=;
        b=Tz6R2VtpGEuIzNyu4Vq7taAmQKW50cHfyes4DRP1iI6qizoa/O3/xlyvPx8r/SBVOoiSmd
        MbZAQVUhIUHKjb7h6hLNamOrYCcZm1OZRho4PgVqSqDS3/rCn8CmJynEDCUsOXaDKNED9L
        26I/dlfwnAfk+v/4pxEjMwNUuCSUsOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629734778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=emgdQM4ALijpY/q4pLD4A6w9BfTTbJEoaHoeF1tVe9I=;
        b=aKLbjcCLSMI31aW3bvdLfUTzfPtlPQmki9MDHwqsxF/dh/s5297GjMfd1QQxTefowfb9u8
        MwfHw9Yh8DdSx3Cg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 97F28A3BBD;
        Mon, 23 Aug 2021 16:06:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7C0B51F2BA4; Mon, 23 Aug 2021 18:06:18 +0200 (CEST)
Date:   Mon, 23 Aug 2021 18:06:18 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: False waker detection in BFQ
Message-ID: <20210823160618.GI21467@quack2.suse.cz>
References: <20210505162050.GA9615@quack2.suse.cz>
 <FFFA8EE2-3635-4873-9F2C-EC3206CC002B@linaro.org>
 <20210813140111.GG11955@quack2.suse.cz>
 <A72B321A-3952-4C00-B7DB-67954B05B99A@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A72B321A-3952-4C00-B7DB-67954B05B99A@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 23-08-21 15:58:25, Paolo Valente wrote:
> > Currently I'm running wider set of benchmarks for the patches to see
> > whether I didn't regress anything else. If not, I'll post the patches to
> > the list.
> 
> Any news?

It took a while for all those benchmarks to run. Overall results look sane,
I'm just verifying by hand now whether some of the localized regressions
(usually specific to a particular fs+machine config) are due to a measurement
noise or real regressions...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
