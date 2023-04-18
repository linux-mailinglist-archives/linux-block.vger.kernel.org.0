Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6A66E686B
	for <lists+linux-block@lfdr.de>; Tue, 18 Apr 2023 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjDRPlC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 18 Apr 2023 11:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjDRPlB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 11:41:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D880B9EC7
        for <linux-block@vger.kernel.org>; Tue, 18 Apr 2023 08:40:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C96176732D; Tue, 18 Apr 2023 17:34:56 +0200 (CEST)
Date:   Tue, 18 Apr 2023 17:34:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     hch@lst.de, linux-block@vger.kernel.org
Subject: Re: How best to get the size of a blockdev from a file?
Message-ID: <20230418153456.GA10282@lst.de>
References: <1609851.1681812012@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609851.1681812012@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 18, 2023 at 11:00:12AM +0100, David Howells wrote:
> Hi Christoph,
> 
> It seems that my use of i_size_read(file_inode(in)) in filemap_splice_read()
> to get the size of the file to be spliced from doesn't work in the case of
> blockdevs and it always returns 0.
>
> What would be the best way to get the blockdev size?  Look at
> file->f_mapping->i_size maybe?

Yes.  Everything using an inode in generic read/write helpers always
needs to use file->f_mapping->host to get at the inode.  Not just for
the size.
