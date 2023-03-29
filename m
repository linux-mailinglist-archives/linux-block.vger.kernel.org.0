Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666956CD5E9
	for <lists+linux-block@lfdr.de>; Wed, 29 Mar 2023 11:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjC2JFq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Mar 2023 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjC2JFW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 05:05:22 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B31949D5
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680080706; x=1711616706;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ODmg3rPRGn4RIKplIt/ZC9RkflToL9LBuluXecNb92w=;
  b=WASFDijdsO2B4Ra+aEjGEZSEsKqVRH/eJ44iZ8vPtVkolQHNnSaFbsTf
   M7XD0eEcuPCYBYSnYj+nxO8KGTnVDj7iwBW8HP/qCGeaZkFu0bp6vLV/2
   DcQr3KdZls4/jDkDnGZDl4lqGVsJfIuoZKPI6MNq5+R2qB8Ua8UweUSIz
   BJRmznuHW4uKXQ6yfrBlfetEdp/bHMAESpC5Z2adesOrfWX1+yldEle0B
   h253ipSq/28vcKA2aI53/iWSaewFTQ4Ae+ROH0BtEsK4cMfxfgrM+8WOx
   hmqOlRBsUeQjFfr9qdw+6IMhEdHOwhKGOiXfiNAfe5NRIsgIX7AAjbpWn
   g==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="231751504"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 17:04:57 +0800
IronPort-SDR: gcfoZlFEILXJOoVr1+GuSP2fE744QRXjYwlV9EMeMy4Y7BU+MH3i+M7zG+n8LjrPndEYwgp1CX
 +u8qTNGH4wTYso934f16BinylFhXSW4QF8DLj/4tYZ6Fqsp0Jn32lmv6PsxS+LGyLF/pMPJRd0
 O/4+MSOYGDvX0Y6glrbzVmlXSJf0htU+zcrbuyBtL1WVtuXEr4TEl5hHVa68tIdY4ZCT0f6o7v
 K8uLndVdGfBL5W39khgJIX5qg7ohfVPFvAgVVeWv80M1cAj3xz/XhxUAU30os+/hA65EZQM4dz
 BA4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:21:07 -0700
IronPort-SDR: w/nzHCMFJH+lq5f2rvD8htb4Wl+rOfQl9YRAcEZSdAY87a/hgx9OqstDfL0fGDyNlOgEl1+z/E
 eSluJjohRf0up3Na5e4tJv0D4dLwzs6J30h/fTy9BxXarqCxZ74ctzQvs4bgfL9KZDF/8ItLsl
 56lk5MAX/klDsEwNjpVArJCxQcqKJLVYaIApIQn4vU+ZHIiaD2EIpBKWDzzg1hsX5ngAksljZn
 mWdW1Lciy4rM1J+v/SxyJvm723fHoad5qMkopkz7Fsot9LYXMHqiighoLh5paqK4Dx2Fmu2JWR
 b2w=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 02:04:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pmgc91DJMz1RtVx
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 02:04:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680080695; x=1682672696; bh=ODmg3rPRGn4RIKplIt/ZC9RkflToL9LBulu
        XecNb92w=; b=ek9+FWZIOUM0j8FYjqIFGu2FNvtxkIuaUDpxJppjKHuxRxiECWQ
        XX8+9cY4NJDFc1sTz0Kj8xdgnMbR7ze3HQOPBl8wCwLvm7ooyBQdPxzew5n74aAR
        jLo/gnamAnUNSM3d1agXwx7i5C6tGt/n1KgIdKm37YAYwrZ6tArpEUHgUo0zSrSm
        i80nEBbcwNLLSaofPCXt52XW3Y9ZN7jlqRvwG3WXHVUDEmT8mKjWJe8pO5rhaUlc
        EAsZ97xPJtwtkxCBZnIhNor8FWG8jPPbw1Q0EiMXboC6By/Pf5pF8D7UySUycXFP
        R6qGXT6WTVd5lBncEbrqSHvqIooKkMzF7bw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u5SqDFUwnogt for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 02:04:55 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pmgc24vbRz1RtVm;
        Wed, 29 Mar 2023 02:04:50 -0700 (PDT)
Message-ID: <71d9f461-a708-341f-d012-d142086c026e@opensource.wdc.com>
Date:   Wed, 29 Mar 2023 18:04:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 9/9] null_blk: add support for copy offload
Content-Language: en-US
To:     Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230327084103.21601-1-anuj20.g@samsung.com>
 <CGME20230327084331epcas5p2510ed79d04fe3432c2ec84ce528745c6@epcas5p2.samsung.com>
 <20230327084103.21601-10-anuj20.g@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230327084103.21601-10-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/23 17:40, Anuj Gupta wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 
