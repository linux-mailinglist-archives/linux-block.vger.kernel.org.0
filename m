Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6FE504D85
	for <lists+linux-block@lfdr.de>; Mon, 18 Apr 2022 10:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbiDRIHC (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Apr 2022 04:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiDRIHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 04:07:00 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51110192A2
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 01:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650269062; x=1681805062;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rpofyDUALxK7dXMfprZ48DmzWqCt1/MYuoJj74ZUCIU=;
  b=Sm4ILGI740qEnKR0/rFY2XB5H15CeEmMVGyRy0vWIe7F6Tm8xcUa/bL/
   l55E3LGwjEd0jWSioX2hNPQAqFucO2tPZUQEUkLQfj5pfJaprxuZ2OCPw
   2cf63bYL/fFZ/EcXD2sWIDjsxs1+UWZhGqGWuqoSgx7P5pGuAcvhSJOeo
   RrmbdM+FFcC3BcgtKoNTL46miAbLoSoczIdistqs4hZG29ogn27Eyz91Z
   K38uNIm8hpYjiW/2y8cR7xZg1pz7nyzqQDaltm5d6KmYz2hai049YQoya
   M6VflcdYcoVp7DhhUFvlLdAtr/UMy9lhnI8U27ec0D9rO+04KoAoqpOge
   w==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; 
   d="scan'208";a="302341881"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:04:20 +0800
IronPort-SDR: hcbg/QOkha3yWG1/eoORVIycTrl2uI6M8Brs+xKmDPYv1/eyvPWOJPmSz8AvNLR2EKNQYH+t+b
 nLCahFqPskIwqAnGa0UWeN5oSaKt4SfLgzPxYqmMn6yofz+TaYdy4p6tYRXWbqsifPlm4jFB4z
 KamEIOhtDDpuZGKrfP5Vcf0DSPP+tPSrLgdMJXEFeivp/MhiQyujRg23DLf6Fv8pFQoiiUPZcS
 DH8HvmH4sQfiMXjKnXcn8QrlV1Hl+nLZO/rPt3d/B4FhYGyjjUF6QZ72CxuYP6lDZaDHsXOyLN
 xDG9QuBp6hzXqGTNKiCX8JlJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 00:35:27 -0700
IronPort-SDR: +CLNZxxjFk/Bm9JG7TMr/ZmgTEelypRf8jvI/0BhmLy2yOzbDCF9W3xDOkxMisFORiT6G9woMQ
 DmD7KNil7wJ47XolrGMzi7la6sus1T9KAB9M04tOQVxGfB2MfkA7u6ZKXK6+i6tYjs/ZGG6QD1
 2wIPMH+maBi6RIX78YtOw7jHhFhWXFtKeZ50Ly6iUIHWCgUDitTyuCp2rrLnr6Dl0zM3y3A32B
 4SQRx6c3XkCh177dUI4TpztNBrzU0/cYuIOLhftsOiTFJc1KZc9hByA4DlNep8iST2T1KchlDt
 7+Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 01:04:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfbP2VNsz1SVpB
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 01:04:17 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650269056; x=1652861057; bh=rpofyDUALxK7dXMfprZ48DmzWqCt1/MYuoJ
        j74ZUCIU=; b=Ipq2PwOMV6FMZnNHjzfOvCDO/eCvkHdBynAyRqHT0JYbL8aPJHg
        lk8/9NE8bxun2r7t0MS14013lawVGOzmf/X3f+8Ic4AvpnDkmhKMyefb2r7esi8c
        DPsaxfOdnQoK+7d4vOoATpt13x1/UJ8S/DPnmNBBwT32S9G+Wy2AQLrr3B49RYi+
        aLZinYUF9RJ+4lF/gqbzoQ5jz3HTqFiUmYZWkVzKfH36FzrmlF6gE6Ej5wqCOTd4
        pLzwGmboJ+p18OsmI93m/uKn1qd+a7S0N7bV75aqhYJOgfIIfT23fOLfPAhxUFLH
        ZzG5axr0DZzGRMD/V2vUJVApf7rh+IIODDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xrcKOZgzBy4F for <linux-block@vger.kernel.org>;
        Mon, 18 Apr 2022 01:04:16 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfbJ6g7Wz1Rwrw;
        Mon, 18 Apr 2022 01:04:12 -0700 (PDT)
Message-ID: <18032025-f1aa-2daa-d012-8996590ada6a@opensource.wdc.com>
Date:   Mon, 18 Apr 2022 17:04:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 08/11] loop: remove a spurious clear of
 discard_alignment
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        linux-nvme@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        Song Liu <song@kernel.org>, dm-devel@redhat.com,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>, linux-s390@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        xen-devel@lists.xenproject.org, linux-um@lists.infradead.org,
        Mike Snitzer <snitzer@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
        linux-block@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
        linux-raid@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-9-hch@lst.de>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/22 13:53, Christoph Hellwig wrote:
> The loop driver never sets a discard_alignment, so it also doens't need
> to clear it to zero.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/loop.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 976cf987b3920..61b642b966a08 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -789,7 +789,6 @@ static void loop_config_discard(struct loop_device *lo)
>  		blk_queue_max_discard_sectors(q, 0);
>  		blk_queue_max_write_zeroes_sectors(q, 0);
>  	}
> -	q->limits.discard_alignment = 0;
>  }
>  
>  struct loop_worker {

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
