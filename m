Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D54B1EDD
	for <lists+linux-block@lfdr.de>; Fri, 11 Feb 2022 07:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiBKG4D (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Feb 2022 01:56:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiBKG4D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 01:56:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B681A3
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 22:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=il1syrPRB9Pd8tLSokGWWx8BPXjdTRfspNTQU9iXkXw=; b=Bt978IhTbEMv9g5NMAIfreUSZn
        AttMgqWcUKERIwVjUE9tlILI4A93LIZWLH6HbJaWlcP6uu/VBiK+o8GAYMT8/20UbffWxu6Fdq84A
        vOrSzILL/G6rdDBJOZupMsc30mQ2xl9OF6CA7PrtCLslQoo3m1nCBCFRJEmBQBOoA4oXsFWwgh2Jl
        0z+HfDEMP+lLS+ZkK2bnZyN5Ykd4Ab/CpOZ4ZGMNsveo2Dr2eYfWRx6QUG/V4RPX6UnSRrpxKXsZJ
        IpS7QAIvLGtj1tMDlOfDoSLvtARFASH01JTRMfhUkQik/voWieOOCkVWLP/WiRnTGFBwwGvKVmDbo
        wuZis1Cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPqb-0061sT-5q; Fri, 11 Feb 2022 06:56:01 +0000
Date:   Thu, 10 Feb 2022 22:56:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/14] dm: remove code only needed before submit_bio
 recursion
Message-ID: <YgYIgZCMfJ5mgA9t@infradead.org>
References: <20220210223832.99412-1-snitzer@redhat.com>
 <20220210223832.99412-8-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210223832.99412-8-snitzer@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>  static void alloc_multiple_bios(struct bio_list *blist, struct clone_info *ci,
>  				struct dm_target *ti, unsigned num_bios,
>  				unsigned *len)
> @@ -1224,14 +1218,14 @@ static void __send_duplicate_bios(struct clone_info *ci, struct dm_target *ti,
>  	case 1:
>  		clone = alloc_tio(ci, ti, 0, len, GFP_NOIO);
>  		if (len)
> -			bio_setup_sector(clone, ci->sector, *len);
> +			clone->bi_iter.bi_size = to_bytes(*len);
>  		__map_bio(clone);
>  		break;
>  	default:
>  		alloc_multiple_bios(&blist, ci, ti, num_bios, len);
>  		while ((clone = bio_list_pop(&blist))) {
>  			if (len)
> -				bio_setup_sector(clone, ci->sector, *len);
> +				clone->bi_iter.bi_size = to_bytes(*len);
>  			__map_bio(clone);
>  		}
>  		break;
> @@ -1350,7 +1344,6 @@ static int __split_and_process_bio(struct clone_info *ci)
>  	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
>  
>  	clone = alloc_tio(ci, ti, 0, &len, GFP_NOIO);
> -	bio_advance(clone, to_bytes(ci->sector - clone->bi_iter.bi_sector));
>  	clone->bi_iter.bi_size = to_bytes(len);

Maybe move the clone->bi_iter.bi_size assignment into alloc_tio as well?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
