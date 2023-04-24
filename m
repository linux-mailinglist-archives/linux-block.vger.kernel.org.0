Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC26CF830
	for <lists+linux-block@lfdr.de>; Thu, 30 Mar 2023 02:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjC3AYl (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 29 Mar 2023 20:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjC3AYk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 20:24:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F454ED3
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 17:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680135879; x=1711671879;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qt1x7YVxfqzn+HD4mjAgVT20c57AOdxOnsXsCs1FA/w=;
  b=gydNrXFRHEO4IEqpQIaPiJzG/iDR01XK0u3wiKMysbywUxfC85B/sNp3
   WbUtzHlhU+5AEQApE/TM/zQkxpXyNzDYUCLK9naQ11vhI0v3XY6hUY4cI
   Z2St2NnI0LXG0qjgSZVd+sz9Sbsza2d7xdYIx8d0fnfk7brTON8w0REyA
   NMIaSqPEZBsXa6xg3uT/yflogShe8GmHCfKs0aV0N7J9USthhFGcjtCbQ
   0fL+09XEifM0EMAFNNITlSQA8JitcfCfubZhvwO+kT1u9gqW1lvopKxa7
   XGkmcdAMlzHxOZz4BPbJW5+sgvdTC3Kyv0IvFtiVnzUYxx9E3OwaPlWwI
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225116488"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 08:24:38 +0800
IronPort-SDR: eurhvJ7Wj9tPsqTc6xl2Lx378zJB88OCXZs5akwuf2Fg+WTcI0CkM3rfkfLg4pa8FLWgv2bFlw
 9gWIiXOpuZoqBqwm05MuVSe5HoWLshLYKIVPSKEFIE3ujAd+w1OlO5s4AOP9NBlBNEuv3BZXgg
 JI6k6ItzMz9Rjrjj90PlDVcXvIdD3BG8I/JBVQp4vH87DFfxYOfbpUb+nkuOKZoQTQUWGqwT8A
 yhAjhppLiYpP0JYnEVwAiWtpifEucUsU/wEPTs02TllAW46UjitP64fSo7tawkOs9Bu0R5VfZM
 0h4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 16:40:46 -0700
IronPort-SDR: FutNgLK/aI7YvNHwG702nywzBCjKQjmR6AM5VWlVeaRXXq0uzZg6VAS1mZHxqtA1ylnbyfom1l
 0e8EJa3S/nWCrVLNp6ve7gdEPTCljXHSst4EHbBaimxRcIPI8VoBgSHlXMi/Hjtk+5HE3GcQrw
 IYFrNsGUNdHDYIEXQ2bXPiE6FyxLR7an/en4JqS6oEuyiMybJrKhCdulSSa+Sne5wG1TY/vkks
 f67iVUi5wX6VF2V/zmbVOH+98g0lePwE+nyhkgMpq5ZN+GXswNc/K9qwiE6s4SybPFCfTzhQfh
 +fo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 17:24:38 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pn41J356rz1RtW2
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 17:24:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680135875; x=1682727876; bh=Qt1x7YVxfqzn+HD4mjAgVT20c57AOdxOnsX
        sCs1FA/w=; b=QYxDsIVMrmX6uf+9bVUxwnELpwLFtWbRMF/Nt94gTpOQqsLyuHo
        PXJiVZbl3870VsxXn8brpbI6uXwWHk7stsw+5gkioY211aQ4o7Uwst47JscjbQrE
        K99N0ESBwKRwcJ19lOavdNixjywODC+7YTyIWnQWpWiZ7LOJA65a1Dktc5vhkT82
        znVNQgKCEILTiX4ZJrtUa8z6RLlEDM8bBMpnfRTy9OPKQbfOM5lFjJG9REul1WDJ
        YusjXPCg9SHR5Djh+zW5IEAVq4UBPEDGxuvLD8JkqpT7PkTcGPvdn28OEWHZvMVg
        2Mi24TQl4Lz1GQlrFjxVXjdvpPxbmdednfA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PCsuyA0dIBaG for <linux-block@vger.kernel.org>;
        Wed, 29 Mar 2023 17:24:35 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pn41C5RmQz1RtVm;
        Wed, 29 Mar 2023 17:24:31 -0700 (PDT)
Message-ID: <b19696d3-54bb-d997-5e56-aa5fd58b469f@opensource.wdc.com>
Date:   Thu, 30 Mar 2023 09:24:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 18/19] dm-crypt: check if adding pages to clone bio fails
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
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
 <beea645603eccbb045ad9bb777e05a085b91808a.1680108414.git.johannes.thumshirn@wdc.com>
 <3a0f0c92-63cb-3624-c2fe-049a76d1a64a@opensource.wdc.com>
 <CAHbLzkoRdTTbnfz3RyLQAeNJBOEVNGL2WLgRSE2eQ4nR8sRe2g@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAHbLzkoRdTTbnfz3RyLQAeNJBOEVNGL2WLgRSE2eQ4nR8sRe2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/23 09:17, Yang Shi wrote:
> On Wed, Mar 29, 2023 at 4:49=E2=80=AFPM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 3/30/23 02:06, Johannes Thumshirn wrote:
>>> Check if adding pages to clone bio fails and if bail out.
>>
>> Nope. The code retries with direct reclaim until it succeeds. Which is=
 very
>> suspicious...
>=20
> It is not related to bio_add_page() failure. It is used to avoid a
> race condition when two processes are depleting the mempool
> simultaneously.
>=20
> IIUC I don't think page merge may happen for dm-crypt, so is
> __bio_add_page() good enough? I'm working on this code too, using
> __bio_add_page() would make my patch easier.

If the BIO was allocated with enough bvecs, we could use that function. B=
ut page
merging reduces overhead, so if it can happen, let's use it.

>=20
>>
>>>
>>> This way we can mark bio_add_pages as __must_check.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> With the commit message fixed,
>>
>> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>
>>
>> --
>> Damien Le Moal
>> Western Digital Research
>>
>>

--=20
Damien Le Moal
Western Digital Research