> Implementaion is based on existing read and write infrastructure.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> ---
>  drivers/block/null_blk/main.c     | 94 +++++++++++++++++++++++++++++++
>  drivers/block/null_blk/null_blk.h |  7 +++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 9e6b032c8ecc..84c5fbcd67a5 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1257,6 +1257,81 @@ static int null_transfer(struct nullb *nullb, struct page *page,
>  	return err;
>  }
>  
> +static inline int nullb_setup_copy_read(struct nullb *nullb,
> +		struct bio *bio)
> +{
> +	struct nullb_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
> +
> +	memcpy(token->subsys, "nullb", 5);
> +	token->sector_in = bio->bi_iter.bi_sector;
> +	token->nullb = nullb;
> +	token->sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +
> +	return 0;
> +}
> +
> +static inline int nullb_setup_copy_write(struct nullb *nullb,
> +		struct bio *bio, bool is_fua)
> +{
> +	struct nullb_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
> +	sector_t sector_in, sector_out;
> +	void *in, *out;
> +	size_t rem, temp;
> +	unsigned long offset_in, offset_out;
> +	struct nullb_page *t_page_in, *t_page_out;
> +	int ret = -EIO;
> +
> +	if (unlikely(memcmp(token->subsys, "nullb", 5)))
> +		return -EOPNOTSUPP;
> +	if (unlikely(token->nullb != nullb))
> +		return -EOPNOTSUPP;
> +	if (WARN_ON(token->sectors != bio->bi_iter.bi_size >> SECTOR_SHIFT))
> +		return -EOPNOTSUPP;

EOPNOTSUPP is strange. These are EINVAL, no ?.

> +
> +	sector_in = token->sector_in;
> +	sector_out = bio->bi_iter.bi_sector;
> +	rem = token->sectors << SECTOR_SHIFT;
> +
> +	spin_lock_irq(&nullb->lock);
> +	while (rem > 0) {
> +		temp = min_t(size_t, nullb->dev->blocksize, rem);
> +		offset_in = (sector_in & SECTOR_MASK) << SECTOR_SHIFT;
> +		offset_out = (sector_out & SECTOR_MASK) << SECTOR_SHIFT;
> +
> +		if (null_cache_active(nullb) && !is_fua)
> +			null_make_cache_space(nullb, PAGE_SIZE);
> +
> +		t_page_in = null_lookup_page(nullb, sector_in, false,
> +			!null_cache_active(nullb));
> +		if (!t_page_in)
> +			goto err;
> +		t_page_out = null_insert_page(nullb, sector_out,
> +			!null_cache_active(nullb) || is_fua);
> +		if (!t_page_out)
> +			goto err;
> +
> +		in = kmap_local_page(t_page_in->page);
> +		out = kmap_local_page(t_page_out->page);
> +
> +		memcpy(out + offset_out, in + offset_in, temp);
> +		kunmap_local(out);
> +		kunmap_local(in);
> +		__set_bit(sector_out & SECTOR_MASK, t_page_out->bitmap);
> +
> +		if (is_fua)
> +			null_free_sector(nullb, sector_out, true);
> +
> +		rem -= temp;
> +		sector_in += temp >> SECTOR_SHIFT;
> +		sector_out += temp >> SECTOR_SHIFT;
> +	}
> +
> +	ret = 0;
> +err:
> +	spin_unlock_irq(&nullb->lock);
> +	return ret;
> +}
> +
>  static int null_handle_rq(struct nullb_cmd *cmd)
>  {
>  	struct request *rq = cmd->rq;
> @@ -1267,6 +1342,14 @@ static int null_handle_rq(struct nullb_cmd *cmd)
>  	struct req_iterator iter;
>  	struct bio_vec bvec;
>  
> +	if (rq->cmd_flags & REQ_COPY) {
> +		if (op_is_write(req_op(rq)))
> +			return nullb_setup_copy_write(nullb, rq->bio,
> +						rq->cmd_flags & REQ_FUA);
> +		else

No need for this else.

> +			return nullb_setup_copy_read(nullb, rq->bio);
> +	}
> +
>  	spin_lock_irq(&nullb->lock);
>  	rq_for_each_segment(bvec, rq, iter) {
>  		len = bvec.bv_len;
> @@ -1294,6 +1377,14 @@ static int null_handle_bio(struct nullb_cmd *cmd)
>  	struct bio_vec bvec;
>  	struct bvec_iter iter;
>  
> +	if (bio->bi_opf & REQ_COPY) {
> +		if (op_is_write(bio_op(bio)))
> +			return nullb_setup_copy_write(nullb, bio,
> +							bio->bi_opf & REQ_FUA);
> +		else

No need for this else.

> +			return nullb_setup_copy_read(nullb, bio);
> +	}
> +
>  	spin_lock_irq(&nullb->lock);
>  	bio_for_each_segment(bvec, bio, iter) {
>  		len = bvec.bv_len;
> @@ -2146,6 +2237,9 @@ static int null_add_dev(struct nullb_device *dev)
>  	list_add_tail(&nullb->list, &nullb_list);
>  	mutex_unlock(&lock);
>  
> +	blk_queue_max_copy_sectors_hw(nullb->disk->queue, 1024);
> +	blk_queue_flag_set(QUEUE_FLAG_COPY, nullb->disk->queue);

This should NOT be unconditionally enabled with a magic value of 1K sectors. The
max copy sectors needs to be set with a configfs attribute so that we can
enable/disable the copy offload support, to be able to exercise both block layer
emulation and native device support.

> +
>  	pr_info("disk %s created\n", nullb->disk_name);
>  
>  	return 0;
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index eb5972c50be8..94e524e7306a 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -67,6 +67,13 @@ enum {
>  	NULL_Q_MQ	= 2,
>  };
>  
> +struct nullb_copy_token {
> +	char subsys[5];
> +	struct nullb *nullb;
> +	u64 sector_in;
> +	u64 sectors;
> +};
> +
>  struct nullb_device {
>  	struct nullb *nullb;
>  	struct config_item item;

-- 
Damien Le Moal
Western Digital Research

