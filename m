Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2ED6CF790
	for <lists+linux-block@lfdr.de>; Thu, 30 Mar 2023 01:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjC2Xiz (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Mar 2023 19:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjC2Xin (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 19:38:43 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E524C13
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680133121; x=1711669121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aODFcqxqHz5iuZ9R2+Bd+E8Nkx+iNXfbVHgy68x60n0=;
  b=gwZqchh0bB1gXkom4w9s4I/gVYw3ayfa4/18plUNfDEdfe2VnuH+N7pB
   IKz1qnkyjcal4x/JWMQ/7Kq9S4Kigb7sGcV84qilifQ8ulLVHeiyesWom
   6mOkkruYTwbgGcr7X1g0cvtKQl96QUbYuCizmYjfy2vmJrXnjT7p6ZKfh
   Pe/dIquZfUdJ08RztMb2JhgbiSFcs6sh4GYXG/7zbKu4J8QX1+laoWk3a
   rRQXaekpQ2DgDcuCXlBP2nibvzVU/GrObND9zhR61AAc/iUQZQvCPvHsn
   Awv/vMQkajW8yZWYXpb6cjI/rWzGDf/MZOSHOtj58dugCKsWZsU9HOmT9
   w==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="226828805"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 07:38:40 +0800
IronPort-SDR: Jht62uHN+LVNXDRjhsRwaCwyECraXxZpvOLMZAmE1Aqe1yJfMvh8A5I1j2zSTVpxBkzAqOAXW+
 LtEBjr7ZjhvFXsjLQ6Nyi/QpkgHcVXCLT1ov3byahvav6WL3pZ9DO5H45wcDHYGH4+psiDRxlX
 xkGtgr2Xunpyt9WFQWI/vdkYscdgjbRGVQryKum254D2eEnVBLcQ2NUJKghBYZmwJcwz9rjbfV
 rxmHC9/oaCXCiwqCP7k+CqqFWn77GLy+C9ScPxCFWXzBJpbSKfW1FLoXedmUtmACAFlJFSkezt
 uK8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 15:54:49 -0700
IronPort-SDR: 1S+k3OSLQOhcFiG7wPsspjm9fstA2a3FszOpneDxYAq3yJQXB6jZc7cRAPOEmsZryj7pPxkW04
 Up0Nhjh5iHovtIorvJupyys3n5tmaQKSoHGbJ0vOsD15h0edoS4abTkG+hPpAVudjLUFLNj6CV
 Zk/JjAihH8jv5hjx9965DNsHNb6EKw6alhK8Jzs14WSvzt8orek7Jzp498qiX26tSxtMhbusR3
 JFaZLDhUUngU1rS4IU4wwHPM5g4ac/U5iHhX4kfE9gz4lDLZdvIC9HWmcsH+2MzaRVHoEQtgT7
 KvY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:38:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn30J47bPz1RtW5
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 16:38:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680133119; x=1682725120; bh=aODFcqxqHz5iuZ9R2+Bd+E8Nkx+iNXfbVHg
        y68x60n0=; b=KBjlQKVFv+faQXsHdbboX8Xx9NxcmIm9AdBgDadiYuEI6iU44Gp
        jIKLTOiXkry8UpjbdYwauGh77NnsPrQSFZpCT7/P7YDoBzDw9zAFX+sbYXbItBD4
        Awy5kRAsBzpAxGEQt6/iFRAhFRIvGXb6QP2BKhHdWdA6t/8jyHKIjGtg0XDfA0ep
        9/S+K4tRXJIRFwdQ+UasHvlXj7W7pXISUVz/O/kQ1s0icT+btM6C83LvSU896SWN
        zX3mTR/5AXoqxmQ7Cm4R0QRAsxtuKFEiZ8wGyy7Y6iwGwfe3kKGL98CIKdDi6AJd
        jzR0sEF+xRcPBDw1yJoRYinpIPNolkCqMHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i79Ji72-O03V for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 16:38:39 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn30D5vG4z1RtVn;
        Wed, 29 Mar 2023 16:38:36 -0700 (PDT)
Message-ID: <84d3057f-58b3-b3da-a473-082806c4b5f2@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 08:38:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 16/19] md: raid1: use __bio_add_page for adding single
 page to bio
Content-Language: en-US
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
 <8758569c543389604d8a6a9460de086246fabe89.1680108414.git.johannes.thumshirn@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8758569c543389604d8a6a9460de086246fabe89.1680108414.git.johannes.thumshirn@wdc.com>
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

On 3/30/23 02:06, Johannes Thumshirn wrote:
> The sync request code uses bio_add_page() to add a page to a newly created bio.
> bio_add_page() can fail, but the return value is never checked.
> 
> Use __bio_add_page() as adding a single page to a newly created bio is
> guaranteed to succeed.
> 
> This brings us a step closer to marking bio_add_page() as __must_check.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

