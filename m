Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00765711A71
	for <lists+linux-block@lfdr.de>; Fri, 26 May 2023 01:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjEYXEf (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 25 May 2023 19:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEYXEf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 19:04:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D834AE2;
        Thu, 25 May 2023 16:04:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6446764BC3;
        Thu, 25 May 2023 23:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E110C433EF;
        Thu, 25 May 2023 23:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685055872;
        bh=XdOmX0J4cMjw/F8WqcmMWlj3q2i0+z3j4UltRDsxXas=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jPAS+ejc27tlKAjqH0sSeK26lSC+pzZBMxMiVfvfOGF3r7Xaj2BNyzz1O9GohGZiQ
         gH7vJKASVwfO4wv4I6YddGKdksSLzjyfaY08n8v5lJC3UbQe16EkR1GJUjo1m+SNCP
         TkU50vJ9HnhrSL1H0TnqmdjwU/066gcw2iPvp7BH1eLhfKZd5u+kPftBCn81ahKWcJ
         PTeXWWf8bK2A07eIxJBXJOagUJ3tNg406KzzcOUPqhG6yworxHonCLGzqrIkPONcLo
         AGUL+jSnREV1cguhgYPm7Txv8qLIvG39Bk1708mGINY6gd+DdRYSx6szcAt4YGZmcf
         JiMHWtr+il98A==
Message-ID: <9d1a3d1a-b726-5144-4911-de6b77d9bf02@kernel.org>
Date:   Fri, 26 May 2023 08:04:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] zonefs: Call zonefs_io_error() on any error from
 filemap_splice_read()
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@kvack.org
References: <3788353.1685003937@warthog.procyon.org.uk>
 <ZG99DRyH461VAoUX@casper.infradead.org>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZG99DRyH461VAoUX@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/23 00:21, Matthew Wilcox wrote:
> On Thu, May 25, 2023 at 09:38:57AM +0100, David Howells wrote:
>>     
>> Call zonefs_io_error() after getting any error from filemap_splice_read()
>> in zonefs_file_splice_read(), including non-fatal errors such as ENOMEM,
>> EINTR and EAGAIN.
>>
>> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
>> Link: https://lore.kernel.org/r/5d327bed-b532-ad3b-a211-52ad0a3e276a@kernel.org/
> 
> This seems like a bizarre thing to do.  Let's suppose you got an
> -ENOMEM.  blkdev_report_zones() is also likely to report -ENOMEM in
> that case, which will cause a zonefs_err() to be called.  Surely
> that can't be the desired outcome from getting -ENOMEM!

Right... What I want to make sure here is that the error we get is not the
result of a failed IO. Beside EIO, are there any other cases ?
I can think of at least:
1) -ETIMEDOUT -> the drive is not responding. In this case, calling
zonefs_io_error() may not be useful either.
2) -ETIME: The IO was done with a duration limit (e.g. active time limit) and
was aborted by the drive because it took too long. Calling zonefs_io_error() for
this case is also not useful.

But I am thinking block layer (blk_status_t to errno conversion) here. Does the
folio code *always* return EIO if it could not get a page/folio, regardless of
the actual bio status ?

-- 
Damien Le Moal
Western Digital Research

