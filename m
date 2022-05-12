Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527D55245C3
	for <lists+linux-block@lfdr.de>; Thu, 12 May 2022 08:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347675AbiELG2e (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 12 May 2022 02:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350345AbiELG2L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 02:28:11 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921966D857;
        Wed, 11 May 2022 23:27:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 432EA68BEB; Thu, 12 May 2022 08:27:28 +0200 (CEST)
Date:   Thu, 12 May 2022 08:27:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Christoph Hellwig <hch@lst.de>, song@kernel.org,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] md: remove most calls to bdevname
Message-ID: <20220512062727.GA20557@lst.de>
References: <20220512061913.1826735-1-hch@lst.de> <290eada6-226a-6570-1860-c4ca1d680993@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <290eada6-226a-6570-1860-c4ca1d680993@molgen.mpg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 12, 2022 at 08:25:28AM +0200, Paul Menzel wrote:
> Dear Christoph,
>
>
> Thank you for the patch.
>
> Am 12.05.22 um 08:19 schrieb Christoph Hellwig:
>> Use the %pg format specifier to save on stack consuption and code size.
>
> consu*m*ption
>
> Did you do any measurements?

Each BDEVNAME_SIZE array consumes 32 bytes on the stack, and they are
gone now without any additional stack usage elsewhere.
