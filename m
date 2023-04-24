Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6A6ECC09
	for <lists+linux-block@lfdr.de>; Mon, 24 Apr 2023 14:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjDXMbK (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 24 Apr 2023 08:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjDXMbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 08:31:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331B8120;
        Mon, 24 Apr 2023 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l7hQoBJfzkfgPB29S154KGrGt0ixs3oVFi/jSX9Pzms=; b=sjx8klUbwyW5poG4vtt9GHne3M
        IuyC7Pa8loDQwweiLoc92ELtPUZyx8Y42tUlRWkmi+KS7dfAwluiV36VnGBR2M/SrIGpjbF22vMJA
        fCM1/e9rmvocI23ApG30mhO1wQBkljHUh+CKbIyl5bQDqXNwpBmyu8qZgNeWIQrzDN6H755jlAs0Y
        Toyra5f2h2BCeN8TevH1pz8ysOh3rTJ7JqmgtPqbuOBunT5NfKQYVe6DXf3nr/uzVcn3ul4X5UhcH
        HhvUG30dtGsHbTs4kvAre8IQDSsrz8oZGgbcBdRNHAlnoc53J7ERcVSRH1P61KtUHQOB4hTGaITiV
        nwQQzrzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pqvLM-000RHP-Lv; Mon, 24 Apr 2023 12:30:56 +0000
Date:   Mon, 24 Apr 2023 13:30:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] fs: rename and move block_page_mkwrite_return
Message-ID: <ZEZ2gCYFlurJfeDE@casper.infradead.org>
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424054926.26927-4-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 24, 2023 at 07:49:12AM +0200, Christoph Hellwig wrote:
> block_page_mkwrite_return is neither block nor mkwrite specific, and
> should not be under CONFIG_BLOCK.  Move it to mm.h and rename it to
> errno_to_vmfault.

Could you move it about 300 lines down and put it near vmf_error()
so we think about how to unify the two at some point?

Perhaps it should better be called vmf_fs_error() for now since the
errnos it handles are the kind generated by filesystems.

> +++ b/include/linux/mm.h
> @@ -3061,6 +3061,19 @@ extern vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		pgoff_t start_pgoff, pgoff_t end_pgoff);
>  extern vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf);
>  
> +/* Convert errno to return value from ->page_mkwrite() call */
> +static inline vm_fault_t errno_to_vmfault(int err)
> +{
> +	if (err == 0)
> +		return VM_FAULT_LOCKED;
> +	if (err == -EFAULT || err == -EAGAIN)
> +		return VM_FAULT_NOPAGE;
> +	if (err == -ENOMEM)
> +		return VM_FAULT_OOM;
> +	/* -ENOSPC, -EDQUOT, -EIO ... */
> +	return VM_FAULT_SIGBUS;
> +}
> +
>  extern unsigned long stack_guard_gap;
