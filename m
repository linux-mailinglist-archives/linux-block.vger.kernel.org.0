Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB5770A44C
	for <lists+linux-block@lfdr.de>; Sat, 20 May 2023 03:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjETBbg (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 19 May 2023 21:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjETBbf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 21:31:35 -0400
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 May 2023 18:31:34 PDT
Received: from out-55.mta0.migadu.com (out-55.mta0.migadu.com [IPv6:2001:41d0:1004:224b::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFC4AF
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 18:31:34 -0700 (PDT)
Date:   Fri, 19 May 2023 21:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684545972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7zURH3nRhfopYDNsgFsJqj8BK6IdALtBaLykLIdXVXY=;
        b=m8mNQp/SEoSnQKDdZD72CtcRdJOgBu6uw8TAun2J+cgrzfwo/rjQF+mohr+f+UQEWoPXFM
        clrF/mMliqbzrnB7MArLGXeC7c1IWrEEWSsnpOsV0SWnq6lfQkC6WDsOa0nA4kw66vQIBZ
        ut//N6boR/syBxEd4lEofwBrf7hzZyg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v20 29/32] block: Replace BIO_NO_PAGE_REF with
 BIO_PAGE_REFFED with inverted logic
Message-ID: <ZGghr0/lFRKmaoAX@moria.home.lan>
References: <20230519074047.1739879-1-dhowells@redhat.com>
 <20230519074047.1739879-30-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519074047.1739879-30-dhowells@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 19, 2023 at 08:40:44AM +0100, David Howells wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> Replace BIO_NO_PAGE_REF with a BIO_PAGE_REFFED flag that has the inverted
> meaning is only set when a page reference has been acquired that needs to
> be released by bio_release_pages().

What was the motivation for this patch?
