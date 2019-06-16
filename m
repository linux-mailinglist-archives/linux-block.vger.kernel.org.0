Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD03347467
	for <lists+linux-block@lfdr.de>; Sun, 16 Jun 2019 13:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfFPLxE (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sun, 16 Jun 2019 07:53:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:48234 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfFPLxE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Jun 2019 07:53:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 08217AEF9;
        Sun, 16 Jun 2019 11:53:03 +0000 (UTC)
Subject: Re: [PATCH 0/2] bcache: two emergent fixes for Linux v5.2-rc5
 (use-after-scope)
To:     Dmitry Vyukov <dvyukov@google.com>
References: <CACT4Y+bgr4aC-DZuLCyhxpcES39mbEgLV_UWakmkOYEBPrOkwg@mail.gmail.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        linux-block <linux-block@vger.kernel.org>,
        Rolf Fokkens <rolf@rolffokkens.nl>,
        Pierre JUHEN <pierre.juhen@orange.fr>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Nix <nix@esperi.org.uk>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will.deacon@arm.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <1c976ca8-6ba6-d27a-3fb0-3f77d7dfc523@suse.de>
Date:   Sun, 16 Jun 2019 19:52:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bgr4aC-DZuLCyhxpcES39mbEgLV_UWakmkOYEBPrOkwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/6/16 6:23 下午, Dmitry Vyukov wrote:
> Hi,
> 
> This is regarding the subj patch:
> https://bugzilla.kernel.org/show_bug.cgi?id=203573
> https://www.spinics.net/lists/linux-bcache/msg07474.html
> (don't see a way to reply to the patch)
> 
> This looks like a serious bug that would have been caught by
> use-after-scope mode in KASAN given any coverage of the involved code
> (i.e. any tests that executes the function once) if I am reading this
> correctly.
> But use-after-scope detection was removed in:
> 7771bdbbfd3d kasan: remove use after scope bugs detection.
> because it does not catch enough bugs.
> Hard to say if this bug is enough rationale to bring use-after-scope
> back, but it is a data point. FWIW this bug would have been detected
> during patch testing with no debugging required.
> 

Hi Dmitry,

I although thought it should be reported by compiler, but no idea why
compiler didn't complain.

Anyway, since now I start to enable KASAN in my testing.

Thanks.

-- 

Coly Li
